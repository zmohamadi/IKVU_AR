<?php
namespace Admin\Controllers\EduTools;

use Admin\Controllers\Public\BaseAbstract;
use Admin\Controllers\Public\PublicController;
use Publics\Controllers\Tools;
use Models\Edu\Survey\Attemp;
use Models\Edu\Survey\Answer;
use Models\Edu\Survey\Question;
use Models\Edu\Survey\QuestionOption;
use Models\Edu\Course;
use Models\Person\User;
use Models\Person\Role;

class SurveyController extends BaseAbstract
{
    protected $model = "Models\Edu\Survey\Survey";
    protected $request = "Publics\Requests\EduTools\SurveyRequest";
    protected $with = ["creator","editor","activeStatus"];
    protected $showWith = ["creator","editor","course","questions.questionOptions","activeStatus"];
    protected $needles = ["Base\QuestionType", "Base\YearSemester",'group'];
    protected $searchFilter = ["title"];
    protected $increment = "surveys";
    protected $decrement = "surveys";

    public function init()
    {
        $this->showQuery = function($query, $before) {
            if (!$before) {
                $query->answer = Answer::where('user_id', $this->user_id)->get();
            }
        };

        $this->storeQuery = function ($query)
        {
            // dd(request()->all());
            $query = $this->setOperator($query);

            $query->group = Tools::setGroup(["semester" => request()->semester, "group" => request()->group_code]);

            $questions = $this->prepareQuestionsWithOptions();
            $no_delete_questions = $this->handleQuestions($questions, $query);

            $query->count_question = count($questions);
            $query->save();

            if (request()->_method == "PUT") {
                Question::where('survey_id', $query->id)->whereNotIn('id', $no_delete_questions)->delete();
                // $items = Question::where('survey_id', $query->id)->whereNotIn('id', $no_delete_questions);
                // $deleted_questions = $items->pluck();
                // $options = QuestionOption::whereIn('question_id', $deleted_questions)->delete();
                // $items->delete();
            }
        };
    }
    /**
     * List Survays based on course and filters.
     * 
     * @param int $course -> request()->course
     * @return \Illuminate\Http\Response
     */
    public function list($course)
    {
        $menuPath = request()->menuPath;
        $collection = $this->filterCollection($course,$menuPath);

        // Return the grid with search filters and additional callback
        $data = json_decode($this->grid($collection, $this->searchFilter)->getContent(), true);
        $data = $this->setAccessOperation($course,$data); // بررسی دسترسی کاربر برای عملیات
        return response()->json($data);
    }

    private function prepareQuestionsWithOptions()
    {
        $options = $this->getRepeatValues(['qOption', 'orderOption']);
        $questions = $this->getRepeatValues(['question', 'order', 'id']);

        // dd($questions);

        foreach ($options as $key => $value) {
            // استخراج ایندکس سوال
            $qIndex = "_" . explode('#', explode("_", $key)[1])[0];
            // استخراج ایندکس گزینه
            $oIndex = str_replace($qIndex . "#", "", $key);

            // ایجاد آرایه گزینه
            $option = [
                'title' => $value['qOption'] ?? '',
                'order' => $value['orderOption'] ?? $oIndex
            ];

            // افزودن شناسه گزینه در صورت وجود
            if (strpos($oIndex, 'id') !== false) {
                $option['id'] = str_replace('id', '', $oIndex);
            }

            // افزودن گزینه به سوال مربوطه
            $questions[$qIndex]['options'][] = $option;
        }
        // dd($questions);
        return $questions;
    }

    private function handleQuestions($questions, $query)
    {
        $no_delete_questions = [];

        foreach ($questions as $q) {
            $item = [
                'title' => $q['question'],
                'question_type_id' => 2,
                'order' => $q['order']
            ];

            if (isset($q['id'])) {
                $question = Question::find($q['id']);
                $question->update($item);
                $no_delete_questions[] = $q['id'];
            } else {
                $question = $query->questions()->create($item);
                $no_delete_questions[] = $question->id;
            }

            $this->handleOptions($q, $question);
        }

        return $no_delete_questions;
    }

    private function handleOptions($question, $questionModel)
    {
        $no_delete_options = [];

        if (isset($question['options'])) {
            foreach ($question['options'] as $option) {
                if (isset($option['id']) && $option['title'] != "") {
                    QuestionOption::where("id", $option['id'])->update(['title' => $option['title']]);
                    $no_delete_options[] = $option['id'];
                } else {
                    $newOption = $questionModel->questionOptions()->create($option);
                    $no_delete_options[] = $newOption->id;
                }
            }

            if (request()->_method == "PUT" && isset($question['id'])) {
                QuestionOption::where('question_id', $question['id'])->whereNotIn('id', $no_delete_options)->delete();
            }
        }
    }
    /**
     * Functions OF Reply By User In Panel : Admin,Student,Techer,...
     */
    public function replyInfo($id)
    {
        $item = $this->model::with("creator","editor","course", "activeStatus")->find($id);
        $course = Course::with("category")->select("id", "title", "code", "category_id", "thumbnail", "description")->find($item->course_id);
        $questions = Question::with(["questionOptions"=>function ($q){ $q->orderBy("order", "ASC"); }])->where('survey_id', $id)->orderBy("order", "ASC")->get();
        $attemp = Attemp::where('survey_id', $id)->where('user_id', $this->user_id)->first();
        $answer = ($attemp==null)? [] : Answer::where('attemp_id', $attemp->id)->pluck("question_option_id", "question_id");
        $result = Tools::checkDateTime(["start_time_date" => $item["start_date"]." 00:00", "end_time_date" => $item["expire_date"]." 00:00"]);
        $data = [
            "item" => $item,
            "course" => $course,
            "questions" => $questions,
            "answer" => $answer,
            "attemp" => $attemp,
            "result" => $result,
            "ISPERSONNEL" => (!in_array($this->role_id, Role::NONPERSONNEL)),
        ];
        return response()->json($data);

    }

    public function replySave($id)
    {
        \DB::beginTransaction();

        try {
            $record = Answer::where('survey_id', $id)->where('user_id', $this->user_id)->get();
            if ($record->isEmpty())
            {
                $attempId = $this->setAttemp();
                $answer = $this->insertAnswer(request()->input(), $attempId);

                PublicController::updateCountResponseSurvey();
                PublicController::updateCountSelectedOption();
            }

            \DB::commit();
        } catch (\Exception $e) {
            \DB::rollBack();
            return response()->json($e->getMessage(), 501);
        }
    }

    private function setAttemp()
    {
        $attempId = Attemp::insertGetId([
            'user_id' => $this->user_id,
            'survey_id' => request()->route('id'),
            'course_id' => request()->course,
            'created_at' => date("Y-m-d h:i:s"),
            'updated_at' => date("Y-m-d h:i:s"),
        ]);
        return $attempId;
    }
    private function insertAnswer($input, $attempId)
    {
        unset($input["course"]);
        $answers = array_map(function ($key, $value) use($attempId) {
            return [
                'attemp_id' => $attempId,
                'user_id' => $this->user_id,
                'survey_id' => request()->route('id'),
                'question_id' => explode("_", $key)[1],
                'question_option_id' => $value,
                'created_at' => now(),
                'updated_at' => now(),
            ];
        }, array_keys($input), $input);

        Answer::insert($answers);
    }
    /**
     * Functions OF Report 
     */
    public function getUsers($id)
    {
        $items = Attemp::with("user.role","user.gender")->where("survey_id", $id)->paginate(50);
        return \Response::json($items);
    }
}
