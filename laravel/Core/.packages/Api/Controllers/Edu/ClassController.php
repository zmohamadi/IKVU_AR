<?php

namespace Api\Controllers\Edu;

use Illuminate\Http\Request;
use Models\Edu\CoursePresented as CourseClass;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Controller;
use OpenApi\Annotations as OA;

/**
 * @OA\Info(title="IKVU LMS Api", version="0.1")
 * Class ClassController
 * @package Api\Controllers\Edu
 */
class ClassController extends Controller
{
    /**
     * Store or update course classes.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     *
     * @OA\Post(
     *     path="/api/classes",
     *     summary="Create or update course classes",
     *     tags={"ClassController"},
     *     @OA\RequestBody(
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 type="object",
     *                 required={"classes"},
     *                 @OA\Property(
     *                     property="token",
     *                     type="string",
     *                     example="127.0.0.1"
     *                 ),
     *                 @OA\Property(
     *                     property="classes",
     *                     type="array",
     *                     @OA\Items(
     *                         type="object",
     *                         required={"code", "year", "semester", "group", "teacher_person_id", "status", "start_date", "end_date", "less_id"},
     *                         @OA\Property(property="code", type="string", description="Parent Class code", example="CS101"),
     *                         @OA\Property(property="year", type="integer", description="Class year", example=1403),
     *                         @OA\Property(property="semester", type="integer", description="Class semester", example=1),
     *                         @OA\Property(property="group", type="integer", description="Group", example=1),
     *                         @OA\Property(property="teacher_person_id", type="integer", description="Teacher Person ID", example=10),
     *                         @OA\Property(property="status", type="string", example="active"),
     *                         @OA\Property(property="start_date", type="string", format="date", description="Start date", example="1403-06-10"),
     *                         @OA\Property(property="end_date", type="string", format="date", description="End date", example="1403-10-25"),
     *                         @OA\Property(property="less_id", type="integer", description="Course less_id", example=1001)
     *                     )
     *                 )
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Successful operation",
     *         @OA\JsonContent(
     *             type="object",
     *             @OA\Property(property="message", type="string", example="successful")
     *         )
     *     ),
     *     @OA\Response(
     *         response=422,
     *         description="Validation error",
     *         @OA\JsonContent(
     *             @OA\Property(property="errors", type="object", additionalProperties=@OA\Property(
     *                 type="array",
     *                 @OA\Items(type="string")
     *             ), example={
     *                 "code": {"The code field is required."},
     *                 "year": {"The year field is required."},
     *                 "semester": {"The semester field is required."},
     *                 "group": {"The group field is required."},
     *                 "teacher_person_id": {"The teacher_person_id field is required."},
     *                 "status": {"The status field is required."},
     *                 "start_date": {"The start_date field is required."},
     *                 "end_date": {"The end_date field is required."},
     *                 "less_id": {"The less_id field is required."}
     *             })
     *         )
     *     )
     * )
     */
    public function storeOrUpdate(Request $request)
    {
        $classesData = $request->input('classes');

        foreach ($classesData as $data) {
            // Setting status_id based on status
            $status_id = ($data['status'] === 'active') ? 1 : 0;

            // Validating input data
            $validator = $this->validateClassData($data);

            if ($validator->fails()) {
                return response()->json(['errors' => $validator->errors()], 422);
            }

            // Prepare data for storing/updating
            $classData = [
                'code' => $data['code'],
                'less_id' => $data['less_id'],
                'group' => $data['year'].$data['semester'].$data['group'],
                'teacher_person_id' => $data['teacher_person_id'],
                'status_id' => $status_id,
                'start_date' => $data['start_date'],
                'end_date' => $data['end_date'],
                'system_id' => $request->system_id ?? 1,
            ];

            // Update or create course class
            CourseClass::updateOrCreate(
                ['less_id' => $data['less_id']],
                $classData
            );
        }

        return response()->json(['message' => 'successful'], 200);
    }

    /**
     * Validate class data.
     *
     * @param array $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    protected function validateClassData(array $data)
    {
        return Validator::make($data, [
            'code' => 'required|string|max:100',
            'year' => 'required|integer',
            'semester' => 'required|integer',
            'group' => 'required|integer',
            'teacher_person_id' => 'required|integer',
            'status' => 'required|string|in:active,inactive',
            'start_date' => 'required|date',
            'end_date' => 'required|date',
            'less_id' => 'required|integer',
        ]);
    }

    /**
     * Retrieve a list of classes.
     *
     * @return \Illuminate\Http\JsonResponse
     *
     * @OA\Get(
     *     path="/api/classes-index",
     *     summary="Retrieve a list of classes",
     *     tags={"ClassController"},
     *     @OA\Parameter(
     *         name="token",
     *         in="query",
     *         required=true,
     *         @OA\Schema(type="string", example="127.0.0.1")
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Successful operation",
     *         @OA\JsonContent(
     *             type="array",
     *             @OA\Items(
     *                 @OA\Property(property="code", type="string", description="Class code", example="CS101"),
     *                 @OA\Property(property="year", type="integer", description="Class year", example=1403),
     *                 @OA\Property(property="semester", type="integer", description="Class semester", example=1),
     *                 @OA\Property(property="group", type="integer", description="Group", example=1),
     *                 @OA\Property(property="teacher_person_id", type="integer", description="Teacher Person ID", example=10),
     *                 @OA\Property(property="status_id", type="integer", description="Status ID", example=1),
     *                 @OA\Property(property="start_date", type="string", format="date", description="Start date", example="1403-06-10"),
     *                 @OA\Property(property="end_date", type="string", format="date", description="End date", example="1403-10-25"),
     *                 @OA\Property(property="less_id", type="integer", description="Course ID", example=1001),
     *             )
     *         )
     *     )
     * )
     */
    public function index(Request $request)
    {
        $token = $request->query('token', '127.0.0.1'); // Retrieve the token from query parameters with a default value of "127.0.0.1"

        // You can add token validation or usage logic here if needed

        $classes = CourseClass::all(); // Retrieve all classes from the database

        return response()->json($classes, 200);
    }
}
