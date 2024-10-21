"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useUtility } from "@/lib/utility";
import { Box, FeatherIcon, useData, useFormRefs, Frame, Pic } from "@/Theme/Midone";

export default function View({params}){
    const {laraAdmin,mediaPath } = useConfig();
    const {Lang,local} = useLang();
    const { getRelation } = useUtility();
    const formUrl = "/personnels"; 
    const title = "personnel" ; 
    // let id = params.id , url = laraAdmin+formUrl+"/"+id;
    let id = params.id , url = `${laraAdmin}/users/show-info/${id}`;
    let component = useFormRefs();
    let {get} = useData();
    useEffect(() => {get(url, component, "info");}, []);
    const data = component?.state?.info?.item;

    return(
        <Frame title={Lang(["public.personnels"])}>
            <Box cols="grid-cols-1" title={Lang(["public.view", "public."+title])}>    
                <div className="flex flex-col justify-center items-center lg:items-start">
                    <div className="w-18 h-18 sm:w-24 sm:h-24 flex-none lg:w-32 lg:h-32 image-fit relative">
                        <Pic src={`${mediaPath}/users/${data?.photo}`} defaultImg={`${mediaPath}/public/default/avatar.png`} classImg="rounded-full"  />
                    </div>
                    <div className="truncate sm:whitespace-normal flex items-center"> 
                        <FeatherIcon iconClassName="ml-2" size="18" name="User" tooltip={Lang('public.user')} />{data?.firstname} {data?.lastname}
                    </div>
                    <div className="truncate sm:whitespace-normal flex items-center"> 
                        <FeatherIcon iconClassName="ml-2" size="18" name="Mail" tooltip={Lang('public.email')} />{data?.email}
                    </div>
                    <div className="truncate sm:whitespace-normal flex items-center"> 
                        <FeatherIcon iconClassName="ml-2" size="18" name="PhoneCall" tooltip={Lang('public.mobile')} />{data?.mobile}
                    </div>
                    <div className="truncate sm:whitespace-normal flex items-center"> 
                        <FeatherIcon iconClassName="ml-2" size="18" name="Settings" tooltip={Lang('public.role')} />{data?.role?.["title_" + local]}
                    </div>
                    <div className="truncate sm:whitespace-normal flex items-center"> 
                        <FeatherIcon iconClassName="ml-2" size="18" name="Tag" tooltip={Lang('public.gender')} />{data?.gender?.["title_" + local]}
                    </div>
                    <div className="truncate sm:whitespace-normal flex items-center"> 
                        <FeatherIcon iconClassName="ml-2" size="18" name="UserPlus" tooltip={Lang('public.creator')} />{getRelation(data?.creator)}
                    </div>
                    <div className="truncate sm:whitespace-normal flex items-center"> 
                        <FeatherIcon iconClassName="ml-2" size="18" name="Edit" tooltip={Lang('public.editor')} />{getRelation(data?.editor)}
                    </div>
                </div> 
            </Box>
        </Frame>
    );
}