"use client";
import { useLang } from "@/lib/lang";
import { useEffect, useState } from "react";
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { useData,useFormRefs,Input,Button,ButtonContainer,Frame,Box,CheckBox,Textarea,Line } from "@/Theme/Midone/Forms";
import { YearGroup } from "@/Components/Public/YearGroup";

export function Form({ course,id,laraPath,nextPath="" }) {    
    const {Lang} = useLang();
    let component = useFormRefs();
    const router = useRouter();
    const { save, get, getNeedles } = useData();
    const [needles, setNeedles] = useState();
    const nextUrl = nextPath+"/courses/"+course+"/tools";
    const formUrl = "/forum";

    let url = laraPath+formUrl, method = "new";
    if(id != 0 && id != undefined) url = url+"/"+id, method = "edit";

    useEffect(() => {
        getNeedles(`${laraPath+formUrl}/get-needles`, setNeedles);
        if(id != 0 && id != undefined) get(url, component, "info");
    }, []);

    const saveItem = ()=>save(url, component, method, nextUrl+formUrl);
    const back = ()=>router.back();

    return <>
            <Frame title={Lang(["public.forum"])}>
                <Box>
                    <Input type="hidden" defaultValue={course} refItem={[component, "course_id"]} />
                    <Input label="title" refItem={[component, "title"]} required="true" />
                    <Line />
                    <YearGroup component={component} needles={needles}  />
                    <Textarea className="col-span-12" row="3" label="description" refItem={[component, "description"]} required="true" />
                    <CheckBox className="col-span-4" label="forum_status" name={Lang('public.active')} refItem={[component, "status_id"]} />
                    <CheckBox className="col-span-4" label="forum_status" name={Lang('public.lock')} refItem={[component, "lock"]} />
                    <CheckBox className="col-span-4" label="posts_status" name={Lang('public.need_confirmation')} refItem={[component, "need_to_apply"]} />
                </Box>
            </Frame>
            <ButtonContainer>
                <Button label="save" onClick={saveItem} />
                <Button label="back" onClick={back} />
                <Link className="btn btn-success  w-20 mr-1 ml-1" href={nextPath+"/courses/"+course+"/tools"}>{Lang(["public.tools_link"])}</Link>
            </ButtonContainer>
        </>;
}