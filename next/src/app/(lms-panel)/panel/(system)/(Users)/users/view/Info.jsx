"use client";

import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { FeatherIcon, Pic } from "@/Theme/Midone";

export function Info({ item, linkView }){
    const { Lang, local } = useLang();
    const { mediaPath, nextAdmin } = useConfig();
    
    return <>
        <div className="intro-y box mt-5 lg:mt-0">
            <div className="relative flex items-center p-5">
                <div className="w-12 h-12 image-fit">
                    <Pic src={`${mediaPath}/users/${item?.photo}`} defaultImg={`${mediaPath}/public/default/avatar.png`} classImg="rounded-full" key={"img"+item?.photo} />
                </div>
                <div className="mr-4 ml-auto">
                    <div className="font-medium text-base">
                        {`${item?.role?.["title_" + local]} : ${item?.firstname} ${item?.lastname}`}
                    </div>
                </div>
            </div>
            {/* <div className="p-5 border-t border-gray-200 dark:border-dark-5">
                {[
                    { href: `${nextAdmin}/classes/users/${item?.id}`, icon: "BookOpen", text: Lang("public.classes") },
                    { href: `${nextAdmin}/quizs/users/${item?.id}`, icon: "Package", text: Lang("public.quizs") },
                ].map((link, index) => (
                    <a key={index} className="flex items-center mt-5" href={link.href}>
                        <FeatherIcon size="18"  iconClassName="ml-1" name={link.icon} url={link.href} tooltip={link.text} />
                        {link.text}
                        <FeatherIcon size="18" color="blue"  iconClassName="ml-1" name="ArrowLeft" url={link.href} tooltip={link.text} />
                    </a>
                ))}
            </div> */}
            <div className="p-5 border-t border-gray-200 dark:border-dark-5">
                {[
                    { href: `${nextAdmin}/${linkView}/${item?.id}/edit`, icon: "User", text:Lang("public.edit_profile") },
                    { href: `${nextAdmin}/changePassword/${item?.id}`, icon: "Lock", text: Lang("public.change_password") },
                ].map((link, index) => (
                    <a key={index} className="flex items-center mt-3" href={link.href}>
                        <FeatherIcon size="18" iconClassName="ml-1" name={link.icon} url={link.href} tooltip={link.text} />
                        {link.text}
                    </a>
                ))}
            </div>
        </div>
    </>;
}