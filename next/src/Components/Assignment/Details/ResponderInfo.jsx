"use client";

import { useLang } from "@/lib/lang";
import { useConfig } from '@/lib';
import { useAuth } from "@/lib/auth";
import { Pic,FeatherIcon } from "@/Theme/Midone/Utils";

export function ResponderInfo({ responder }) {
    const { Lang,local } = useLang();
    const { mediaPath } = useConfig();
    const { user } = useAuth({ guard: "admin" });
    const gender = responder?.gender?.["title_" + local] + (responder?.gender_id == 1 ? Lang(["public.y"]) + " " : "");

    return (
        <div className="intro-y box mt-3 mb-3">
            <div className="flex flex-col lg:flex-row items-center p-5">
                <div className="w-24 h-24 lg:w-12 lg:h-12 image-fit lg:ml-1">
                    <Pic classImg="rounded-full" src={mediaPath + "/users/" + responder?.photo} defaultImg={`${mediaPath}/public/default/avatar.png`} key={"img" + responder?.photo} />
                </div>
                <div className="lg:mr-2 lg:ml-auto text-center lg:text-right mt-3 lg:mt-0">
                    <a className="font-medium">{gender+" "+responder?.firstname+" "+responder?.lastname}</a>
                    <div className="sm:whitespace-normal flex items-center text-gray-600 mt-1">
                        <FeatherIcon iconClassName="ml-2 btn-cursor-default" size="18" name="UserCheck" tooltip={Lang('public.studentID')} />{responder?.studentID?? "---"}
                    </div>
                    <div className="sm:whitespace-normal flex items-center text-gray-600 mt-1">
                        <FeatherIcon iconClassName="ml-2 btn-cursor-default" size="18" name="PhoneCall" tooltip={Lang('public.mobile')} />{responder?.mobile?? "---"}
                    </div>
                    <div className="sm:whitespace-normal flex items-center text-gray-600 mt-1">
                        <FeatherIcon iconClassName="ml-2 btn-cursor-default" size="18" name="Mail" tooltip={Lang('public.email')} />{responder?.email?? "---"}
                    </div>
                </div>
            </div>
        </div>
    );
}
