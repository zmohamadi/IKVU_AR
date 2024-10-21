"use client";
import { useLang } from "@/lib/lang";
// import { useEffect } from "react";
import { useEffect, useState } from "react";
import { useRouter } from 'next/navigation';
import Link from 'next/link';
import { useData,useFormRefs,Input,Button,ButtonContainer,Box,Textarea,Line } from "@/Theme/Midone/Forms";
import { Dropzone } from "@/Theme/Midone/Forms/Dropzone";

export function Form({ post,forum,course,laraPath,nextPath="",formAction="",funcFormAction,subPost=0 })
{
    const {Lang} = useLang();
    let component = useFormRefs();
    const router = useRouter();
    const { save, get } = useData();
    const nextUrl = nextPath+"/courses/"+course+"/tools/forum/"+forum;
    const formUrl = "/posts";
    let sendPost = post;
    
    const [flag, setFlag] = useState(0);

    let url = laraPath+formUrl, method = "new";
    if(post != 0 && post != undefined && (formAction=="" || formAction=="edit"))
    {
        if(subPost > 0) sendPost=subPost;
        url = url+"/"+sendPost, method = "edit";
    }

    useEffect(() => {
        if(formAction=="reply")
        {
            component.state.info = undefined;
            setFlag(Math.random());
        }
        if(post != 0 && post != undefined && (formAction=="" || formAction=="edit")) get(url, component, "info");
    }, [subPost]);
    
    const cancelReply = ()=>funcFormAction("");

    let backForm = nextUrl+formUrl, callBack = () => {}, parentId=0, replyTo=0;
    if(formAction != "")
    {
        backForm = nextUrl+formUrl+"/"+post+"/reply?"+Math.random(), callBack = cancelReply;
        if(formAction=="new") parentId = post, replyTo = 0;
        else if(formAction=="reply")  parentId = post, replyTo = subPost;
        else if(formAction=="edit") parentId = component?.state?.info?.parent_id, replyTo = component?.state?.info?.reply_to;   
    }

    const saveItem = ()=>save(url, component, method, backForm, callBack);
    const back = ()=>router.back();

    let uploadUrl = laraPath+"/upload/.-media-forum";
    let deleteUrl = laraPath+"/deleteFile/.-media-forum";
    let uploadDir = 'media/forum/';
    let displayTitle = "";
    let displayBtn = "";
    let labelSave = "";
    formAction==""? (
            displayTitle = <Input label="title" refItem={[component, "title"]} required="true" />,
            displayBtn = <>
                    <Button label="back" onClick={back} />
                    <Link className="btn btn-success  w-20 mr-1 ml-1" href={nextPath+"/courses/"+course+"/tools"}>{Lang(["public.tools_link"])}</Link>
                </>,
            labelSave = "save"
        )
    : (
            displayTitle = "",
            displayBtn = <Button className="btn btn-primary w-30 mr-1 ml-1" label="btn_cancel_reply" onClick={cancelReply} />,
            labelSave = formAction
        )

    return <>
            <Box>
                <Input type="hidden" defaultValue={forum} refItem={[component, "forum_id"]} />
                <Input type="hidden" defaultValue={parentId} refItem={[component, "parent_id"]} />
                <Input type="hidden" defaultValue={replyTo} refItem={[component, "reply_to"]} />
                {displayTitle}
                <Line />
                <Textarea label="message" refItem={[component, "message"]} required="true" />
                <Dropzone refItem={[component, "upload_file"]} defaultValue={component?.state?.info?.attachments}
                    uploadUrl={uploadUrl} deleteUrl={deleteUrl+"/"} uploadDir={uploadDir} maxFiles="50"
                    help = {Lang("public.accept_format")+": png,jpg,tif,gif,jpeg,WebP,AVIF,jfif,pdf,doc,docx,ppt"}
                />
            </Box>
            <ButtonContainer className="col-span-12">
                <Button label={labelSave} onClick={saveItem} />
                {displayBtn}
            </ButtonContainer>
        </>;
}