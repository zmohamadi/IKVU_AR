"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useData, useFormRefs, Input, Button, ButtonContainer, CheckBox,Box } from "@/Theme/Midone/Forms";
import { useRouter } from 'next/navigation';

export default function Form({id}){
    const {Lang,local,activeLang} = useLang();
    const {laraAdmin } = useConfig();
    const formUrl = "/questionTypes" ; 
    let component = useFormRefs();
    let {save, get} = useData();
    let url = laraAdmin+formUrl, method = "new", key = 0;
    if(id != 0 && id != undefined) url = laraAdmin+formUrl+"/"+id, method = "edit";
    const router = useRouter();


    useEffect(() => {
        get(url, component, "info");
    }, []);

    const saveItem = ()=>save(url, component, method, formUrl+"?"+Math.random());
    const back = ()=>router.back();


    return <>
        <Box title={Lang(["public.course-categories"])}>
                {activeLang.map((lang, index)=>
                        <Input className={"mb-3 col-span-6 "+lang.dir} label= {"title_"+lang.symbol} labelClassName={lang.dir}
                        refItem={[component, "title_"+lang.symbol]} required="true" />
                
                )}
        </Box>
        <ButtonContainer>
                <Button label="save" onClick={saveItem} />
                <Button label="back" onClick={back} />
        </ButtonContainer>
            </>;
}