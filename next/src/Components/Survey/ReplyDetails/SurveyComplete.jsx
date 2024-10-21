"use client";

import { useLang } from "@/lib/lang";
import { useUtility } from "@/lib/utility";
import { Tools } from "@/Theme/Midone/Utils";

export function SurveyComplete({data, isPersonnel=false}){
    const {Lang,local} = useLang();
    const { getRelation } = useUtility();
    const dateCreated = Tools.toJalaliDateString(data?.created_at);

    return <>
            <div className="intro-y box p-5 bg-theme-17 text-white mt-5">
                <div className="flex items-center">
                    <div className="font-medium text-lg">{Lang("public.view_info")}</div>
                </div>
                <div className="mt-4">{Lang("public.created_at")+" : "}<span dir="ltr">{dateCreated}</span></div>
                {isPersonnel&&
                    <>
                        <div className="mt-4">{Lang("public.creator")+" : "+getRelation(data?.creator)}</div>
                        <div className="mt-4">{Lang("public.editor")+" : "+getRelation(data?.editor)}</div>
                    </>
                }
                <div className="mt-4">{Lang("public.question_count")+" : "+data?.count_question}</div>
                <div className="mt-4">{Lang("public.response_count")+" : "+data?.count_response}</div>
                <div className="mt-4">{Lang("public.status")+" : "}<span className={"text-"+data?.active_status?.color}>{data?.active_status?.["title_"+local]}</span></div>
            </div>
        </>;
}