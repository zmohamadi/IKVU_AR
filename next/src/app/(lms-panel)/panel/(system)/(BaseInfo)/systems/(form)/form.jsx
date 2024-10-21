"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useRouter } from 'next/navigation';
import { useData,useFormRefs,Input,Button,ButtonContainer,CheckBox,Box, Frame } from "@/Theme/Midone/Forms";
import { Dropzone } from "@/Theme/Midone/Forms/Dropzone";
import { CKEditor } from "@/Theme/Midone/Forms/Ckeditor";

export default function Form({id}){
    const { Lang } = useLang();
    const { laraAdmin } = useConfig();
    let { save, get } = useData();
    let component = useFormRefs();
    const router = useRouter();
    const formUrl = "/systems"; 
    let url = laraAdmin+formUrl, method = "new";
    if(id != 0 && id != undefined) url = laraAdmin+formUrl+"/"+id, method = "edit";
    let uploadUrl=laraAdmin+"/upload/.-media-systems";
    let deleteUrl=laraAdmin+"/deleteFile/.-media-systems";
    let uploadDir='media/systems/';
    
    useEffect(()=>{
        if(id != 0) get(url, component, "info");
    }, [id]);

    const saveItem = ()=>save(url, component, method, formUrl);
    const back = ()=>router.back();

    return <>
            <Frame>
                <Box >     
                    <Input required="true" label="title" refItem={[component, "title"]} />
                    <Input required="true" label="api_key" refItem={[component, "api_key"]} />
                    <Input required="true" label="ip" refItem={[component, "ip"]} />
                    <Input required="true" label="link" refItem={[component, "domain"]} />
                    <Dropzone className="col-span-6" required="true" refItem={[component, "photo"]} uploadUrl={uploadUrl} deleteUrl={deleteUrl+"/"} uploadDir={uploadDir} />
                    <CKEditor className="col-span-6" required="true" refItem={[component, "description"]} />
                </Box>
            </Frame>
            <ButtonContainer>
                <Button label="save" onClick={saveItem} />
                <Button label="back" onClick={back} />
            </ButtonContainer>        
        </>;
}