<?php
 
namespace Publics\Resources;
 
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Publics\Resources\QuestionResource;
 
class AnswerResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $data = [
            'id' => $this->id,
            'user_id' => $this->user_id,
            'quiz_attemp_id' => $this->quiz_attemp_id,
            'question_id' => $this->question_id,
            'question_type_id' => $this->question_type_id,
            'course_id' => $this->course_id,
            'answer' => $this->answer,
            'answer_option_id' => $this->answer_option_id,
            // 'score' => $this->score,
        ];
        
        if(isset($this->question)){
            $data['question'] = new QuestionResource($this->question);
        }

        return $data;
    }
}