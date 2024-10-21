<?php
namespace Admin\Controllers\Public;

use App\Http\Controllers\Controller;
use Admin\Controllers\Public\EMail;
use Illuminate\Support\Facades\Mail;

class PublicController extends Controller
{
    /**
     * get records condition a field
    */
    public static function getRecords($model = "", $field = "", $field_value = "", $operator = "=")
    {
        $m = ucfirst($model);
        $m = str_replace('-', '\\', $m);
        $className = 'Models\\' . $m;
        $records = $className::active();
        if ($field != "") {
            $records = $records->where($field, $operator, $field_value);
        }
        $records = $records->get();

        return $records;
    }
    /**
     * show info a record
    */
    public static function showInfoRecord($model="", $id="", $field="")
    {
        $m = ucfirst($model);
        $m = str_replace('-','\\',$m);
        $className = 'Models\\' . $m;
        $record = $className::where('id', $id)
            ->select('id', $field)
            ->first()
            ;
        return $record;
    }
    /**
     * update info a record
    */
    public static function updateRecord($model, $id, $field, $request_value)
    {
        $m = ucfirst($model);
        $m = str_replace('-','\\',$m);
        $className = 'Models\\' . $m;
        $modelObj =  new $className;
        $record = $modelObj->find($id);
        // $record->$field = $request_value;
        // $record->update();
        $record->update([$field=>$request_value]);
        return $record;
    }
    /**
     * insert in table Keyword
    */
    public static function insertNewKeyword($obj)
    {
        $lang = request()->lang;
        $keys = explode("-", request()->keywords);
        foreach($keys as $key)
        {
            if($key != '')
            {
                $check_keyword = \Models\Base\Keyword::where("title", $key)->select("id")->first();
                if($check_keyword)
                {
                    $obj->keywords()->attach($check_keyword->id);
                }
                else
                {
                    $new_keyword = new \Models\Base\Keyword();
                    $new_keyword->title = $key;
                    $new_keyword->lang = $lang;
                    $new_keyword->save();
                    $obj->keywords()->attach($new_keyword->id);
                }
            }
        }
        return $obj;
    }
    /**
     * get provinces a country for use in Select2
     */
    public function getProvince()
    {
        $country_id = request()->country_id;
        $pro = \Models\Base\Province::with(["cities" => function($q)
        {
            $q->active();
        }])
        ->where("country_id", $country_id)
        ->get()
        ;
        return \Response::json($pro);
    }

    public function plusCourseTools($id,$field){
        return \Models\Edu\Course::where('id',$id)->increment($field);
    }

    public function sendEmail($email,$view)
    {
        // if($request->email) $this->sendEmail($request->email);
        \Mail::to($email)->queue(new EMail($email,$view));
    }
    // public function email()
    // {
    //     $email = "afgwomen@afg-womens-academy.org";
    //     return $this->view('views::emails.sample')->with(compact('email'));
    // }

    /**
     * Get Role User In Course
     */
    /**
     * Update field count_response of tables surveys
     */
    public static function updateCountResponseSurvey()
    {
        \DB::update("UPDATE surveys SET `count_response` =
            (SELECT count(survey_attemp.survey_id) FROM survey_attemp
                WHERE survey_attemp.survey_id = surveys.id AND survey_attemp.deleted_at IS null)");
    }
    /**
     * Update field count_selected of tables surveys
     */
    public static function updateCountSelectedOption()
    {
        \DB::update("UPDATE survey_question_options SET `count_selected` =
            (SELECT count(survey_answer.question_option_id) FROM survey_answer
                WHERE survey_answer.question_option_id = survey_question_options.id AND survey_answer.deleted_at IS null)");
    }
    /**
     * Update field count_post of tables forums
     */
    public static function updateCountPost()
    {
        \DB::update("UPDATE forums SET `count_post` =
            (SELECT count(forum_posts.forum_id) FROM forum_posts
                WHERE forum_posts.forum_id = forums.id AND forum_posts.deleted_at IS null)");
    }
    /**
     * Update field count_post_not_check of tables forums
     */
    public static function updateCountPostNotCheck()
    {
        \DB::update("UPDATE forums SET `count_post_not_check` =
            (SELECT count(forum_posts.forum_id) FROM forum_posts
                WHERE forum_posts.forum_id = forums.id AND forum_posts.type_id = 0 AND forum_posts.deleted_at IS null)");
    }
    /**
     * Update field count_post_parent of tables forums
     */
    public static function updateCountPostParent()
    {
        \DB::update("UPDATE forums SET `count_post_parent` =
            (SELECT count(forum_posts.forum_id) FROM forum_posts
                WHERE forum_posts.forum_id = forums.id AND forum_posts.parent_id = 0 AND forum_posts.deleted_at IS null)");
    }
    /**
     * Update field count_like of tables forum_posts
     */
    public static function updateCountLike()
    {
        \DB::update("UPDATE forum_posts SET `count_like` =
            (SELECT count(forum_likes.post_id) FROM forum_likes
                WHERE forum_likes.post_id = forum_posts.id AND forum_likes.like_type_id = 1 AND forum_likes.deleted_at IS null)");
    }
    /**
     * Update field count_dislike of tables forum_posts
     */
    public static function updateCountDisLike()
    {
        \DB::update("UPDATE forum_posts SET `count_dislike` =
            (SELECT count(forum_likes.post_id) FROM forum_likes
                WHERE forum_likes.post_id = forum_posts.id AND forum_likes.like_type_id = 0 AND forum_likes.deleted_at IS null)");
    }
    /**
     * Update field count_dislike of tables forum_posts
     */
    public static function updateCountAttachment()
    {
        \DB::update("UPDATE forum_posts SET `count_attachment` =
            (SELECT count(forum_attachments.post_id) FROM forum_attachments
                WHERE forum_attachments.post_id = forum_posts.id AND forum_attachments.deleted_at IS null)");
    }
}