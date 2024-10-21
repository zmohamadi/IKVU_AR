<?php
 
namespace Publics\Resources;
 
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Publics\Resources\QuestionOptionResource;
 
class QuestionResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        $data = [
            'id' => $this->id,
            'title' => $this->title,
            'order' => $this->order,
            'question_type_id' => $this->question_type_id,
            'score' => $this->score,
        ];
        
        if(isset($this->questionOptions)){
            $data['questionOptions'] = QuestionOptionResource::collection($this->questionOptions->sortBy('order'));
        }

        return $data;
    }
}