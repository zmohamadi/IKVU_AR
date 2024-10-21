"use client";
import { useUtility } from "@/lib";
import { useConfig } from "@/lib/config";
import { useLang } from "@/lib/lang";
import { useData, useFormRefs, Input, Button, ButtonContainer, Frame, Box, Textarea } from "@/Theme/Midone/Forms";
import { usePathname, useRouter } from 'next/navigation';
import { useEffect } from "react";
import { Tools } from "@/Theme/Midone/Utils";


export default function Page({ params }) {
    // console.log(params);
    const { getRelation } = useUtility();

    const { laraAdmin, nextAdmin } = useConfig();
    const course = params?.id;
    const id = params?.mid;
    // const id = params?.cid;
    const {Lang} = useLang();
    const router = useRouter();
    let component = useFormRefs();
    const { save,get } = useData();
    let url = laraAdmin+"/onlineClassrooms" +"/"+id; 
    let method = "edit";
    
    const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'courses';

    useEffect(() => {
        const fetchData = async () => {
            if (id) {
                await get(url, component, "info");
            }
        };
        fetchData();
    }, []);
    const saveItem = ()=>save(`${laraAdmin}/onlineClassroom/${id}/canceledInsert`, component, method, "/"+menuPath+"/"+course+"/tools/onlineClassroom"+"?"+Math.random());
    const back = ()=>router.back();

    return (
        <>
            <Frame title={Lang(["public.onlineClassroom"])}>
                <Box>

                    <Textarea className="col-span-12" label="cancel_reason" required="true" refItem={[component, "is_cancel"]}  />
                    
                </Box>
            </Frame>
            <ButtonContainer>
                <Button label="save" onClick={saveItem} />
                <Button label="back" onClick={back} />
            </ButtonContainer>   
        </>
    );
}
