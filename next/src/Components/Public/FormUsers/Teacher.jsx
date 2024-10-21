"use client";

import { useLang } from "@/lib/lang";
import { Input,Textarea,CheckBox, SelectTail } from "@/Theme/Midone/Forms";
import { Dropzone } from "@/Theme/Midone/Forms/Dropzone";
import { CKEditor } from "@/Theme/Midone/Forms/Ckeditor";
import { Select } from "@/Theme/Midone/Forms/Select";

export function Teacher({ parent, laraUrl, needles, displayAccess=true, displayPublic=true }){
    const {Lang} = useLang();
    let uploadUrl=laraUrl+"/upload/.-media-users";
    let deleteUrl=laraUrl+"/deleteFile/.-media-users";
    let uploadDir='media/users/';
    
    return <>
            {(displayPublic)?
                <>
                        <Input type="hidden" refItem={[parent, "role_id"]} defaultValue="1" />
                        <Input label= "name" className="col-span-4" refItem={[parent, "name"]} required="true" />
                        <Input label= "lname" className="col-span-4" refItem={[parent, "lname"]} required="true" />
                        <Input label= "email" className="col-span-4" refItem={[parent, "email"]} required="true" />
                        <Input className="col-span-4" label= "mobile" refItem={[parent, "mobile"]}  />
                        <Dropzone className="col-span-6" label="pic" defaultValue={[parent?.state?.info?.pic]}
                                refItem={[parent, "pic"]} uploadUrl={uploadUrl} deleteUrl={deleteUrl+"/"} uploadDir={uploadDir} required="true" />
                        <CheckBox className="col-span-3"  label="status" name={Lang('public.active')} refItem={[parent, "status_id"]} />
                </>
            :""}
            <Input type="hidden" refItem={[parent, "is_teacher"]} defaultValue="1" />
            <div className="col-span-6">
                <Select className="col-span-12" required="true" label="gender"  refItem={[parent, "gender_id"]} defaultValue={parent?.state?.info?.gender_id} >
                    <option key="0" value="1"> {Lang(["public.male"])} </option>
                    <option key="0" value="0"> {Lang(["public.female"])} </option>
                </Select>
                <SelectTail className="col-span-12 mt-2" label="timezone" refItem={[parent, "timezone_id"]} required="true" key={"timezone_id_"+needles?.timezone?.length} >
                    {(needles?.timezone)?.map((time, index)=>{
                            return(
                                    <option key={index} value={time.id}>{time?.["title"]+" ("+time?.["offset"]+")"}</option>
                            );
                    })}
                </SelectTail>
                <Textarea className="col-span-12 mt-2" refItem={[parent, "address"]} required="true"/>
            </div>
            <div className="col-span-6">
                <CKEditor refItem={[parent, "biography"]} required="true"/>
            </div>
            {(displayAccess)?
                <>
                    <CheckBox className="col-span-6" label="mentorship" name={Lang('public.mentor')} refItem={[parent, "is_mentor"]} />
                    <CheckBox className="col-span-6" label="event" name={Lang('public.event_speaker')} refItem={[parent, "is_event_speaker"]} />
                </>
            : ""}
        </>;
}