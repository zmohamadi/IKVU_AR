"use client";

import { useLang } from "@/lib/lang";
import { useAuth } from "@/lib/auth";

export function AssInfo({ data }) {
    const { Lang } = useLang();
    const { user } = useAuth({ guard: "admin" });
    const access = user?.role_id !== 2;
    const isAdmin = ![1, 2, 3].includes(user?.role_id);
    // Determine group information based on data.group
    let group = data?.group;
    if (group > 0) {
        let year = data?.group?.substr(0, 4);
        let semester = data?.group?.substr(4, 1);
        let groupCode = data?.group?.substr(5, 2);

        // Construct group details based on available information
        group = Lang("public.year") + " : " + year + " , " + Lang("public.semester") + " : " + semester + " , ";
        if (groupCode > 0) {
            group += Lang("public.group") + " : " + groupCode;
        } else {
            group += Lang("public.all_groups");
        }
    } else {
        group = Lang("public.all_time");
    }
    let details = Lang("public.assignment_score") + " : " + data?.score;
    if(data?.session>0) details += " , " + Lang(["public.assignment"," ","public.session"]) + " : " + data?.session;

    return (
        <div className="ads-box box p-8 relative overflow-hidden bg-theme-17 intro-y mt-3 sm:mt-0">
            <div className="ads-box__title w-full sm:w-72 text-white text-xl -mt-3">{data?.title}</div>
            <div className="w-full sm:w-72 leading-relaxed text-white text-opacity-70 dark:text-gray-600 dark:text-opacity-100 mt-4">{group}</div>
            <div className="w-full sm:w-72 leading-relaxed text-white text-opacity-70 dark:text-gray-600 dark:text-opacity-100 mt-4">{details}</div>
            <div className="w-full sm:w-72 leading-relaxed text-white text-opacity-70 dark:text-gray-600 dark:text-opacity-100 mt-4 ltr">{Lang("public.date")} : {data?.start_date} - {data?.expire_date}</div>
            {access&&<><div className="w-full sm:w-72 leading-relaxed text-white text-opacity-70 dark:text-gray-600 dark:text-opacity-100 mt-3">{Lang("public.report")} {Lang("public.reply")}  : {data?.answer_count}  , {Lang("public.correcting_report")} : {data?.corrected_count}</div>
                <div className="w-full sm:w-72 leading-relaxed text-white text-opacity-70 dark:text-gray-600 dark:text-opacity-100 mt-3">{Lang("public.min")} {Lang("public.score")} : {data?.min ? data?.min : 0} , {Lang("public.max")} {Lang("public.score")} : {data?.max ? data?.max : 0} , {Lang("public.avg")} {Lang("public.score")} : {data?.avg ? data?.avg : 0}</div>
                </>}
            {/* <img className="hidden sm:block absolute top-0 left-0 w-1/2 mb-1 -ml-12" alt="Icewall Tailwind HTML Admin Template" src="http://127.0.0.1:8000/admin/Midone-v3/Icewall_v1.0.9/dist/images/phone-illustration.svg" /> */}
        </div>
    );
}
