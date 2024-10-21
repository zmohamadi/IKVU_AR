"use client";

import { useRouter } from 'next/navigation';
import { useLang } from '@/lib';
import { useData, useFormRefs, ButtonContainer, Button, Radio, Textarea, Input, Box } from "@/Theme/Midone/Forms";
import { Dropzone } from "@/Theme/Midone/Forms/Dropzone";

export function FormDescriptive({ id, course, laraPath, nextPath = "", answer, saveUrl=`/assignment/reply/${id}`, backUrl=""}) {
    const { Lang } = useLang();
    let { save } = useData();
    let component = useFormRefs();
    const router = useRouter();
    let uploadUrl=laraPath+"/upload/.-media-assignmentAnswer";
    let deleteUrl=laraPath+"/deleteFile/.-media-assignmentAnswer";

    // let url = `${laraPath}/assignment/reply/${id}`;

    const saveItem = () => save(`${laraPath}${saveUrl}`, component, "edit", `${nextPath}/courses/${course}/tools/assignment${backUrl}`);
    const back = () => router.back();

    return (
        <>
            <Box cols="grid-cols-1">
                <Input type="hidden" defaultValue={course} refItem={[component, "course_id"]} />
                <>
                    <div className="lg:grid grid-cols-12 gap-6">
                        <Textarea className="sm:col-span-12 col-span-6" row="6" label={Lang("public.your_answer")} refItem={[component, "response"]} defaultValue={answer?.answer} required={true} />
                        <Dropzone className="sm:col-span-12 col-span-6" label={Lang("public.file")} refItem={[component, "response_files"]} uploadUrl={uploadUrl} deleteUrl={deleteUrl+"/"} />
                    </div>
                </>
                <ButtonContainer>
                    <Button label="save" onClick={saveItem} />
                    <Button label="back" onClick={back} />
                </ButtonContainer>
            </Box>
        </>
    );
}
