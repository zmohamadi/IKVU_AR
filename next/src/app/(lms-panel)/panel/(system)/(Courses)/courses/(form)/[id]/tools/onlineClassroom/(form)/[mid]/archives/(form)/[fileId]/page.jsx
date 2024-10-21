"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { Box, useData, useFormRefs } from "@/Theme/Midone";
export default function View({params}){

    const {laraAdmin } = useConfig();
    const {Lang} = useLang();
    const formUrl = "/witrs/" ; 
    const title = "wite" ; 
    let id = params.id , url = laraAdmin+formUrl+"/"+id;
    let component = useFormRefs();
    let {get} = useData();
    useEffect(() => {get(url, component, "info");}, []);
    let data = component?.state?.info;
    return(<>
            <Box title={Lang(["public.view", "public."+title])}>
                {data.id}
            </Box>
        </>
    );
}