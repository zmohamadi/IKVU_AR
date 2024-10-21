"use client";

import { useLang } from "@/lib/lang";
import { Input,CheckBox } from "@/Theme/Midone/Forms";
import { Dropzone } from "@/Theme/Midone/Forms/Dropzone";

export function InfoPublic({ parent, laraUrl, displayAccess=true }){
    const {Lang} = useLang();
    let uploadUrl=laraUrl+"/upload/.-media-users";
    let deleteUrl=laraUrl+"/deleteFile/.-media-users";
    let uploadDir='media/users/';

    return <>
        <div className="intro-y box px-5 pt-5 mt-5">
            <div className="flex flex-col lg:flex-row border-b border-gray-200 dark:border-dark-5 pb-5 -mx-5">
                <div className="mt-6 lg:mt-0 flex-1 dark:text-gray-300 px-5 border-l border-r border-gray-200 dark:border-dark-5 border-t lg:border-t-0 pt-5 lg:pt-0">  
                    <Input label= "name" refItem={[parent, "name"]} required="true" />
                    <Input label= "lname" refItem={[parent, "lname"]} required="true" />
                    <Input label= "email" refItem={[parent, "email"]} required="true" />
                    <Input label= "mobile" refItem={[parent, "mobile"]} />
                </div>
                <div className="mt-6 lg:mt-0 flex-1 px-5 border-t lg:border-0 border-gray-200 dark:border-dark-5 pt-5 lg:pt-0">
                    {(displayAccess)?
                        <CheckBox label="status" name={Lang('public.active')} refItem={[parent, "status_id"]} />
                    : ""}
                    <Dropzone className="mt-5" label="pic" refItem={[parent, "pic"]} uploadUrl={uploadUrl} deleteUrl={deleteUrl+"/"} uploadDir={uploadDir} required="true" />
                </div>
            </div>
        </div>
    </>;
}