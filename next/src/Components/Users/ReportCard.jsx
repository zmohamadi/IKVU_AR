"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useData, useFormRefs,Box, ButtonContainer, Button } from "@/Theme/Midone/Forms";
import { useRouter } from "next/navigation";
import { Tools } from "@/Theme/Midone";

export function ReportCard({id,course,laraPath}){
    const router = useRouter();
    const back = ()=>router.back();
    const {Lang,local} = useLang();
    const {mediaPath} = useConfig();
    const formUrl = "/courses/report-card/"+course+"/"+id ;
    let component = useFormRefs();
    let {get} = useData();
    let url = laraPath+formUrl;

    useEffect(() => {
        get(url, component, "info");
    }, []);
   
//     console.log(component?.state?.info);

    let stu = component?.state?.info?.student;
    let attemps = component?.state?.info?.student?.attemps;
    let assignment_answers = component?.state?.info?.student?.assignment_answers;
    let courseInfo = component?.state?.info?.course;
    let enroll = component?.state?.info?.enroll;

    return <>
        <Box title={Lang(["public.report_card"])}>
                <div className="col-span-12">
                        <div className="flex justify-center">
                                <img src={mediaPath+"/users/"+stu?.pic} alt="Student Image" className="w-32 h-32 rounded-full" />
                        </div>
                        <div className="mt-2">
                                <h2 className="text-xl font-semibold text-gray-800">Student Information</h2>
                                <p className="mt-2 text-gray-700"><span className="font-semibold">Student Name:</span> {stu?.name} {stu?.lname}</p>
                                <p className="mt-2 text-gray-700"><span className="font-semibold">Email:</span> {stu?.email}</p>
                        </div>
                        <div className="mt-2">
                                <h2 className="text-xl font-semibold text-gray-800">Course Information</h2>
                                <p className="mt-2 text-gray-700"><span className="font-semibold">Course Title:</span> {courseInfo?.title}</p>
                        </div>
                        <div className="mt-2">
                                <h2 className="text-xl font-semibold text-gray-800">Grades</h2>
                                <table className="mt-2 w-full">
                                        <thead>
                                        <tr>
                                                <th className="px-4 py-2 text-left">Item</th>
                                                <th className="px-4 py-2 text-left">Date</th>
                                                <th className="px-4 py-2 text-left">Grade</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        {
                                                Tools.getArray(attemps).map((attemp)=>{
                                                        return<>
                                                                <tr>
                                                                        <td className="border px-4 py-2">{attemp?.quiz?.title}</td>
                                                                        <td className="border px-4 py-2">{attemp?.quiz?.start_time_date}</td>
                                                                        <td className="border px-4 py-2">{attemp?.total_score}</td>
                                                                </tr>
                                                        </>

                                                })
                                        }
                                        {
                                                Tools.getArray(assignment_answers).map((answers)=>{
                                                        return<>
                                                                <tr>
                                                                        <td className="border px-4 py-2">{answers?.assignment?.title}</td>
                                                                        <td className="border px-4 py-2">{answers?.assignment?.start_date}</td>
                                                                        <td className="border px-4 py-2">{answers?.score}</td>
                                                                </tr>
                                                        </>

                                                })
                                        }
                                        {/* <tr>
                                                <td className="border px-4 py-2">Exam 2</td>
                                                <td className="border px-4 py-2">2023-04-03 10:11</td>
                                                <td className="border px-4 py-2">20</td>
                                        </tr>
                                        <tr>
                                                <td className="border px-4 py-2">Exam 3</td>
                                                <td className="border px-4 py-2">2023-04-03 10:11</td>
                                                <td className="border px-4 py-2">12</td>
                                        </tr>
                                        <tr>
                                                <td className="border px-4 py-2">Assignment 1</td>
                                                <td className="border px-4 py-2">2023-04-03 10:11</td>
                                                <td className="border px-4 py-2">2</td>
                                        </tr>
                                        <tr>
                                                <td className="border px-4 py-2">Assignment 2</td>
                                                <td className="border px-4 py-2">2023-04-03 10:11</td>
                                                <td className="border px-4 py-2">2</td>
                                        </tr> */}
                                        <tr>
                                                <td colSpan={2} className="border px-4 py-2 text-xl font-semibold text-gray-800">Total Grade</td>
                                                <td className="border px-4 py-2 font-semibold">{enroll?.total_score}</td>
                                        </tr>
                                        </tbody>
                                </table>
                        </div>
                        {/* <div className="mt-4">
                                <h2 className="text-xl font-semibold text-gray-800">Exam Date</h2>
                                <p className="mt-2 text-gray-700"><span className="font-semibold">Exam Date:</span> Exam_Date</p>
                        </div> */}
                </div>
        </Box>
        <ButtonContainer>
                <Button label="back" onClick={back} />
        </ButtonContainer>
            </>;
}