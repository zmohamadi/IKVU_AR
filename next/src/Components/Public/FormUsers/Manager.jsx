"use client";

import { useLang } from "@/lib/lang";
import { Input,CheckBox } from "@/Theme/Midone/Forms";
import { Dropzone } from "@/Theme/Midone/Forms/Dropzone";
import { CKEditor } from "@/Theme/Midone/Forms/Ckeditor";

export function Manager({ parent, laraUrl, displayAccess=true, displayPublic=true }){
    const {Lang} = useLang();
    let uploadUrl=laraUrl+"/upload/.-media-users";
    let deleteUrl=laraUrl+"/deleteFile/.-media-users";
    let uploadDir='media/users/';

    return <>
                {(displayPublic)?
                        <>
                                <Input label= "name" className="col-span-4" refItem={[parent, "name"]} required="true" />
                                <Input label= "lname" className="col-span-4" refItem={[parent, "lname"]} required="true" />
                                <Input label= "email" className="col-span-4" refItem={[parent, "email"]} required="true" />
                                <Input className="col-span-4" label= "mobile" refItem={[parent, "mobile"]}  />
                                <Dropzone className="col-span-6" label="pic" defaultValue={[parent?.state?.info?.pic]}
                                        refItem={[parent, "pic"]} uploadUrl={uploadUrl} deleteUrl={deleteUrl+"/"} uploadDir={uploadDir} required="true" />
                                <CheckBox className="col-span-3"  label="status" name={Lang('public.active')} refItem={[parent, "status_id"]} />
                        </>
                :""}
                <Input type="hidden" refItem={[parent, "role_id"]} defaultValue="3" />
                <CKEditor className="col-span-6" refItem={[parent, "biography"]} required="true"/>
                {(displayAccess)?
                        <>
                                <CheckBox className="col-span-4" label="mentorship" name={Lang('public.mentor')} refItem={[parent, "is_mentor"]} />
                                <CheckBox className="col-span-4" label="event" name={Lang('public.event_speaker')} refItem={[parent, "is_event_speaker"]} />
                        </>
                : ""} 
        </>;
}