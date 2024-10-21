"use client";

import { useLang } from "@/lib/lang";
import { Input,CheckBox } from "@/Theme/Midone/Forms";
import { Dropzone } from "@/Theme/Midone/Forms/Dropzone";

export function Perspnnel({ parent, laraUrl, displayAccess=true, displayPublic=true }){
    const {Lang} = useLang();
    let uploadUrl=laraUrl+"/upload/.-media-users";
    let deleteUrl=laraUrl+"/deleteFile/.-media-users";
    let uploadDir='media/users/';

    return <>
            <Input label="name" refItem={[parent, "name"]} required="true" />
            <Input label="family" refItem={[parent, "lname"]} required="true"  />
            <Input label="email" refItem={[parent, "email"]} required="true"  />
            <Input label="mobile" refItem={[parent, "mobile"]} />
            <Dropzone refItem={[parent, "pic"]} uploadUrl={uploadUrl} required="true" deleteUrl={deleteUrl+"/"} uploadDir={uploadDir} />
            {(displayAccess)? <CheckBox label="status" name={Lang('public.active')} refItem={[parent, "status_id"]} /> : ""}
        </>;
}