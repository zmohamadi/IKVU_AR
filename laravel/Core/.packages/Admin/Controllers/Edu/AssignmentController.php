<?php

namespace Admin\Controllers\Edu;

use Admin\Controllers\Public\BaseAbstract;
use Illuminate\Http\Request;
use Models\Edu\Assignment\Answer;
use Models\Edu\Assignment\AnswerDetail;
use Models\Edu\Assignment\Option;
use Models\Person\User;
use Publics\Controllers\Tools;
use Admin\Events\Assignment\CorrectedCount;
use Admin\Events\Assignment\Score;
use Admin\Events\StudentScore;
use Admin\Events\CourseScore;
use Models\Edu\Course;

class AssignmentController extends BaseAbstract
{
    protected $model = "Models\Edu\Assignment\Assignment";
    protected $request = "Publics\Requests\Assignment\AssignmentRequest";
    protected $with = ['activeStatus',"questionType"];
    protected $showWith = ['activeStatus', "options","creator","editor"];
    protected $needles = ['Base\QuestionType', 'Base\YearSemester','group'];
    protected $searchFilter = ["title"];
    protected $increment = "assignments";
    protected $decrement = "assignments";

    /**
     * List assignments based on course and filters.
     * 
     * @param int $course
     * @return \Illuminate\Http\Response
     */
    public function list(int $course)
    {
        $menuPath = request()->menuPath;
        $collection = $this->filterCollection($course,$menuPath,['creator', 'questionType']);
        $collection = $collection->orderBy('order');

        $data = json_decode($this->grid($collection, $this->searchFilter)->getContent(), true);
        $pdate = [];
        if($this->roleStu)
        {
            foreach ($data['data'] as $key => $value) {
                if($value['for_students'])
                {
                    // $field = $value['for_students'];
                    $field = json_decode($value['for_students'], true);
                    $isRecord = array_search($this->user_id, array_column($field, 'id'));
                    if($isRecord > -1){
                        $pdate[] = $data['data'][$key]; 
                    }
                }
                else $pdate[] = $data['data'][$key];
            }
            $data['data'] = $pdate;
            $data['to'] = count($pdate);
            $data['total'] = count($pdate);
        }
        return response()->json($data);
    }

    /**
     * Initialize the controller with necessary configurations.
     */
    public function init()
    {
        $this->showQuery = function ($query, $before) {
            if (!$before) {
                $query->time = Tools::compareDateWithToday($query->expire_date);
                $query->for_students = json_decode($query->for_students, true);
                // $query->for_students = ($query->for_students)? json_decode($query->for_students, true) : $query->for_students;
            }
        };

        $this->storeQuery = function ($query) {
            $query->for_students = null;
            if(request()->semester != 0 && request()->group_code != "00" && request()->selectFor == 2)
            {
                $array_students = [];
                $students = User::whereIn("id", request()->students)->get();
                foreach ($students as $key => $value) {
                    $array_students[$key]["id"] = $value->id;
                    $array_students[$key]["fullname"] = $value->firstname." ".$value->lastname;
                    $array_students[$key]["studentID"] = $value->studentID;
                }
                $query->for_students = json_encode(array_values($array_students), JSON_UNESCAPED_UNICODE);    
            }
            $query = $this->setOperator($query);        
            $query->group = Tools::setGroup(["semester" => request()->semester, "group" => request()->group_code]);

            $options = $this->getRepeatValues(["option"]);
            if (request()->_method == "PUT") {
                $correctOption = str_replace("id", "", request()->correctOption);
            } else{
                $correctOption = request()->correctOption;
            }
            $correctId = null;
            $no_delete_options = [];

            if ($options) {
                foreach ($options as $key => $value) {
                    list($optionPrefix, $order) = explode('#', $key);
                    $order = str_replace('_', '', $order);

                    if (strpos($order, "id") > -1) {
                        $optionId = str_replace("id", "", $order);
                        $option = ['title' => $value['option'], 'id' => $optionId];
                    } else {
                        $option = ['title' => $value['option'], 'order' => $order];
                    }

                    if (isset($option['id'])) {
                        if ($option['title'] != "") {
                            Option::where("id", $option['id'])->update(['title' => $option['title']]);
                            $no_delete_options[] = $option['id'];
                            if ($option['id'] == $correctOption) {
                                $correctId = $option['id'];
                            }
                        }
                    } else {
                        if ($option['title'] != "") {
                            $newOption = $query->options()->create($option);
                            $no_delete_options[] = $newOption->id;
                            $correctId = $newOption->id;
                                
                        }
                    }
                }
            }

            if ($correctId) {
                $query->update(['correct_option_id' => $correctId]);
            }

            $query->save();

            if (request()->_method == "PUT") {
                Option::where('assignment_id', $query->id)
                    ->whereNotIn('id', $no_delete_options)
                    ->delete();
            }
        };
    }

    /**
     * Get reply information for a specific assignment.
     * 
     * @param int $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function replyInfo(int $id)
    {
        $item = $this->model::with("activeStatus", "options")
                ->select("id","title","description","correct_option_id","question_type_id","course_id","score","group",
                        "min","max","avg","answer_count","corrected_count","start_date","expire_date","files","to_students")
                ->find($id);
        $course = $this->getCourse($item->course_id);
        $answer = Answer::where(['assignment_id'=>$id,'user_id'=>$this->user_id])->first();
        $answerDetail = ($answer)? AnswerDetail::with("option","userInfo1.gender")->where('answer_id', $answer['id'])->get() : null;
        $result = Tools::checkDateTime([
            "start_time_date" => $item["start_date"] ." 00:00",
            "end_time_date" => $item["expire_date"] ." 23:59",
        ]);

        return response()->json([
            "item" => $item,
            "course" => $course,
            "answer" => $answer,
            "answerDetail" => $answerDetail,
            "result" => $result,
        ]);
    }

    /**
     * Submit or update a reply for a specific assignment.
     * 
     * @param int $id
     * @return \Models\Edu\Assignment\Answer
     */
    public function reply(\Publics\Requests\Assignment\ReplyRequest $request, int $id)
    {
        $assignment = $this->model::find($id); // get info Assignment by $id

        $answerId = null;
        $answer = Answer::where('user_id', $this->user_id)->where('assignment_id', $id)->first(); // get info Answer of Assignment by $id
        // $answerId = ($answer)? $answer['id'] : null;

        $response = request()->response;
        $score = null;
        if (is_numeric($response)) {
            $score = $response == $assignment->correct_option_id ? $assignment->score : 0;
        }
        $answerData = [
            'user_id' => $this->user_id,
            'assignment_id' => $id,
            'course_id' => request()->course_id,
            'score' => $score,
        ];
        if (!$answer)
        {
            $answerNew = Answer::create($answerData);
            $answerId = $answerNew['id'];
            $answer_count = $this->plusAnswerCount($id);
            if($assignment->question_type_id==2){
                $this->plusCorrectedCount($id);
                $this->setMin($id);
                $this->setMax($id);
                $this->setAverage($id);
            }
            // return $answerNew;
        }
        else $answerId = $answer['id'];

        $detail = [
            'user_id' => $this->user_id,
            'answer_id' => $answerId,            
            'answer_option_id' => is_numeric($response) ? $response : null,
            'answer_text' => !is_numeric($response) ? $response : null,
            'files' => request()->response_files,
        ];
        $answerDetail = AnswerDetail::create($detail);
        // return $answerDetail;
    }
    /**
     * Get answers for a specific assignment.
     * 
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function answers(int $id)
    {
        $collection = User::whereHas('assignmentAnswers', function ($q) use ($id) {
            $q->where('assignment_id', $id);
        })->with(['assignmentAnswers' => function ($query) use ($id) {
            $query->where('assignment_id', $id)->with('assignment');
        }]);

        return $this->grid($collection);
    }
    /**
     * Get a specific answer by assignment and user.
     * 
     * @param int $id
     * @param int $user
     * @return \Illuminate\Http\JsonResponse
     */
    public function getAnswer(int $id, int $user)
    {
        $assignment = $this->model::with("options")
                ->select("id","title","description","correct_option_id","question_type_id","course_id","score","group",
                        "min","max","avg","answer_count","corrected_count","start_date","expire_date","files")
                ->find($id);
        $answer = Answer::with("user.gender")->where(['assignment_id'=>$id,'user_id'=>$user])->first();
        $answerDetail = AnswerDetail::with("option","userInfo1.gender")->where('answer_id', $answer['id'])->get();

        return response()->json([
            "assignment" => $assignment,
            "answer" => $answer,
            "answerDetail" => $answerDetail,
        ]);
    }
    /**
     * Set the score for a specific answer.
     * 
     * @param int $answer_id of request
     * @return \Illuminate\Http\JsonResponse
     */
    public function setSeeing()
    {
        $answer = AnswerDetail::where('answer_id', request()->reply)->where('user_id', '<>', $this->user_id)->update(['seeing' => 1]);
    }
    /**
     * Set the score for a specific answer.
     * 
     * @param int $answerId
     * @param int $user
     * @return \Illuminate\Http\JsonResponse
     */
    public function setReply(int $id, int $user)
    {
        // اعتبارسنجی درخواست
        request()->validate([
            'response' => 'required'
        ]);
        $detail = [
            'user_id' => $this->user_id,
            'answer_id' => request()->reply,            
            'answer_text' => request()->response,
        ];
        $answer = AnswerDetail::create($detail);
        return response()->json($answer);
    }
    /**
     * Set the score for a specific answer.
     * 
     * @param int $id
     * @param int $user
     * @return \Illuminate\Http\JsonResponse
     */
    public function setScore(int $id, int $user)
    {
        $score = request()->max;
        // اعتبارسنجی درخواست
        $validatedData = request()->validate([
            'score' => 'required|numeric|lte:'.$score
        ]);
        // پیدا کردن پاسخ کاربر برای تکلیف مشخص شده
        // $answer = Answer::where('assignment_id', $id)->where('user_id', $user)->first();
        $answer = Answer::find(request()->reply);
        $oldScore = $answer->score;
        if ($answer) {
            // بروزرسانی امتیاز
            $answer->update(['score' => $validatedData['score']]);
        }
        if($oldScore==null) $this->plusCorrectedCount($id);
        $this->setMin($id);
        $this->setMax($id);
        $this->setAverage($id);
        // بازگشت پاسخ به عنوان JSON
        return response()->json($answer);
    }
    /**
     * Get Students of a group selection for display & select by user in Form,s assignment.
     * 
     * @param int $group
     */
    public function getStudents()
    {
        $course = request()->course;
        // $year = request()->year;
        $group = request()->year.request()->group;
        $students = User::whereHas('registers', function ($q) use ($course,$group) {
            $q->where("role_id", User::ROLE_STUDENT)->where("code", $course)->where("group", $group);
        })->get();
        return response()->json($students);

    }
    public function plusAnswerCount($id){
        return $this->model::where('id',$id)->increment("answer_count");
    }
    public function plusCorrectedCount($id){
        return $this->model::where('id',$id)->increment("corrected_count");
    }
    public function setMax($id) {
        // پیدا کردن بالاترین نمره
        $maxScore = Answer::where('assignment_id', $id)->max('score');
        
        // به‌روزرسانی فیلد max
        $this->model::where('id', $id)->update(['max' => $maxScore]);
    }
    public function setMin($id) {
        // پیدا کردن پایین‌ترین نمره
        $minScore = Answer::where('assignment_id', $id)->min('score');
        
        // به‌روزرسانی فیلد min
        $this->model::where('id', $id)->update(['min' => $minScore]);
    }
    public function setAverage($id) {
        // پیدا کردن میانگین نمره
        $averageScore = Answer::where('assignment_id', $id)->avg('score');
        
        // به‌روزرسانی فیلد average
        $this->model::where('id', $id)->update(['avg' => $averageScore]);
    }
}
