"use client";

import { useLang } from "@/lib/lang";

export function SurveyInfo({data}){
    const {Lang} = useLang();
    let group = data?.group;
    if(group > 0)
    {
        let year = data?.group?.substr(0, 4);
        let semester = data?.group?.substr(4, 1);
        let groupCode = data?.group?.substr(5, 2);
        group = Lang("public.year")+" : "+year+" , "+Lang("public.semester")+" : "+semester+" , "+Lang("public.all_groups");
        if(groupCode > 0)
            group = Lang("public.year")+" : "+year+" , "+Lang("public.semester")+" : "+semester+" , "+Lang("public.group")+" : "+groupCode;
    }
    else group = Lang("public.all_time");

    return <>
            <div className="col-span-12 lg:col-span-6 mt-6">
                <div className="ads-box box p-8 relative overflow-hidden bg-theme-17 intro-y">
                    <div className="ads-box__title w-full sm:w-81 text-white text-xl -mt-3">{data?.title}</div>
                    <div className="w-full sm:w-72 leading-relaxed text-white text-opacity-70 dark:text-gray-600 dark:text-opacity-100 mt-4">{group}</div>
                    <div className="w-full sm:w-72 leading-relaxed text-white text-opacity-70 dark:text-gray-600 dark:text-opacity-100 mt-4">{Lang("public.start")+" : "+data?.start_date}</div>
                    <div className="w-full sm:w-72 leading-relaxed text-white text-opacity-70 dark:text-gray-600 dark:text-opacity-100 mt-3">{Lang("public.end")+" : "+data?.expire_date}</div>
                    <img className="hidden sm:block absolute top-0 left-0 w-1/2 mb-1 -ml-12" alt="Icewall Tailwind HTML Admin Template" src="http://127.0.0.1:8000/admin/Midone-v3/Icewall_v1.0.9/dist/images/phone-illustration.svg"/>
                    {/* <img className="hidden sm:block absolute top-0 left-0 w-2/5 -mt-3 ml-2" alt="Icewall Tailwind HTML Admin Template" src="http://127.0.0.1:8000/admin/Midone-v3/Icewall_v1.0.9/dist/images/woman-illustration.svg"/> */}
                </div>
            </div>
        </>;
}