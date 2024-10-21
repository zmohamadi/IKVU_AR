"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useData, useFormRefs, Input, Button, ButtonContainer,Box, CheckBox, Frame } from "@/Theme/Midone/Forms";
import { useRouter } from 'next/navigation';

export default function Form({id}){
    const {Lang,local} = useLang();
    const {laraAdmin } = useConfig();
    const formUrl = "/categories" ; 
    let component = useFormRefs();
    let {save, get} = useData();
    let url = laraAdmin+formUrl, method = "new", key = 0;
    if(id != 0 && id != undefined) url = laraAdmin+"/categories/"+id, method = "edit";
    const router = useRouter();


    useEffect(() => {
        get(url, component, "info");
    }, []);

    const saveItem = ()=>save(url, component, method, formUrl+"?"+Math.random());
    const back = ()=>router.back();


    return <>
        <Frame>
        <Box title={Lang(["public.lesson_group"])}>
                <Input required="true" label="title_fa" refItem={[component, "title_"+local]} />
                <CheckBox className="col-span-6" label="status" name={Lang('public.active')} refItem={[component, "status_id"]} />


        </Box>
        </Frame>
        <ButtonContainer>
                <Button label="save" onClick={saveItem} />
                <Button label="back" onClick={back} />
        </ButtonContainer>
            </>;
}