"use client";

import { useEffect, useState } from "react";
import { useLang } from "@/lib/lang";
import { useData,useFormRefs,Input,Button,ButtonContainer,CheckBox, Frame } from "@/Theme/Midone/Forms";
import { Dropzone } from "@/Theme/Midone/Forms/Dropzone";
import { CKEditor } from "@/Theme/Midone/Forms/Ckeditor";
import { SelectTail } from "@/Theme/Midone/Forms/SelectTail";
import { useRouter } from 'next/navigation';
// import { Tools } from "@/Theme/Midone/Utils/Tools";

export function Form({laraPath,id,nextPath=""}){
    const {Lang,local,dir} = useLang();
    const router = useRouter();
    const formUrl = "/courses" ; 
    let component = useFormRefs();
    let {save, get, getNeedles} = useData();
    let [needles, setNeedles] = useState();
    let url = laraPath+formUrl, method = "new", key = 0;
    if(id != 0 && id != undefined) url = laraPath+formUrl+"/"+id, method = "edit";
    let uploadUrl=laraPath+"/upload/.-media-courses";
    let deleteUrl=laraPath+"/deleteFile/.-media-courses";
    let uploadDir='media/courses/';

    useEffect(() => {
        getNeedles(laraPath+formUrl+'/get-needles', setNeedles);
        get(url, component, "info");
    }, []);

    const saveItem = ()=>save(url, component, method, nextPath+formUrl+"?"+Math.random());
    const back = ()=>router.back();

    return <>
        <Frame>
            <div className="intro-y col-span-12 lg:col-span-8">
                <Input  label= "title" refItem={[component, "title"]} required="true" />
                <div className="post intro-y p-3 box mt-5 ">
                    <CKEditor required="true" refItem={[component, "description"]} />
                    <Dropzone required="true" refItem={[component, "thumbnail"]} uploadUrl={uploadUrl} deleteUrl={deleteUrl+"/"} uploadDir={uploadDir} />
                </div>
            </div>
            <div className="col-span-12 lg:col-span-4">
                <div className="intro-y box p-5">
                        {/* <Input  label= "less_id" refItem={[component, "less_id"]} required="true" /> */}
                        <Input  disabled={method === "edit"}  label="course_code"   refItem={[component, "code"]}  required={true} />
                        <SelectTail required="true" label="system" refItem={[component, "system_id"]} data={needles?.system} titleKey={"title"} />
                        <SelectTail required="true" label="lesson_group" refItem={[component, "category_id"]} data={needles?.coursecategory} titleKey={"title_"+local} />
                        <CheckBox label="status"  name={Lang('public.active')} refItem={[component, "status_id"]} defaultValue={component?.state?.info?.status_id}/>

                </div>
            </div>
        </Frame>
        <ButtonContainer>
            <Button label="save" onClick={saveItem} />
            <Button label="back" onClick={back} />
        </ButtonContainer>
        </>;
}