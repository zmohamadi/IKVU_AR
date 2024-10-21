"use client";

import { useLang } from "@/lib/lang";
import { useConfig } from '@/lib';
import { Tools,Pic,FeatherIcon } from "@/Theme/Midone/Utils";
import { Files } from "@/Components/Assignment/Details";
import {icons} from "@/lib/icons";

export function OtherReply({ detail }) {
    const { Lang,local } = useLang();
    const { mediaPath } = useConfig();
    
    return (
        detail?.length > 0?
            <>
                <div className="intro-x flex items-center h-10">
                    <FeatherIcon spanWrapperClass="text-left" name="ArrowDownCircle" onClick={() => Tools?.scrollPage(true,"")} />
                </div>
                {detail?.map((detail, index)=>{
                    let number = index+1;
                    let classM = (index > 0)? "mt-5":"";
                    let user = detail?.user_info1;
                    const gender = user?.gender?.["title_" + local] + (user?.gender_id == 1 ? Lang(["public.y"]) + " " : "");
                    let attachments = (detail?.files)? detail?.files?.split("###") : [];
                    let calssBorder = (attachments != "")? " border-t " : "";
                    
                    return(
                        (detail?.answer_text)?
                            <div class={"intro-y box "+classM}>
                                <div id="new-products" className="tiny-slider py-5">
                                    <div className="px-5">
                                        <div className="flex flex-col lg:flex-row items-center pb-0">
                                            <div className="flex flex-col sm:flex-row items-center pl-5 border-gray-200 dark:border-dark-5">
                                                <div className="sm:mr-5">
                                                    <div className="w-20 h-20 image-fit relative">
                                                        <div className="absolute" style={{right: "-40px", bottom: "-22px"}}>
                                                            {(detail?.seeing)? icons.seeing : icons.seeingNot}
                                                        </div>
                                                        <Pic classImg="rounded-full" src={mediaPath + "/users/" + user?.photo} defaultImg={`${mediaPath}/public/default/avatar.png`} key={"img" + user?.photo} />
                                                    </div>
                                                </div>
                                                <div className="ml-auto text-center sm:text-right mt-3 sm:mt-0">
                                                    <a className="font-medium text-lg">{gender+" "+user?.firstname+" "+user?.lastname}</a> 
                                                    <div className="text-gray-600 mt-3 sm:mt-3">{Lang(["public.reply"])+" "+number+" : "+detail?.answer_text}</div>
                                                </div>
                                            </div>
                                        </div>
                                        <div className="flex flex-col sm:flex-row items-center border-t border-gray-200 dark:border-dark-5 pt-5"> 
                                            <Files data={attachments} Lang={Lang} />
                                            <div className={`w-full sm:w-auto sm:mr-auto flex justify-center sm:justify-start items-center sm:border-t-0${calssBorder}border-gray-200 dark:border-dark-5 pb-5 sm:pb-0`}>
                                                <div className="px-3 py-2 bg-theme-31 dark:bg-dark-5 dark:text-gray-300 text-theme-26 rounded font-medium ml-3 ltr mt-5 sm:mt-0">
                                                    {Tools?.toJalaliDateString(detail?.created_at)}
                                                </div>
                                                <div className="text-gray-600">{Lang("public.created_at")}</div>
                                            </div>
                                        </div>
                                    </div>    
                                </div>
                            </div>
                        : ""
                    );
                })}
                <div className="intro-x flex items-center h-10">
                    <FeatherIcon name="ArrowUpCircle" onClick={() => Tools?.scrollPage(false,"")} />
                </div>
            </>
        : ""
    );
}
 