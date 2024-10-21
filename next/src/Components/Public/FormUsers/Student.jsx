"use client";

import { useLang } from "@/lib/lang";
import { Input,CheckBox, SelectTail } from "@/Theme/Midone/Forms";
import { Dropzone } from "@/Theme/Midone/Forms/Dropzone";

export function Student({ parent, laraUrl, needles, displayAccess=true, displayPublic=true }){
    const {Lang,local} = useLang();
    let uploadUrl=laraUrl+"/upload/.-media-users";
    let deleteUrl=laraUrl+"/deleteFile/.-media-users";
    let uploadDir='media/users/';
    
    return <>
                {(displayPublic)?
                        <>
                                <Input label= "name" refItem={[parent, "name"]} required="true" />
                                <Input label= "lname" refItem={[parent, "lname"]} required="true" />
                                <Input label= "email" refItem={[parent, "email"]} required="true" />
                                <Input label= "mobile" refItem={[parent, "mobile"]}  />
                                <Dropzone className="col-span-6" label="pic" refItem={[parent, "pic"]} uploadUrl={uploadUrl} deleteUrl={deleteUrl+"/"} uploadDir={uploadDir} required="true" />       
                                <CheckBox className="col-span-3"  label="status" name={Lang('public.active')} refItem={[parent, "status_id"]} />
                        </>
                :""}
                <Input type="hidden" refItem={[parent, "role_id"]} defaultValue="2" />
                <SelectTail className="col-span-6" label="level" refItem={[parent, "level_id"]}
                        data={needles?.educationlevel} titleKey={"title_"+local} key={"level_id"+needles?.educationlevel?.length} />
                <SelectTail className="col-span-6" label="timezone" refItem={[parent, "timezone_id"]} required="true" key={"timezone_id_"+needles?.timezone?.length} >
                        {(needles?.timezone)?.map((time, index)=>{
                                return(
                                        <option key={index} value={time.id}>{time?.["title"]+" ("+time?.["offset"]+")"}</option>
                                );
                        })}
                </SelectTail>
                <Input className="col-span-6" label= "birthdate" refItem={[parent, "birthdate"]} required="true" />    
                {(displayAccess)?
                <>
                        <CheckBox className="col-span-6"  label="mentorship" name={Lang('public.mentee')} refItem={[parent, "is_mentee"]} />
                </>
                : ""}
        </>;
}