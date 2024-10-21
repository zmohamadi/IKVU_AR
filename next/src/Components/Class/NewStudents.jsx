"use client";
import { useEffect, useState } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useData, useFormRefs, Input, Button, ButtonContainer, Box, Frame, Radio } from "@/Theme/Midone/Forms";
import { useSearchParams } from 'next/navigation';
import { Toast } from '@/Theme/Midone/Utils/Toast';
import { useUtility } from "@/lib";
import { useRouter } from 'next/navigation';
// import Link from "next/link";

export function NewStudents({ params }) {
    const { Lang } = useLang();
    const { laraAdmin } = useConfig();
    const component = useFormRefs();
    const router = useRouter();

    // Used for component reload!!
    let pload = useSearchParams().get('pload');
    const { reload } = useUtility();
    
    const { save, get, getNeedles } = useData();

    const [students, setStudents] = useState([]);
    const [student, setStudent] = useState({});
    const formUrl = "/classes";
    const id = params?.toolsId;
    const course = params?.id;
    const url = id ? `${laraAdmin}${formUrl}/${id}` : laraAdmin + formUrl;    

    useEffect(() => {
        setStudent({})
        setStudents([])
        get(url, component, "info");
    }, [url, pload]);

    const searchStudent = () => {
        const value = component?.state?.refs?.current?.student_code?.value;
        if (!value) {
            Toast.error(Lang('public.error-422'), Lang('public.dear_user'), 3000);
            return;
        }

        // get(`${laraAdmin}/search-student/${value}/${course}`, component, "students", setStudents);
        getNeedles(`${laraAdmin}/search-student/${value}/${course}-${data?.group}`, setStudents);
    };

    const handleStudentSelection = (selectedStudent) => setStudent(selectedStudent);
    const saveItem = () => save(`${url}/students/new`, component, "save", `/courses/${course}/present/${id}/students/new`,()=>{reload()});
    const back = () => router.back();
    const data = component?.state?.info;

    return (
        <>
            <Frame key={pload}>
                <Box title={Lang('public.register_to_class')}>
                    <div className="font-bold p-2">{Lang('student')}</div>
                    <Input 
                        // required 
                        label=" "
                        placeholder={Lang('public.search_student_for_new_class')}
                        refItem={[component, "student_code"]}
                        onEnter = {searchStudent}
                    />
                    <ButtonContainer className="mt-1">
                        <Button label="search" onClick={searchStudent} />
                    </ButtonContainer>
                </Box>
                {students.length > 0 && (
                    <Box title={Lang('public.list')} cols={1}>
                        <table className="table-auto w-full mt-4 border-collapse border border-gray-300">
                            <thead>
                                <tr>
                                    <th className="border border-gray-300 p-2">ID</th>
                                    <th className="border border-gray-300 p-2">{Lang('public.name')}</th>
                                    <th className="border border-gray-300 p-2">{Lang('public.lname')}</th>
                                    <th className="border border-gray-300 p-2">{Lang('public.email')}</th>
                                    <th className="border border-gray-300 p-2">{Lang('public.mobile')}</th>
                                    <th className="border border-gray-300 p-2"></th>
                                </tr>
                            </thead>
                            <tbody>
                                {students.map((student) => (
                                    <tr key={student.id}>
                                        <td className="border border-gray-300 p-2">{student.id}</td>
                                        <td className="border border-gray-300 p-2">{student.firstname}</td>
                                        <td className="border border-gray-300 p-2">{student.lastname}</td>
                                        <td className="border border-gray-300 p-2">{student.email}</td>
                                        <td className="border border-gray-300 p-2">{student.mobile}</td>
                                        <td className="border border-gray-300 p-2">
                                            {student.userInCourse == null ? (
                                                <Radio 
                                                    id="select" 
                                                    label="select" 
                                                    data={[student.id]} 
                                                    refItem={[component, `student_${student.id}`]} 
                                                    onChange={() => handleStudentSelection(student)} 
                                                    defaultValue="0"
                                                    required 
                                                />
                                            ) : (
                                                <>
                                                    <span className="btn btn-success">
                                                        {Lang('public.registered')}
                                                    </span>
                                                    {/* <Link 
                                                        className="btn btn-danger mr-1" 
                                                        href="" 
                                                        onClick={(e) => {
                                                            e.preventDefault();
                                                            handleDelete(`${laraAdmin}/classes/${id}/students/delete/${student.id}`);
                                                        }}
                                                    >
                                                        {Lang('public.delete')} {Lang('public.membership')}
                                                    </Link> */}
                                                </>
                                            )}
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </Box>
                )}
                {student?.id && (
                    <Box>
                        <Input 
                            label="student" 
                            defaultValue={`${student.firstname} ${student.lastname}`} 
                            refItem={[component, "student"]} 
                        />
                        <Input type="hidden" defaultValue={student.id} refItem={[component, "user_id"]} />
                        <Input 
                            label="class" 
                            defaultValue={`${Lang('public.course')}:${data?.code} - ${Lang('public.group')}:${data?.group}`} 
                            disabled 
                            refItem={[component, "class"]} 
                        />
                        <Input type="hidden" defaultValue={data?.group} refItem={[component, "group"]} />
                        <Input type="hidden" defaultValue={data?.code} refItem={[component, "code"]} />
                        <Input type="hidden" defaultValue={data?.less_id} refItem={[component, "less_id"]} />
                        <Input type="hidden" defaultValue={data?.start_date} refItem={[component, "start_date"]} />
                        <Input type="hidden" defaultValue={data?.end_date} refItem={[component, "end_date"]} />
                    </Box>
                )}
            </Frame>
            <ButtonContainer>
                {student?.id ? (
                    <>
                        <Button label="save" onClick={saveItem} />
                        <Button label="back" onClick={back} />
                    </>
                ) : (
                    <Button label="back" onClick={back} />
                )}
            </ButtonContainer>
        </>
    );
}
