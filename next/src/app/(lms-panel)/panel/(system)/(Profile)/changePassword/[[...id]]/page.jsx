"use client";

import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { Box, Button, ButtonContainer, Input, useData, useFormRefs } from "@/Theme/Midone";
import { useRouter } from "next/navigation";

export default function Page({ params }){
    const {Lang} = useLang();
    const {laraAdmin} = useConfig();
    const formUrl = "/users/change-password"; 
    let component = useFormRefs();
    let {save} = useData();
    const back = ()=>router.back();
    let userId = 0, redirect = "/dashboard", callBack = () => {};
    if(params?.id != undefined)
    {
        userId = params?.id;
        redirect = "";
        callBack = back;
    }

    let url = laraAdmin+formUrl+"?id="+userId, method = "edit";
    const router = useRouter();

    const saveItem = ()=>save(url, component, method, redirect, callBack);

    return(
        <>
            <Box title={Lang(["public.change", "public.password"])}>
                <Input required="true" type="password" label="new_password" refItem={[component, "new_password"]} />
                <Input required="true" type="password" label="new_password_confirmation" refItem={[component, "new_password_confirmation"]} />
            </Box>
            <ButtonContainer>
                <Button label="save" onClick={saveItem} />
                <Button label="back" onClick={back} />
            </ButtonContainer>
        </>
    );
}