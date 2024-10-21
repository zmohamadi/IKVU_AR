<?php

namespace Api\Controllers\Edu;

use Illuminate\Http\Request;
use Models\Edu\Course;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Controller;
use Illuminate\Validation\Rule;
use OpenApi\Annotations as OA;

/**
 * Class CourseController
 * @package Api\Controllers\Edu
 */
class CourseController extends Controller
{
    /**
     * Store or update courses.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     *
     * @OA\Post(
     *     path="/api/courses",
     *     summary="Create or update courses",
     *     tags={"CourseController"},
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 type="object",
     *                 @OA\Property(
     *                     property="token",
     *                     type="string",
     *                     example="127.0.0.1"
     *                 ),
     *                 @OA\Property(
     *                     property="courses",
     *                     type="array",
     *                     @OA\Items(
     *                         type="object",
     *                         @OA\Property(property="title", type="string", example="اخلاق در خانواده"),
     *                         @OA\Property(property="code", type="string", example="1212"),
     *                         @OA\Property(property="less_id", type="string", example="9876"),
     *                         @OA\Property(property="category_id", type="string", example="1"),
     *                         @OA\Property(property="status", type="string", example="active"),
     *                     )
     *                 ),
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Successful operation",
     *         @OA\JsonContent(
     *             type="array",
     *             @OA\Items(
     *                 @OA\Property(property="title", type="string", description="Course title", example="عرفان اسلامی"),
     *                 @OA\Property(property="code", type="string", description="Course code", example="6678"),
     *                 @OA\Property(property="less_id", type="string", description="Course less_id", example="1234"),
     *                 @OA\Property(property="status_id", type="integer", description="Status ID", example=1),
     *                 @OA\Property(property="system_id", type="integer", description="System ID", example=1),
     *                 @OA\Property(property="category_id", type="integer", description="Category ID", example=1),
     *             )
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
     *                 "title": {"The title field is required."},
     *                 "code": {"The code field is required."},
     *                 "less_id": {"The less_id field is required."},
     *                 "category_id": {"The category_id field is required."},
     *                 "status": {"The status field is required."}
     *             })
     *         )
     *     )
     * )
     */
    public function storeOrUpdate(Request $request)
    {
        $coursesData = $request->input('courses');

        foreach ($coursesData as $data) {
            $status = $data['status'] ?? 'inactive'; // Default to 'inactive' if status is not provided
            $status_id = $status === 'active' ? 1 : 0;

            // Validating input data
            $validator = $this->validateCourseData($data, $data['code'] ?? null, $data['less_id'] ?? null);

            if ($validator->fails()) {
                return response()->json(['errors' => $validator->errors()], 422);
            }

            // Save or update course data
            $courseData = [
                'code' => $data['code'],
                'less_id' => $data['less_id'],
                'status_id' => $status_id,
                'title' => $data['title'] ?? null,
                'system_id' => $data['system_id'] ?? 1,
                'category_id' => $data['category_id'] ?? 1,
            ];

            Course::updateOrCreate(
                ['code' => $data['code'], 'less_id' => $data['less_id']],
                $courseData
            );
        }

        return response()->json(['message' => 'Success'], 200);
    }

    /**
     * Retrieve a list of courses.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     *
     * @OA\Get(
     *     path="/api/courses-index",
     *     summary="Retrieve a list of courses",
     *     tags={"CourseController"},
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
     *                 @OA\Property(property="title", type="string", description="Course title", example="اخلاق در خانواده"),
     *                 @OA\Property(property="code", type="string", description="Course code", example="7563"),
     *                 @OA\Property(property="less_id", type="string", description="Course less_id", example="6543"),
     *                 @OA\Property(property="status_id", type="integer", description="Status ID", example=1),
     *                 @OA\Property(property="system_id", type="integer", description="System ID", example=1),
     *                 @OA\Property(property="category_id", type="integer", description="Category ID", example=1),
     *             )
     *         )
     *     )
     * )
     */
    public function index(Request $request)
    {
        $request->validate([
            'token' => 'required|string',
        ]);

        $courses = Course::select(['title', 'code', 'less_id', 'status_id', 'system_id', 'category_id'])
            ->orderby('id', 'desc')
            ->with('system:id,title', 'category:id,title_fa')
            ->get();

        return response()->json($courses, 200);
    }

    /**
     * Validate course data.
     *
     * @param array $data
     * @param string|null $ignoreCode
     * @param string|null $ignoreLessId
     * @return \Illuminate\Contracts\Validation\Validator
     */
    protected function validateCourseData(array $data, $ignoreCode = null, $ignoreLessId = null)
    {
        return Validator::make($data, [
            'code' => [
                'required',
                'string',
                'max:255',
                Rule::unique('courses', 'code')->ignore($ignoreCode, 'code'),
            ],
            'less_id' => [
                'required',
                'string',
                'max:255',
                Rule::unique('courses', 'less_id')->ignore($ignoreLessId, 'less_id'),
            ],
            'category_id' => 'required|string|max:100',
            'status' => 'required|string|in:active,inactive',
        ]);
    }
}
