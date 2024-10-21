"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useRouter } from 'next/navigation';
import { useData,useFormRefs,Input,Button,ButtonContainer,Box, CheckBox, Frame, DatePicker } from "@/Theme/Midone/Forms";

export default function Form({id}){
    const { Lang } = useLang();
    const { laraAdmin } = useConfig();
    let { save, get } = useData();
    let component = useFormRefs();
    const router = useRouter();
    const formUrl = "/yearSemesters"; 
    let url = laraAdmin+formUrl, method = "new";
    if(id != 0 && id != undefined) url = laraAdmin+formUrl+"/"+id, method = "edit";
    
    useEffect(()=>{
        if(id != 0) get(url, component, "info");
    }, [id]);

    const saveItem = ()=>save(url, component, method, formUrl);
    const back = ()=>router.back();

    return <>
            <Frame>
                <Box >     
                    <Input required="true" placeholder="1403" refItem={[component, "year"]} />
                    <Input required="true" placeholder="1" refItem={[component, "semester"]} />
                    <DatePicker required="true" refItem={[component, "start_date"]} />
                    <DatePicker required="true" refItem={[component, "end_date"]} />
                    <CheckBox defaultValue={component?.state?.info?.current} className="col-span-6" label="year_semester_for_system" name={Lang('public.active')} refItem={[component, "current"]} />
                    <CheckBox required="true" label="status"  name={Lang('public.active')} className="col-span-6" refItem={[component, "status_id"]}
                             defaultValue={component?.state?.info?.status_id}
                            />
                </Box>
            </Frame>
            <ButtonContainer>
                <Button label="save" onClick={saveItem} />
                <Button label="back" onClick={back} />
            </ButtonContainer>        
        </>;
}