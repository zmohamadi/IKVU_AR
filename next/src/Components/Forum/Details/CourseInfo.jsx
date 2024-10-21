"use client";

import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { Pic } from "@/Theme/Midone";

export function CourseInfo({data}){
    const {local} = useLang();
    const {mediaPath} = useConfig();
    let limit = 100;
    let description = data?.description;
    if(description?.length > limit) description = description?.substring(0, limit)+"...";

    return(
        <>
            <div className="col-span-12 lg:col-span-6 mt-6">
                <div className="ads-box box p-8 relative overflow-hidden intro-y">
                    <div className="ads-box__title w-full sm:w-52 text-theme-17 dark:text-white text-xl -mt-3">{data?.title+" ( "+data?.code+" ) "}
                    </div>
                    <div className="w-full sm:w-60 leading-relaxed text-gray-600 mt-2">{data?.category?.["title_"+local]}</div>
                    {/* <div className="w-full sm:w-60 leading-relaxed text-gray-600 mt-2">{data?.code}</div> */}
                    <div className="w-full sm:w-72 leading-relaxed text-gray-600 mt-2" dangerouslySetInnerHTML={{__html: description}} />
                    <Pic src={`${mediaPath}/courses/${data?.thumbnail}`} defaultImg={`${mediaPath}/public/default/course.jpg`} classImg="hidden sm:block absolute top-0 left-0 w-1/2 mb-1 -ml-12" />
                </div>
            </div>
        </>
    );
}