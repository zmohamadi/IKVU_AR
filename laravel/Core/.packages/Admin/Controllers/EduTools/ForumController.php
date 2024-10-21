<?php

namespace Admin\Controllers\EduTools;

use Admin\Controllers\Public\BaseAbstract;
use Publics\Controllers\Tools;
use Models\Person\Role;
use Models\Edu\Course;
use Models\Edu\Forum\Post;
use Models\Edu\Forum\Like;

class ForumController extends BaseAbstract
{
    protected $model = "Models\Edu\Forum\Forum";
    protected $request = "Publics\Requests\EduTools\ForumRequest";
    protected $with = ["course","creator","activeStatus"];
    protected $showWith = ["course","creator","editor","posts","activeStatus"];
    protected $needles = ['Base\QuestionType', 'Base\YearSemester','group'];
    protected $searchFilter = ["title"];
    protected $increment = "forums";
    protected $decrement = "forums";

    public function init()
    {
        $this->storeQuery = function ($query)
        {
            $query = $this->setOperator($query);
            $query->group = Tools::setGroup(["semester" => request()->semester, "group" => request()->group_code]);
            $query->save();
        };
    }
    /**
     * List Forums based on course and filters.
     * 
     * @param int $course -> request()->course
     * @return \Illuminate\Http\Response
     */
    public function list()
    {
        $course = request()->course;
        
        $collection = $this->filterCollection($course,['course', 'creator']);

        // Return the grid with search filters and additional callback
        $data = json_decode($this->grid($collection, $this->searchFilter)->getContent(), true);
        $data = $this->setAccessOperation($course,$data); // بررسی دسترسی کاربر برای عملیات
        return response()->json($data);
    }
    /**
     * get List Posts NeedCheck of Froum
     */
    public function listNeedCheck()
    {
        $course = request()->course;
        $collection = $this->filterCollection($course,"courses",
            ['uncheckedPosts.parent','uncheckedPosts.sender','uncheckedPosts.type','uncheckedPosts.parentReply','uncheckedPosts.attachments','uncheckedPosts.activeStatus','course','creator'],
            function($query){
                $query->where("count_post_not_check", ">", 0)->select("id","title","course_id","group","count_post_not_check");
            }
        );

        // Assign user role in course registration for access management
        $callback = function ($result) use ($course) {
            foreach ($result as $value) {
                $value->userInCourse = $this->userInCourse($course);
            }
            return $result;
        };

        // Return the grid with search filters and additional callback
        return $this->grid($collection, $this->searchFilter, $callback);
    }
    /**
     * get Info of Froum
     */
    public function showInfo($id)
    {
        $item = $this->model::with($this->showWith)->find($id);
        $course = Course::with("category")->select("id", "title", "code", "category_id", "thumbnail", "description")->find($item->course_id);
        $data = [
            "item" => $item,
            "course" => $course,
            "ISPERSONNEL" => (!in_array($this->role_id, Role::NONPERSONNEL)),
        ];
        return response()->json($data);
    }
    /**
     * get List Posts NeedCheck of Froum
     */
    public function reportForum()
    {
        $subjects = Post::subjects()->with("forum","childs")->get();
        $posts = Post::subjectPosts()->with("forum")->get();
        $votes = Like::get();

        $sub_general = 0;
        $sub_private = 0;
        $sub_need_check = 0;
        $sub_rejected = 0;
        $sub_answered = 0;
        $sub_created_by_teacher = 0;
        $sub_created_by_student = 0;
        $sub_created_by_personnels = 0;
        foreach ($subjects as $key=>$value)
        {
            if($value["type_id"] == 0) $sub_need_check = $sub_need_check+1;
            else if($value["type_id"] == 1) $sub_general = $sub_general+1;
            else if($value["type_id"] == 2) $sub_private = $sub_private+1;
            else if($value["type_id"] == 3) $sub_rejected = $sub_rejected+1;

            if(count($value->childs) > 0) $sub_answered = $sub_answered+1;

            $role_id = Tools::roleOfUser($value["sender_id"], $value->forum["course_id"],  $value->forum["group"]); // اگر فروم مورد نظر برای همه دوره ها باشد شرط فرق میکند؟
            
            if($role_id == 1) $sub_created_by_teacher = $sub_created_by_teacher+1;
            else if($role_id == 2) $sub_created_by_student = $sub_created_by_student+1;
            else if(!in_array($this->role_id, Role::NONPERSONNEL)) $sub_created_by_personnels = $sub_created_by_personnels+1;
        }
        
        $post_general = 0;
        $post_private = 0;
        $post_need_check = 0;
        $post_rejected = 0;
        $post_send_by_teacher = 0;
        $post_send_by_student = 0;
        $post_send_by_personnels = 0;
        foreach ($posts as $key=>$value)
        {
            if($value["type_id"] == 0) $post_need_check = $post_need_check+1;
            else if($value["type_id"] == 1) $post_general = $post_general+1;
            else if($value["type_id"] == 2) $post_private = $post_private+1;
            else if($value["type_id"] == 3) $post_rejected = $post_rejected+1;

            $role_id = Tools::roleOfUser($value["sender_id"], $value->forum["course_id"],  $value->forum["group"]); // اگر فروم مورد نظر برای همه دوره ها باشد شرط فرق میکند؟
            
            if($role_id == 1) $post_send_by_teacher = $post_send_by_teacher+1;
            else if($role_id == 2) $post_send_by_student = $post_send_by_student+1;
            else if(!in_array($this->role_id, Role::NONPERSONNEL)) $post_send_by_personnels = $post_send_by_personnels+1;
        }

        $vote_like = 0;
        $vote_dislike = 0;
        foreach ($votes as $key=>$value)
        {
            if($value["like_type_id"] == 0) $vote_dislike = $vote_dislike+1;
            else if($value["like_type_id"] == 1) $vote_like = $vote_like+1;
        }

        $data = [
            "sub_general" => $sub_general,
            "sub_private" => $sub_private,
            "sub_need_check" => $sub_need_check,
            "sub_rejected" => $sub_rejected,
            "sub_answered" => $sub_answered,
            "sub_created_by_teacher" => $sub_created_by_teacher,
            "sub_created_by_student" => $sub_created_by_student,
            "sub_created_by_personnels" => $sub_created_by_personnels,
            "subjects" => count($subjects),

            "post_general" => $post_general,
            "post_private" => $post_private,
            "post_need_check" => $post_need_check,
            "post_rejected" => $post_rejected,
            "post_send_by_teacher" => $post_send_by_teacher,
            "post_send_by_student" => $post_send_by_student,
            "post_send_by_personnels" => $post_send_by_personnels,
            "posts" => count($posts),

            "vote_like" => $vote_like,
            "vote_dislike" => $vote_dislike,
            "votes" => count($votes),
        ];

        return response()->json($data);
    }
}
