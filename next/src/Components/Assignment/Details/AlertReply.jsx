"use client";

import { useLang } from "@/lib/lang";
import { useRouter } from 'next/navigation';
import { ButtonContainer,Button, Box } from "@/Theme/Midone/Forms";
import { FeatherIcon } from "@/Theme/Midone/Utils";

export function AlertReply({ data, result }){
        const {Lang} = useLang();
        const router = useRouter();
        const back = ()=>router.back();

        return <>
                <Box cols="grid-cols-1" className="text-theme-22">
                        <div className="flex">
                                <FeatherIcon name="AlertTriangle" className="w-4" />
                                <strong className="pt-1 pb-3 pr-3">{Lang("public."+result?.status)} ! </strong>
                        </div>
                        <div className="flex">
                                {Lang("public.response_deadline")} : <b className="pl-2 pr-2" dir="ltr">{data?.start_date} - {data?.expire_date}</b>
                        </div>
                </Box>
        </>;
}