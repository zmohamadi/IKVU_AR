"use client";
import { useEffect, useState } from "react";
import { useLang } from "@/lib/lang";
import { useData, useFormRefs, Input, Button, ButtonContainer, CheckBox, Box, Textarea } from "@/Theme/Midone/Forms";
import { usePathname, useRouter } from 'next/navigation';
import { Dropzone } from "@/Theme/Midone/Forms/Dropzone";

export function Form({ laraPath, course, id, nextPath = "" }) {

    const { Lang } = useLang();
    const router = useRouter();
    let component = useFormRefs();
    const { save, get, getNeedles } = useData();
    const [needles, setNeedles] = useState();
    const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'courses';

    let formUrl = "/contents";
    let url = laraPath + formUrl, method = "new";
    if (id != 0 && id != undefined) url = laraPath + formUrl + "/" + id + '?mode=edit', method = "edit";
    
    let uploadUrl = laraPath + "/upload/.-media-courses-" + course;
    let deleteUrl = laraPath + "/deleteFile/.-media-courses-" + course;
    // let uploadUrl = laraPath + "/upload/.-media-courses-" + course + "-learnpath";
    // let deleteUrl = laraPath + "/deleteFile/.-media-courses-" + course + "-learnpath";

    useEffect(() => {
        getNeedles(`${laraPath+formUrl}/get-needles`, setNeedles);
        if (id != 0 && id != undefined) get(url, component, "info");
    }, []);

    const saveItem = () => save(url, component, method, nextPath + "/"+menuPath+"/" + course + "/tools/learnpath" + "?" + Math.random());
    const back = () => router.back();

    return <>
        <Box title={Lang(["public.content"])}>
            <Input type="hidden" defaultValue={course} refItem={[component, "course_id"]} />
            <Input required="true" label="title" refItem={[component, "title"]} />
            <Input label="duration" refItem={[component, "duration"]} placeholder='01:12:34' />
            <Textarea required="true" label="description" refItem={[component, 'description']} />
            <Input type='number' min='1' label="order" refItem={[component, "order"]} placeholder='1' />
            <Dropzone acceptType="image/*,application/pdf" required="true" refItem={[component, "image_pdf"]} uploadUrl={uploadUrl + '-pdf'} deleteUrl={deleteUrl + '-pdf' + "/"} />
            <Dropzone acceptType="application/pdf" refItem={[component, "mobile_pdf"]} uploadUrl={uploadUrl + '-pdf'} deleteUrl={deleteUrl + '-pdf' + "/"} />
            <Dropzone acceptType="video/*" refItem={[component, "video"]} uploadUrl={uploadUrl +  '-video'} deleteUrl={deleteUrl + '-video' + "/"} />
            <Dropzone acceptType="audio/*" refItem={[component, "audio"]} uploadUrl={uploadUrl  +  '-audio'} deleteUrl={deleteUrl  + '-audio' + "/"} />
        </Box>
        <ButtonContainer>
            <Button label="save" onClick={saveItem} />
            <Button label="back" onClick={back} />
        </ButtonContainer>
        
    </>;
}