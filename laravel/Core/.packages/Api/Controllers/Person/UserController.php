<?php

namespace Api\Controllers\Person;

use Illuminate\Http\Request;
use Models\Person\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use App\Http\Controllers\Controller;
use OpenApi\Annotations as OA;

/**
 * Class UserController
 * @package Api\Controllers\Person
 */
class UserController extends Controller
{
    /**
     * Store or update users.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     *
     * @OA\Post(
     *     path="/api/users",
     *     summary="Create or update users",
     *     tags={"UserController"},
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\MediaType(
     *             mediaType="application/json",
     *             @OA\Schema(
     *                 required={"token", "users"},
     *                 @OA\Property(property="token", type="string", example="127.0.0.1"),
     *                 @OA\Property(
     *                     property="users",
     *                     type="array",
     *                     @OA\Items(
     *                         type="object",
     *                         required={"person_id", "firstname", "lastname", "mobile", "email", "password", "role", "gender", "status"},
     *                         @OA\Property(property="person_id", type="integer", example=1),
     *                         @OA\Property(property="firstname", type="string", example="علی"),
     *                         @OA\Property(property="lastname", type="string", example="علوی"),
     *                         @OA\Property(property="mobile", type="string", example="1234567890"),
     *                         @OA\Property(property="photo", type="string", nullable=true),
     *                         @OA\Property(property="email", type="string", format="email", example="john.doe@example.com"),
     *                         @OA\Property(property="password", type="string", example="password123"),
     *                         @OA\Property(property="role", type="string", example="student"),
     *                         @OA\Property(property="gender", type="string", example="male"),
     *                         @OA\Property(property="status", type="string", example="active"),
     *                         @OA\Property(property="studentID", type="string", example="14038899"),
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
     *                 "person_id": {"The person_id field is required."},
     *                 "studentID": {"The studentID field is required."},
     *                 "firstname": {"The firstname field is required."},
     *                 "lastname": {"The lastname field is required."},
     *                 "mobile": {"The mobile field is required."},
     *                 "email": {"The email field is required."},
     *                 "password": {"The password field is required."},
     *                 "role": {"The role field is required."},
     *                 "gender": {"The gender field is required."},
     *                 "status": {"The status field is required."}
     *             }),
     *         ),
     *     ),
     * )
     */
    public function storeOrUpdate(Request $request)
    {
        $token = $request->token;
        $usersData = $request->users;

        $results = [];

        foreach ($usersData as $userData) {
            // Validate input data
            $validator = $this->validateUser($userData);

            if ($validator->fails()) {
                return response()->json(['errors' => $validator->errors()], 422);
            }

            // Determine gender_id based on 'gender' value
            $genderId = ($userData['gender'] === 'male') ? 1 : (($userData['gender'] === 'female') ? 2 : null);

            // Determine status_id based on 'status' value
            $statusId = ($userData['status'] === 'active') ? 1 : 0;

            // Save user data
            $user = User::updateOrCreate(
                ['person_id' => $userData['person_id']],
                [
                    'firstname' => $userData['firstname'],
                    'lastname' => $userData['lastname'],
                    'mobile' => $userData['mobile'],
                    'photo' => $userData['photo'],
                    'email' => $userData['email'],
                    'password' => Hash::make($userData['password']),
                    'role_id' => ($userData['role'] === 'student') ? 2 : 1,
                    'gender_id' => $genderId,
                    'status_id' => $statusId,
                    'studentID' => ($userData['role'] === 'student') ? $userData['studentID'] : null,
                ]
            );

            // Prepare response data
            $results[] = [
                'id' => $user->id,
                'person_id' => $user->person_id,
                'firstname' => $user->firstname,
                'lastname' => $user->lastname,
                'mobile' => $user->mobile,
                'photo' => $user->photo,
                'email' => $user->email,
                'role_id' => $user->role_id,
                'gender_id' => $user->gender_id,
                'status_id' => $user->status_id,
                'studentID' => $user->studentID,
            ];
        }

        return response()->json(['message' => 'successful'], 200);
    }

    /**
     * List all users.
     *
     * @param Request $request
     * @return \Illuminate\Http\JsonResponse
     *
     * @OA\Get(
     *     path="/api/users-index",
     *     summary="List all users",
     *     tags={"UserController"},
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
     *                 @OA\Property(property="id", type="integer", description="User ID", example=1),
     *                 @OA\Property(property="person_id", type="integer", description="Person ID", example=1),
     *                 @OA\Property(property="studentID", type="integer", description="Person ID", example=1234),
     *                 @OA\Property(property="firstname", type="string", description="First name", example="علی"),
     *                 @OA\Property(property="lastname", type="string", description="Last name", example="علوی"),
     *                 @OA\Property(property="mobile", type="string", description="Mobile number", example="1234567890"),
     *                 @OA\Property(property="photo", type="string", description="Photo URL", example="http://example.com/photo.jpg"),
     *                 @OA\Property(property="email", type="string", format="email", description="Email address", example="john.doe@example.com"),
     *                 @OA\Property(property="role_id", type="integer", description="Role ID", example=2),
     *                 @OA\Property(property="status_id", type="integer", description="Status ID", example=1),
     *                 @OA\Property(property="gender_id", type="integer", description="Gender ID", example=1),
     *             ),
     *         ),
     *     ),
     * )
     */
    public function index(Request $request)
    {
        $token = $request->query('token', '127.0.0.1'); // Retrieve the token from query parameters with a default value of "127.0.0.1"

        $response = User::all();

        return response()->json($response, 200);
    }

    /**
     * Validate user data.
     *
     * @param array $data
     * @return \Illuminate\Contracts\Validation\Validator
     */
    protected function validateUser(array $data)
    {
        return Validator::make($data, [
            'person_id' => 'required|integer',
            'firstname' => 'required|string|max:255',
            'lastname' => 'required|string|max:255',
            'mobile' => 'required|string|max:20|unique:users,mobile,' . $data['person_id'] . ',person_id',
            'photo' => 'nullable|string',
            'email' => 'required|email|unique:users,email,' . $data['person_id'] . ',person_id',
            'password' => 'required|string',
            'role' => 'required|string|in:student,teacher',
            'gender' => 'required|string|in:male,female',
            'status' => 'required|string|in:active,inactive',
        ]);
    }
}
