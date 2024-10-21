"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { Box, Button, ButtonContainer, FeatherIcon, useData, useFormRefs } from "@/Theme/Midone";
import { useRouter } from 'next/navigation';

export default function View({params}){
    const router = useRouter();
    const back = ()=>router.back();

    const {laraAdmin,mediaPath } = useConfig();
    const {Lang} = useLang();
    const formUrl = "/personnels"; 
    const title = "personnel" ; 
    let id = params.id , url = laraAdmin+formUrl+"/"+id;
    let component = useFormRefs();
    let {get} = useData();
    useEffect(() => {get(url, component, "info");}, []);
    let data = component?.state?.info;
    return(<>
            <Box cols="grid-cols-1" title={Lang(["public.view", "public."+title])}>
                <div className="flex flex-col lg:flex-row border-b border-gray-200 dark:border-dark-5 pb-5 -mx-5">
                    <div className="flex flex-1 px-5 items-center justify-center lg:justify-start">
                        <div className="w-20 h-20 sm:w-24 sm:h-24 flex-none lg:w-32 lg:h-32 image-fit relative">
                            <img alt={data?.name} className="rounded-full" src={mediaPath+"/users/"+data?.pic} />
                            
                        </div>
                        
                    </div>
                    <div className="mt-6 lg:mt-0 flex-1 px-5 border-l border-r border-gray-200 dark:border-dark-5 border-t lg:border-t-0 pt-5 lg:pt-0">
                        <div className="flex flex-col justify-center items-center lg:items-start mt-4">
                            
                            <div className="truncate sm:whitespace-normal flex items-center"> 
                                <FeatherIcon size="16" name="User" tooltip={Lang('public.user')} /> <span className="ml-2">{data?.name} {data?.lname}</span>
                            </div>
                            <div className="truncate sm:whitespace-normal flex items-center"> 
                                <FeatherIcon size="16" name="Mail" tooltip={Lang('public.email')} /> <span className="ml-2">{data?.email}</span>
                            </div>
                            <div className="truncate sm:whitespace-normal flex items-center"> 
                                <FeatherIcon size="16" name="PhoneCall" tooltip={Lang('public.mobile')} /> <span className="ml-2">{data?.mobile}</span>
                            </div>
                           
                        </div>
                    </div>
                   
                </div>
            </Box>
            <ButtonContainer>
                <Button label="back" onClick={back} />
            </ButtonContainer>
        </>
    );
}