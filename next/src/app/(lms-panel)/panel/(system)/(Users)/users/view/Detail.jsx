"use client";

import { useLang } from "@/lib/lang";
import { useUtility } from "@/lib/utility";

export function Detail({ item }){
    const { Lang,local } = useLang();
    const { getRelation,getField } = useUtility();

    // const renderDetailRow = (label, value) => (
    //     <p className="mt-3">
    //         {`${label} : ${value}`}
    //     </p>
    // );

    return <>
        <div className="intro-y box p-5 bg-theme-17 text-white mt-5">
            <div className="flex items-center">
                <div className="font-medium text-lg">{Lang("public.more_detail")}</div>
            </div>
            <div className="mt-4">
                {/* {renderDetailRow(Lang("public.gender"), item?.gender?.["title_" + local])}
                {renderDetailRow(Lang("public.codemeli"), getField(item?.codemeli))}
                {renderDetailRow(Lang("public.username"), getField(item?.username))}
                {renderDetailRow(Lang("public.mobile"), item?.mobile)}
                {renderDetailRow(Lang("public.email"), item?.email)}
                {renderDetailRow(Lang("public.studentID"), item?.studentID?? "---")}
                {renderDetailRow(Lang("public.personID"), item?.person_id?? "---")}
                {renderDetailRow(Lang("public.creator"), getRelation(item?.creator))}
                {renderDetailRow(Lang("public.editor"), getRelation(item?.editor))} */}
                {[
                    { label: "public.gender", value: item?.gender?.["title_" + local] },
                    { label: "public.codemeli", value: getField(item?.codemeli) },
                    { label: "public.username", value: getField(item?.username) },
                    { label: "public.mobile", value: item?.mobile },
                    { label: "public.email", value: getField(item?.email) },
                    { label: "public.studentID", value: getField(item?.studentID) },
                    // { label: "public.personID", value: item?.person_id?? "---" },
                    { label: "public.creator", value: getRelation(item?.creator) },
                    { label: "public.editor", value: getRelation(item?.editor) },
                ].map((detail, index) => (
                    <p key={index} className="mt-3">
                        {`${Lang(detail.label)} : ${detail.value}`}
                    </p>
                ))}
            </div>
            <div className="font-medium flex mt-5">
                <span  className={`btn py-1 px-2 border-white mr-auto btn-cursor-default`}> {item?.active_status?.["title_" + local]} </span>
            </div>
        </div>
    </>;
}