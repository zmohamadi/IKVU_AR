<?php
 
namespace Publics\Resources;
 
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Publics\Resources\QuestionResource;
 
class QuizResource extends JsonResource
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
            'title' => $this->title,
            'description' => $this->description,
            'course_id' => $this->course_id,
            'start_time_date' => $this->start_time_date,
            'end_time_date' => $this->end_time_date,
            'limit_time' => $this->limit_time,
            'one_page' => $this->one_page,
        ];
        
        if(isset($this->questions)){
            $data['questions'] = ($this->randomize == "1") ? 
                QuestionResource::collection($this->questions->shuffle())
                : QuestionResource::collection($this->questions->sortBy('order'));
        }

        return $data;
    }
}