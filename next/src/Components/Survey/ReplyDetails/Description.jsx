"use client";

import { useLang } from "@/lib/lang";

export function Description({data}){
    const {Lang} = useLang();

    return <>
            <div className="intro-y box p-5 bg-theme-17 text-white mt-5">
                <div className="flex items-center">
                    <div className="font-medium text-lg">{Lang("public.replay_description_title")}</div>
                </div>
                <div className="mt-4">{data}</div>
            </div>
        </>;
}