"use client";

import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { Tools, Pic } from "@/Theme/Midone";

export function Register({ data }){
    const { Lang } = useLang();
    const { mediaPath } = useConfig();

    return <>
        <div className="grid grid-cols-12 gap-6">
            {data?.length > 0 ? (
                data.map((register, index) => (
                    <div key={index} className="intro-y box col-span-12 xxl:col-span-6">
                        <div className="p-5">
                            <div className="relative flex items-center">
                                <div className="w-12 h-12 flex-none image-fit">
                                    <Pic src={`${mediaPath}/courses/${register?.course?.thumbnail}`} defaultImg={`${mediaPath}/public/default/course.jpg`} classImg="rounded-full"  />
                                </div>
                                <div className="mr-4 ml-auto">
                                    <a href="#" className="font-medium">
                                        {`${register?.course?.title} - ${register?.course?.code}`}
                                    </a>
                                    <div className="text-gray-600 ml-5 mt-3 sm:mr-5">
                                        {`${Tools?.formatDateSh(register?.start_date, "/")} - ${Tools?.formatDateSh(register?.end_date, "/")}`}
                                    </div>
                                </div>
                                <div className="py-1 px-2 rounded-full text-xs bg-theme-10 text-white cursor-pointer font-medium">{register?.role?.title_fa}</div>
                            </div>
                        </div>
                    </div>
                ))
            ) : (
                <div className="intro-y p-5 text-center box col-span-12 xxl:col-span-6 text-theme-22">
                    <strong className="text-center">{Lang("public.no_data_user_registered")}</strong>
                </div>
            )}
        </div>
    </>;
}