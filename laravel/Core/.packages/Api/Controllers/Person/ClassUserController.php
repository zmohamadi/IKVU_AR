<?php

namespace Api\Controllers\Person;

use Illuminate\Http\Request;
use Models\Edu\Register;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Controller;
use OpenApi\Annotations as OA;

/**
 * Class ClassUserController
 * @package Api\Controllers\Person
 */
class ClassUserController extends Controller
{
    /**
     * Store or update class users.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     *
     * @OA\Post(
     *     path="/api/class-users",
     *     summary="Create or update class users",
     *     tags={"ClassUserController"},
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 required={"token", "classUsers"},
     *                 @OA\Property(property="token", type="string", example="127.0.0.1"),
     *                 @OA\Property(
     *                     property="classUsers",
     *                     type="array",
     *                     @OA\Items(
     *                         type="object",
     *                         required={"user_id", "code", "year", "semester", "group", "status", "start_date", "end_date", "title", "main_code", "less_id"},
     *                         @OA\Property(property="user_id", type="integer", example=123),
     *                         @OA\Property(property="code", type="string", example="CS101"),
     *                         @OA\Property(property="year", type="integer", example=1403),
     *                         @OA\Property(property="semester", type="integer", example=1),
     *                         @OA\Property(property="group", type="integer", example=01),
     *                         @OA\Property(property="status", type="string", example="active"),
     *                         @OA\Property(property="start_date", type="string", format="date", example="1403/06/10"),
     *                         @OA\Property(property="end_date", type="string", format="date", example="1403/10/25"),
     *                         @OA\Property(property="title", type="string", example="فلسفه"),
     *                         @OA\Property(property="main_code", type="string", example="CS101"),
     *                         @OA\Property(property="less_id", type="integer", example=1001),
     *                         @OA\Property(property="role", type="string", example="student"),
     *                     )
     *                 ),
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
     *                 "user_id": {"The user_id field is required."},
     *                 "code": {"The code field is required."},
     *                 "year": {"The year field is required."},
     *                 "semester": {"The semester field is required."},
     *                 "group": {"The group field is required."},
     *                 "status": {"The status field is required."},
     *                 "start_date": {"The start_date field is required."},
     *                 "end_date": {"The end_date field is required."},
     *                 "title": {"The title field is required."},
     *                 "main_code": {"The main_code field is required."},
     *                 "less_id": {"The less_id field is required."}
     *             })
     *         )
     *     ),
     * )
     */
    public function storeOrUpdate(Request $request)
    {
        $token = $request->token;
        $classUsersData = $request->classUsers;

        $results = [];

        foreach ($classUsersData as $data) {
            // Validate input data
            $validator = $this->validateClassUser($data);

            if ($validator->fails()) {
                return response()->json(['errors' => $validator->errors()], 422);
            }

            // Set status_id based on status
            $status_id = ($data['status'] === 'active') ? 1 : 0;

            // Save class user data
            $register = Register::updateOrCreate(
                ['less_id' => $data['less_id'], 'user_id' => $data['user_id']],
                [
                    'code' => $data['code'],
                    'group' => $data['year'].$data['semester'].$data['group'],
                    'status_id' => $status_id,
                    'start_date' => $data['start_date'],
                    'end_date' => $data['end_date'],
                    'title' => $data['title'],
                    'main_code' => $data['main_code'],
                    'role_id' => ($data['role'] == "student")? 2 : 1
                ]
            );

            // Prepare response data
            $results[] = [
                'id' => $register->id,
                'user_id' => $register->user_id,
                'code' => $register->code,
                'group' => $register->group,
                'status' => $data['status'],
                'start_date' => $register->start_date,
                'end_date' => $register->end_date,
                'title' => $register->title,
                'main_code' => $register->main_code,
                'less_id' => $register->less_id,
                'role' => $register->role
            ];
        }

        return response()->json(['message' => 'successful'], 200);
    }

    /**
     * Validate class user data.
     *
     * @param array $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    protected function validateClassUser(array $data)
    {
        return Validator::make($data, [
            'user_id' => 'required|integer',
            'code' => 'required|string|max:100',
            'group' => 'required',
            'status' => 'required|string|in:active,deactive',
            'start_date' => 'required|date',
            'end_date' => 'required|date',
            'title' => 'required|string|max:255',
            'main_code' => 'required|string|max:100',
            'less_id' => 'required|integer',
            'role' => 'string|in:student,teacher'
        ]);
    }
}
