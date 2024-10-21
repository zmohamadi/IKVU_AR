<?php
 
namespace Publics\Resources;
 
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Publics\Resources\AnswerResource;
use \Carbon\Carbon;
use Morilog\Jalali\Jalalian;

class AttempResource extends JsonResource
{
    private $quiz;
    public function __construct($resource, $quiz)
    {
        parent::__construct($resource);
        $this->quiz = $quiz;
    }

    public function toArray(Request $request)
    {
        $data = [
            'quiz_id' => $this->quiz_id,
            'quiz_score' => $this->quiz_score,
            'user_id' => $this->user_id,
            'course_id' => $this->course_id,
            'start_at' => $this->start_at,
            'deadline' => $this->deadline,
            'one_page' => $this->quiz->one_page,
            'use_editor' => $this->quiz->use_editor,
            'limit_time' => $this->quiz->limit_time,
        ];

        // if($data['deadline'] != ""){
        //     $end = Jalalian::fromFormat('Y-m-d H:i:s', $data['deadline'].":59")->toCarbon();
        //     // $end = Carbon::parse($data['deadline'].":59");
        //     $now = Carbon::now()->format('Y-m-d H:i:s');
        //     $data['deadline_time'] = $end->diffInSeconds($now);
        // }
        
        if(isset($this->answers)){
            $data['answers'] = AnswerResource::collection($this->answers);
        }

        return $data;
    }
}