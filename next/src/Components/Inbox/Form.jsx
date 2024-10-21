"use client";
import { useLang } from "@/lib/lang";
import { usePathname, useRouter } from 'next/navigation';
import { useEffect,useState } from 'react';
import { useData,useFormRefs,Frame,Input,Button,ButtonContainer,Box,Textarea,SelectTail } from "@/Theme/Midone/Forms";
import { Tools } from '@/Theme/Midone';
import { Dropzone } from '@/Theme/Midone/Forms/Dropzone';

export function Form({course,id,laraPath, nextPath=""}){    
    const {Lang} = useLang();
    const router = useRouter();
    const formUrl = "/inbox" ; 
    let component = useFormRefs();
    let {save, get, getNeedles} = useData();
    let [needles, setNeedles] = useState();
    let url = laraPath+formUrl, method = "new", key = 0;
    if(id != 0 && id != undefined) url = laraPath+formUrl+"/"+id, method = "edit";
    let uploadUrl=laraPath+"/upload/.-media-inbox";
    let deleteUrl=laraPath+"/deleteFile/.-media-inbox";
    let uploadDir='media/inbox/';
    const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'courses';

    useEffect(() => {
        // if(course != 0 && course != undefined) getNeedles(`${laraPath}${formUrl}/get-needles/${course}`, setNeedles);
        if(course != 0 && course != undefined) getNeedles(`${laraPath}${formUrl}/get-needles?course=${course}`, setNeedles);
        get(url, component, "info");
    }, []);

    const saveItem = ()=>save(url, component, method,`${nextPath}/${menuPath}/${course}/tools/inbox?${Math.random()}`);
    const back = ()=>router.back();
    const group = needles?.group

    return <>
        <Frame title={Lang(["public.inbox"])}>
            <Box>
                <Input type="hidden" defaultValue={course} refItem={[component, "course_id"]} />
                <Input type="hidden" defaultValue={group} refItem={[component, "group"]} />
                <SelectTail defaultValue={component?.state?.info?.receiver} multiple={true} key={"user"+needles?.users?.length} required="true" refItem={[component, "receivers"]}>
                    {Tools.getArray(needles?.users).map((user, index)=>
                            <option key={index} value={user?.id}> {user?.firstname} {user?.lastname} </option>
                    )}
                </SelectTail>
                <Input required="true" refItem={[component, "title"]} />
                <Textarea required="true" label="text" refItem={[component, "text"]} />
                <Dropzone defaultValue={component?.state?.info?.files} multiple={true}  refItem={[component, "files"]} uploadUrl={uploadUrl} deleteUrl={deleteUrl+"/"} uploadDir={uploadDir} />

            </Box>
            <ButtonContainer className="col-span-12">
                <Button label="save" onClick={saveItem} />
                <Button label="back" onClick={back} />
            </ButtonContainer>
        </Frame>
    </>;
}