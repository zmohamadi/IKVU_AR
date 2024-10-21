"use client";

import { useLang } from "@/lib/lang";
import { useUtility } from "@/lib/utility";
import { Tools } from "@/Theme/Midone/Utils";

export function ForumComplete({data}){
    const {Lang,local} = useLang();
    const { getRelation } = useUtility();
    const dateCreated = Tools.toJalaliDateString(data?.created_at);

    return <>
            <div className="intro-y box p-5 bg-theme-17 text-white mt-5">
                <div className="flex items-center">
                    <div className="font-medium text-lg">{Lang("public.view_info")}</div>
                </div>
                <div className="mt-4">{Lang("public.created_at")+" : "}<span dir="ltr">{dateCreated}</span></div>
                <div className="mt-4">{Lang("public.creator")+" : "+getRelation(data?.creator)}</div>
                <div className="mt-4">{Lang("public.editor")+" : "+getRelation(data?.editor)}</div>
                <div className="mt-4">{Lang("public.last_post")+" : "}
                    <br/>{data?.last_post}
                </div>
                <div className="mt-4">{Lang("public.last_post_general")+" : "}
                    <br/>{data?.last_post_general}
                </div>
                <div className="mt-4">{Lang("public.subjects")+" : "+data?.count_post_parent}</div>
                <div className="mt-4">{Lang("public.posts")+" : "+data?.count_post}</div>
                <div className="mt-4">{Lang("public.not_check")+" : "+data?.count_post_not_check}</div>
                <div className="mt-4">{Lang("public.status")+" : "}<span className={"text-"+data?.active_status?.color}>{data?.active_status?.["title_"+local]}</span></div>
            </div>
        </>;
}