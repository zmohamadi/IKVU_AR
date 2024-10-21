<?php

namespace Admin\Controllers\Edu;

use Admin\Controllers\Public\BaseAbstract;
use Models\Person\Student;
use Models\Person\Teacher;
use Models\Edu\Register;
use Models\Edu\Course;
use Models\Edu\CoursePresented;
use Models\Edu\Inbox\Inbox;
use Models\Edu\Inbox\InboxFile;
use Publics\Controllers\Tools;

class InboxController extends BaseAbstract
{
    protected $model = "Models\Edu\Inbox\Inbox";
    protected $request = "Publics\Requests\Inbox\InboxRequest";
    protected $baseStore = false;
    protected $showWith = ["receiver","files"];
    protected $with = ["creator","editor"];
    protected $increment = "inbox";
    protected $decrement = "inbox";
    protected $listFunction = "inbox";
    protected $searchFilter = ["title"];
    
    public function init()
    {
        $this->storeQuery = function ($query) {
            $query = $this->setOperator($query);    

            $req = request()->all();
            $files = $req['files'] ?? null;
            
            foreach (request()->receivers as $receiver) {
                $receiverData = [
                    'course_id' => request()->course_id,
                    'receiver' => $receiver,
                    'sender' => $this->user_id,
                    'title' => request()->title,
                    'text' => request()->text,
                    'group' => request()->group,
                    'created_at' => now(),
                ];
                
                // Insert the receiver data and get the inserted inbox ID
                $inbox = $this->model::create($receiverData);
                $inboxId = $inbox->id;
        
                // Check if files are not null and create the file entries
                if ($files) {
                    $filesArray = explode("###", $files);
                    $fileData = [];
                    
                    foreach ($filesArray as $file) {
                        if ($file) {
                            $fileData[] = [
                                'name' => $file,
                                'url' => $file,
                                'inbox_id' => $inboxId,
                            ];
                        }
                    }
                    
                    if (!empty($fileData)) {
                        InboxFile::insert($fileData);
                    }
                }
            }
        };
        
        
    }

    public function list(int $course)
    {
        $collection = $this->model::with('sender', 'receiver')->where('course_id', $course);

        // Filter based on user group for teachers or students
        if (in_array($this->role_id, [1, 2])) {
            $group = Tools::userGroup($course, $this->user_id);
            $collection = Tools::conditionGroup(["group" => $group, "collection" => $collection]);
        }

        // Determine message type (default is 'inbox')
        $type = request()->get('type', 'inbox');
        if ($type === 'inbox') {
            $collection->where('receiver', $this->user_id);
        } elseif ($type === 'outbox') {
            $collection->where('sender', $this->user_id);
        }

        // Apply additional filters if the user is neither a teacher nor a student
        if (!in_array($this->role_id, [1, 2])) {
            if (request()->has('semester')) {
                $semester = request()->semester;
                $group = request()->has('group') ? $semester . request()->group : $semester . '%';
                $collection->where('group', 'LIKE', $group);
            }
        }

        // Return the result as a grid with search filters
        return $this->grid($collection, $this->searchFilter);
    }




    public function getNeedle()
    {
        $course = request()->course;
        // Retrieve the user's registration record for the given course
        $userRegister = Register::where(['user_id' => $this->user_id, 'code' => $course])->firstOrFail();
        $group = $userRegister->group;
        // dd($userRegister->role_id);


        // Initialize the users variable
        $users = collect();

        if ($userRegister->role_id == Register::ROLE_STUDENT) {
            // Retrieve the course and its teacher
            $selectCourse = CoursePresented::where(['code' => $course, 'group' => $group])->firstOrFail();
            $users = Teacher::active()->where(['id' => $selectCourse->teacher_person_id, 'group' => $group])->get();
        } else {
            // Retrieve the IDs of students registered for the course and group
            $studentIds = Register::where(['role_id' => Register::ROLE_STUDENT, 'code' => $course, 'group' => $group])->pluck('user_id');
            // dd($group);

            $users = Student::active()->whereIn('id', $studentIds)->get();
        }

        // Return the users as a JSON response
        return response()->json(['users' => $users, 'group' => $group]);
    }

   
    public function replyInfo(int $id)
    {
        $item = $this->model::with("activeStatus")->find($id);
        $course = $this->getCourse($item->course_id);
        // $course = Course::with("category")
        //     ->select("id", "title", "code", "category_id", "thumbnail", "description")
        //     ->find($item->course_id);      

        return response()->json([
            "item" => $item,
            "course" => $course,
        ]);
    }

   
    public function reply(\Publics\Requests\Inbox\ReplyRequest $request, int $id)
    {
       return Inbox::where('id',$id)->update(['reply' => request()->reply]);
        
    }
}
