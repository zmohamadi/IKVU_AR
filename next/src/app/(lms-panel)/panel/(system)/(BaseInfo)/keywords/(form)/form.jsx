"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useRouter } from 'next/navigation';
import { useData,useFormRefs,Input,Button,ButtonContainer,CheckBox,Box } from "@/Theme/Midone/Forms";

export default function Form({id}){
    const { Lang } = useLang();
    const { laraAdmin } = useConfig();
    let { save, get } = useData();
    let component = useFormRefs();
    const router = useRouter();
    const formUrl = "/keywords"; 
    let url = laraAdmin+formUrl, method = "new";
    if(id != 0 && id != undefined) url = laraAdmin+formUrl+"/"+id, method = "edit";
    
    useEffect(()=>{
        if(id != 0) get(url, component, "info");
    }, [id]);

    const saveItem = ()=>save(url, component, method, formUrl);
    const back = ()=>router.back();

    return <>
            <Box title={Lang(["public.keyword"])}>     
                <Input required="true" label="title" refItem={[component, "title"]} />
                <Input label="order" refItem={[component, "order"]} />
                <CheckBox label="status" name={Lang('public.active')} refItem={[component, "status_id"]} value={0} />        
            </Box>
            <ButtonContainer>
                <Button label="save" onClick={saveItem} />
                <Button label="back" onClick={back} />
            </ButtonContainer>        
        </>;
}