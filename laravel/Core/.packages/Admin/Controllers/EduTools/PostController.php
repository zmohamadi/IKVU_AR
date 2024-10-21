<?php

namespace Admin\Controllers\EduTools;

use Admin\Controllers\Public\BaseAbstract;
use Admin\Controllers\Public\PublicController;
use Publics\Controllers\Tools;
use Models\Person\Role;
use Models\Person\User;
use Models\Edu\Forum\Forum;
use Models\Edu\Forum\Like;

class PostController extends BaseAbstract
{
    protected $model = "Models\Edu\Forum\Post";
    protected $request = "Publics\Requests\EduTools\PostRequest";
    protected $with = ["sender","type","parentReply","attachments","activeStatus"];
    protected $showWith = ["sender","type","attachments","activeStatus"];
    // protected $searchFilter = ["title"];
    protected $files = [
        "upload_file"=>[ "model"=>"Models\Edu\Forum\Attachment", "url"=>"/../public_html/media/forum", "file_category_id"=>"1", "fk"=>"post_id"],
    ];

    public function init()
    {
        $this->storeQuery = function ($query)
        {
            if(request()->_method != "PUT") // زمان ثبت گفتگو
            {
                $query->sender_id = $this->user_id;
                $query->type_id = $this->insertTypePost([ "course"=>$query->forum['course_id'], "need_to_apply"=>$query->forum['need_to_apply'] ]);
            }
            // $query->count_attachment = count(request()->upload_file); // کد نیاز به بررسی بیشتر و بهتر دارد.
            $query->save();
            /**
             * Update Fields For Insert Counts Of Post
             */
            PublicController::updateCountPost();
            PublicController::updateCountPostNotCheck();
            PublicController::updateCountPostParent();
            PublicController::updateCountAttachment();
             /**
             * Update Fields `last_post_id` & `last_post` Of tabels `forums` & `forum_posts`
             */
            if(request()->_method != "PUT") // زمان ثبت گفتگو
            {
                $forum_id = request()->forum_id;
                $parent_id = request()->parent_id;
                $last_post = $this->user->firstname." ".$this->user->lastname."&nbsp".$query->created_at;
                $last_post_info = ["last_post_id"=> $query->id, "last_post"=> $last_post];
                if($parent_id > 0) $query->parent->update($last_post_info);
                $query->forum->update($last_post_info);
                $this->getLastPostGeneral($query->id);
            }
        };
    }
    /**
     * List Survays based on course and filters.
     * 
     * @param int $course -> request()->course
     * @return \Illuminate\Http\Response
     */
    public function list()
    {
        $course = request()->course;
        $forum_id = request()->forum;
        $post_id = request()->post;
        $condition = request()->type;
        // بروز رسانی فیلد count_view برای جدول گفتگوها رکوردهای parent_id=0 هستند (موضوعات)
        if($condition == "allOnePost")
        {
            $this->incrementCountView($post_id);
        }
        $userInCourse = $this->userInCourse($course);

        $collection = $this->model::with("sender","type","parentReply","attachments","activeStatus")->$condition($forum_id, $post_id);

        $collection = (in_array($userInCourse, Role::POSTNEEDCHACK))?
            $collection->where(function($q){ $q->where("sender_id", $this->user_id)->orWhere("type_id", 1); })->orderBy("id", "ASC")
        :
            $collection->orderBy("id", "ASC");
                    
        // Assign user role in course registration for access management
        $callback = function ($result) use ($userInCourse) {
            foreach ($result as $value) {
                // $like_user = \Models\Edu\Forum\Like::where("user_id", $this->user_id)->where("post_id", $value["id"])->select("like_type_id")->first();
                
                $like_post = \Models\Edu\Forum\Like::where("post_id", $value["id"]);
                $like_users = $like_post->with("user")->get(); // All Users That Select Like Or DisLike
                $like_user = $like_post->where("user_id", $this->user_id)->select("like_type_id")->first(); // A User Logined That Select Like Or DisLike
                
                if($like_user) $value["myAction"] = $like_user["like_type_id"];                
                $value["likeUsers"] = $like_users;                
                // $value["userInCourse"] = $userInCourse;
            }
            return $result;
        };

        // Return the grid with search filters and additional callback
        $data = json_decode($this->grid($collection, $this->searchFilter, $callback)->getContent(), true);
        $data = $this->setAccessOperation($course,$data); // بررسی دسترسی کاربر برای عملیات
        if(count($data["data"]) > 0)
        {
            $forum = Forum::find($data["data"][0]["forum_id"]);
            $data['lock'] = $forum->lock;
        }
        return response()->json($data);
    }
    /**
     * Check Role & Group && return Value Field `type_id` For `need_to_apply`
     */
    public function insertTypePost($info)
    {
        $userInCourse = $this->userInCourse($info["course"]);
        $type_id = 1;
        if($info["need_to_apply"] && in_array($userInCourse, Role::POSTNEEDCHACK)) $type_id = 0;
        return $type_id;
    }
    public function getLastPostGeneral($id)
    {
        /**
         * get Post And Info For where
         */
        $post = $this->model::find($id);
        $forum_id = $post->forum_id;
        $parent_id = $post->parent_id;
        /**
         * get Post By where `forum_id` And Create stament For LastPost
         */
        $post_forum = $this->model::where("forum_id", $forum_id)->where("type_id", 1)->orderBy("created_at", "DESC")->first();
        if($post_forum)
        {
            $sender_post_forum = User::find($post_forum["sender_id"]);
            $last_post_forum = $sender_post_forum->firstname." ".$sender_post_forum->lastname."&nbsp".$post_forum->created_at;
            /**
             * find Forum And Update `last_post_general_id` & `last_post_general`
             */
            $forum = Forum::find($forum_id);
            $forum->last_post_general_id = $post_forum["id"];
            $forum->last_post_general = $last_post_forum;
            $forum->update();
        }
        /**
         * Steps Of Forum (that in top Done) For Post
         */
        if($parent_id > 0)
        {
            $post_parent = $this->model::where("parent_id", $parent_id)->where("type_id", 1)->orderBy("created_at", "DESC")->first();
            if($post_parent)
            {
                $post_parent_sender = User::find($post_parent["sender_id"]);
                $last_post_parent = $post_parent_sender->firstname." ".$post_parent_sender->lastname."&nbsp".$post_parent->created_at;
        
                $parent = $this->model::find($parent_id);
                $parent->last_post_general_id = $post_parent["id"];
                $parent->last_post_general = $last_post_parent;
                $parent->update();
            }
        }
    }
    /**
     * Update Field `count_view` of tabels `forum_posts`; For Records that Is Field `parent_id`==0 (Subjects of Posts)
     */
    public function incrementCountView($post_id)
    {
        $count_post = $this->getCount();
        if(!isset($count_post["post_count_view-".$post_id]))
        {
            $count_view = $this->updateCount($post_id);
            $count_post["post_count_view-".$post_id] = $count_view;
            $this->saveCount($count_post);
        }
        // if(!is_array($count_post)) $count_post = [];
        // if(!isset($count_post["post-".$post_id]))
        // {
        //     $count_view = $this->updateCount($post_id);
        //     $count_post["post-".$post_id] = ["count_view"=>$count_view];
        //     $this->saveCount($count_post);
        // }
    }
    public function getCount() // of \Session
    {
        return session()->get("count_post");
    }
    public function saveCount($count) // in \Session
    {
        session(['count_post' => $count]);
    }
    public function updateCount($post_id) // in Tabels
    {
        $get_post = $this->model::find($post_id);
        $get_post->count_view = $get_post->count_view+1;
        $get_post->save();
        return $get_post->count_view;
    }
    /**
     * Update Field `type_id` of tabels `forum_posts`
     */
    public function getStatus()
    {
        $status = PublicController::getRecords('Base-Status', 'group_id', 4);
        return \Response::json($status);
    }
    public function updateStatus($id)
    {
        $type_id = request()->type_id;
        PublicController::updateRecord('Edu-Forum-Post', $id, "type_id", $type_id);
        PublicController::updateCountPostNotCheck();
        $this->getLastPostGeneral($id);
    }
    /**
     * Insert Action Users to Posts
     */
    public function saveAction($id)
    {        
        \DB::beginTransaction();

        try {
            $record = Like::where('post_id', $id)->where('user_id', $this->user_id)->get();
            if ($record->isEmpty())
            {
                $record = [
                    'post_id' => $id,
                    'user_id' => $this->user_id,
                    'like_type_id' => request()->type,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
                Like::insert($record);
                (request()->type==1)? PublicController::updateCountLike() : PublicController::updateCountDisLike();
            }
            else
            {
                // return \Response::json("Your verification was successful and the email was sent to the ".$mentee->name." ".$mentee->lname);
                return \Response::json(["status"=>403]);
            }

            \DB::commit();
        } catch (\Exception $e) {
            \DB::rollBack();
            return response()->json($e->getMessage(), 501);
        }
    }
}
