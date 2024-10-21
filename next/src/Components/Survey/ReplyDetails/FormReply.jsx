"use client";

import { useRouter } from 'next/navigation';
import { useData,useFormRefs,ButtonContainer,Button,Radio,Input } from "@/Theme/Midone/Forms";

export function FormReply({ id,course,laraPath,nextPath="",questions }){
    let component = useFormRefs();
    let {save} = useData();
    const router = useRouter();
    let url = laraPath+"/survey/reply-save/"+id;

    const saveItem = () => save(url, component, "save", nextPath+"/courses/"+course+"/tools/survey");
    const back = ()=>router.back();

    return <>
            {questions?.map((question, index)=>{
                return <ul className="">
                        <li>
                            <Radio label={[(parseInt(index)+1)+") "+question?.title]} data={question?.question_options} refItem={[component, "response_"+question?.id]} />
                        </li>
                    </ul>
                }
            )}
            <Input type="hidden" value={course} refItem={[component, "course"]} />
            <ButtonContainer>
                <Button label="save" onClick={saveItem} />
                <Button label="back" onClick={back} />
            </ButtonContainer>
        </>;
}