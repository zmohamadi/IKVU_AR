"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useData, useFormRefs,Box, ButtonContainer, Button } from "@/Theme/Midone/Forms";
import { useRouter } from "next/navigation";

export function StudentReport({id,course,access,laraPath}){
    const router = useRouter();
    const back = ()=>router.back();
    const {Lang,local} = useLang();
    const {mediaPath} = useConfig();
    // const formUrl = "/students/report/"+id ; 
    const formUrl = "/courses/change-status/"+course+"/"+id ;
    let component = useFormRefs();
    let {get} = useData();
    let url = laraPath+formUrl;

    useEffect(() => {
        get(url, component, "info");
    }, []);
   
    let stu = component?.state?.info?.student;
//     let status = component?.state?.info?.status;
//     let enroll = component?.state?.info?.enroll;

    return <>
        <Box title={Lang(["public.reports"])}>
                <div className="mx-auto text-center col-span-12">
                        <div className="w-16 h-16 flex-none image-fit rounded-full overflow-hidden mx-auto">
                                <img className="rounded-full" src={mediaPath+"/users/"+stu?.pic} width={70} height={70} alt="student" />
                        </div>
                        <div className="mt-3">
                                <div className="font-medium">{stu?.name} {stu?.lname}</div>
                                <div className="font-medium">mobile :  {stu?.mobile}</div>
                                <div className="font-medium">email :  {stu?.email}</div>
                        </div>
                </div>

        </Box>
        <ButtonContainer>
                <Button label="back" onClick={back} />
        </ButtonContainer>
            </>;
}