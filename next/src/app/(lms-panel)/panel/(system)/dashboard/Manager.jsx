"use client";

import  {GeneralReport}  from "@/Components/Dashboard/GeneralReport";
import { useConfig } from "@/lib/config";
import { useFormRefs } from "@/Theme/Midone";
import { useData } from "@/Theme/Midone/Utils/Data";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useAuth } from "@/lib/auth";
import { Mentees } from "@/Components/Dashboard/Mentees";
import { Course } from "@/Components/Dashboard/Course";

export default function Manager() {
    const { user } = useAuth({ guard: "admin" });
    const { Lang } = useLang();
    const {laraAdmin,nextAdmin} = useConfig();
    let {get} = useData();
    let component = useFormRefs();

    useEffect(() => {
        get(laraAdmin+"/home", component, "info");
    }, []);

    // console.log(component?.state?.info);
    let info  = component?.state?.info;
    return <>
        {/* <div> Dashboard!! </div> */}
        <div className="grid grid-cols-12 gap-6">
            <div className="col-span-12 xxl:col-span-12">
                <div className="grid grid-cols-12 gap-6">
                    <div className="col-span-12 mt-6 -mb-6 intro-y">
                        <div className="alert alert-dismissible show box bg-theme-26 text-white flex items-center mb-6" role="alert">
                            {Lang(["public.wellcome","public.to","public.main_title"])}
                        </div>
                        <GeneralReport data={info?.counts} />
                    </div>
                    {user?.role_id != 1 && user?.role_id != 3 ?<>
                        <div className="col-span-12 mt-6">
                            <Course data={info?.courses} title="last_courses" rel="courses" href={nextAdmin+"/courses"} />
                        </div>
                        <div className="col-span-6 mt-6">
                            <Mentees data={info?.teachers} title="last_teachers" rel="teachers" href={nextAdmin+"/teachers"} />
                        </div>
                        <div className="col-span-6  mt-6">
                            <Mentees data={info?.students} title="last_students" rel="students" href={nextAdmin+"/students"} />
                        </div>
                    </> : "" }
                </div>
            </div>
        </div>
    </>
}