
"use client"

import { useLang } from "@/lib/lang";
import { useEffect,useState } from "react";
import { Frame,FeatherIcon,useData,Tools } from "@/Theme/Midone/Utils";
import { Items } from "@/Components/Forum/Reply/Items";

export const List = ({ laraPath }) => {
    const { Lang } = useLang();
    const { getNeedles } = useData();
    const [item, setItem] = useState();

    useEffect(() => {
        getNeedles(`${laraPath}/forum/report`, setItem);
    }, []);
    useEffect(() => {
        changeCalss("subject");
    }, [item]);

    const changeCalss = (tab)=>{
        window?.$(".classTab").removeClass("border-2 border-theme-17 dark:border-theme-17 active");
        window?.$(`#${tab}-tab`).addClass("border-2 border-theme-17 dark:border-theme-17 active");
        window?.$(".classTabList").removeClass(" active");
        window?.$(`#${tab}`).addClass(" active");
    };
    
    return(
        <Frame title={Lang(["public.forum"])}>
            <div className="col-span-12 md:col-span-12 xxl:col-span-12 mt-3 xxl:mt-6">
                {(item == undefined)?
                    <span className="alert alert-success-soft show flex items-center mb-2 mt-5">{Lang("public.grid_loading")+"....."}</span>
                :
                    <>
                        {/* <div className="intro-y flex items-center mt-8">
                            <h2 className="text-lg font-medium ml-auto"> چینش پرسش و پاسخ </h2>
                        </div>                             */}
                        <div className="post__tabs nav nav-tabs mt-1" role="tablist">
                            <div className="grid grid-cols-12 gap-6 mt-5">
                                <a href="#" data-toggle="tab" data-target="#subject" id="subject-tab" role="tab" aria-controls="content" aria-selected="true"
                                    className="intro-y col-span-12 lg:col-span-4 box py-10 classTab btn-cursor-default" onClick={()=>changeCalss("subject")}
                                >
                                    <FeatherIcon spanWrapperClass="block w-12 h-12 text-theme-17 dark:text-gray-300 mx-auto btn-cursor-default" name="Layers" /> 
                                    <div className="font-medium text-center text-base mt-3">{Lang("public.subjects")}</div>
                                    <div className="text-gray-600 mt-2 w-3/4 text-center mx-auto">آماری از ثبت موضوعات جهت شروع یک گفتگو</div>
                                </a>
                                <a href="#" data-toggle="tab" data-target="#reply" id="reply-tab" role="tab" aria-controls="content" aria-selected="false"
                                    className="intro-y col-span-12 lg:col-span-4 box py-10 classTab btn-cursor-default" onClick={()=>changeCalss("reply")}
                                >
                                    <FeatherIcon spanWrapperClass="block w-12 h-12 text-theme-17 dark:text-gray-300 mx-auto btn-cursor-default" name="Mail" /> 
                                    <div className="font-medium text-center text-base mt-3">{Lang("public.replys")}</div>
                                    <div className="text-gray-600 mt-2 w-3/4 text-center mx-auto">آماری از گفتگوهای ثبت شده ذیل موضوعات مختلف جهت پاسخ در حساب کاربری</div>
                                </a>
                                <a href="#" data-toggle="tab" data-target="#like" id="like-tab" role="tab" aria-controls="content" aria-selected="false"
                                    className="intro-y col-span-12 lg:col-span-4 box py-10 classTab btn-cursor-default" onClick={()=>changeCalss("like")}
                                >
                                    <FeatherIcon spanWrapperClass="block w-12 h-12 text-theme-17 dark:text-gray-300 mx-auto btn-cursor-default" name="BarChart2" />
                                    <div className="font-medium text-center text-base mt-3">{Lang("public.votes")}</div>
                                    <div className="text-gray-600 mt-2 w-3/4 text-center mx-auto">آماری از رأی های موافق و مخالف کاربران در گفتگوها</div>
                                </a>
                            </div>
                        </div>
                        <div className="post__content tab-content">
                            <div className="grid grid-cols-12 gap-6 mt-5">
                                <div className="col-span-12 lg:col-span-12 tab-pane classTabList" id="subject" role="tabpanel" aria-labelledby="content-tab">
                                    <div class="intro-y box mt-5">
                                        <div class="flex flex-col sm:flex-row items-center p-5 border-b border-gray-200">
                                            <h2 class="font-medium text-base ml-auto">{Lang("public.subjects")}</h2>
                                        </div>
                                        <div class="p-5" id="row-states-table">
                                            <div class="preview">
                                                <div class="overflow-x-auto">
                                                    <table class="table">
                                                        <thead>
                                                            <tr>
                                                                <th class="border-b-2 dark:border-dark-5 whitespace-nowrap">{Lang("public.report_subjects")}</th>
                                                                <th class="border-b-2 dark:border-dark-5 whitespace-nowrap">{Lang("public.this_month")}</th>
                                                                <th class="border-b-2 dark:border-dark-5 whitespace-nowrap">{Lang("public.last_month")}</th>
                                                                <th class="border-b-2 dark:border-dark-5 whitespace-nowrap">{Lang("public.total")}</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr class="bg-theme-14 text-white">
                                                                <td class="border-b dark:border-dark-5">{Lang("public.general")}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_general}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_general}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_general}</td>
                                                            </tr>
                                                            <tr class="bg-theme-31 text-white">
                                                                <td class="border-b dark:border-dark-5">{Lang("public.private")}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_private}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_private}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_private}</td>
                                                            </tr>
                                                            <tr class="bg-theme-23 text-white">
                                                                <td class="border-b dark:border-dark-5">{Lang("public.not_check")}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_need_check}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_need_check}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_need_check}</td>
                                                            </tr>
                                                            <tr class="bg-theme-24 text-white">
                                                                <td class="border-b dark:border-dark-5">{Lang("public.rejected")}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_rejected}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_rejected}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_rejected}</td>
                                                            </tr>
                                                            <tr class="bg-theme-10 text-white">
                                                                <td class="border-b dark:border-dark-5">{Lang("public.answered")}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_answered}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_answered}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_answered}</td>
                                                            </tr>
                                                            <tr class="bg-theme-26 text-white">
                                                                <td class="border-b dark:border-dark-5">{Lang(["public.created_by","public.teacher"])}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_created_by_teacher}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_created_by_teacher}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_created_by_teacher}</td>
                                                            </tr>
                                                            <tr class="bg-theme-26 text-white">
                                                                <td class="border-b dark:border-dark-5">{Lang(["public.created_by","public.student"])}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_created_by_student}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_created_by_student}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_created_by_student}</td>
                                                            </tr>
                                                            <tr class="bg-theme-26 text-white">
                                                                <td class="border-b dark:border-dark-5">{Lang(["public.created_by","public.personnels"])}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_created_by_personnels}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_created_by_personnels}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.sub_created_by_personnels}</td>
                                                            </tr>
                                                            <tr class="bg-theme-30">
                                                                <td class="border-b dark:border-dark-5">{Lang(["public.total","public.subjects"])}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.subjects}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.subjects}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.subjects}</td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div className="col-span-12 lg:col-span-12 tab-pane classTabList" id="reply" role="tabpanel" aria-labelledby="content-tab">
                                    <div class="intro-y box mt-5">
                                        <div class="flex flex-col sm:flex-row items-center p-5 border-b border-gray-200">
                                            <h2 class="font-medium text-base ml-auto">{Lang("public.replys")}</h2>
                                        </div>
                                        <div class="p-5" id="row-states-table">
                                            <div class="preview">
                                                <div class="overflow-x-auto"> 
                                                    <table class="table">
                                                        <thead>
                                                            <tr>
                                                                <th class="border-b-2 dark:border-dark-5 whitespace-nowrap">{Lang("public.report_subjects")}</th>
                                                                <th class="border-b-2 dark:border-dark-5 whitespace-nowrap">{Lang("public.this_month")}</th>
                                                                <th class="border-b-2 dark:border-dark-5 whitespace-nowrap">{Lang("public.last_month")}</th>
                                                                <th class="border-b-2 dark:border-dark-5 whitespace-nowrap">{Lang("public.total")}</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr class="bg-theme-14 text-white">
                                                                <td class="border-b dark:border-dark-5">{Lang("public.general")}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_general}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_general}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_general}</td>
                                                            </tr>
                                                            <tr class="bg-theme-31 text-white">
                                                                <td class="border-b dark:border-dark-5">{Lang("public.private")}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_private}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_private}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_private}</td>
                                                            </tr>
                                                            <tr class="bg-theme-23 text-white">
                                                                <td class="border-b dark:border-dark-5">{Lang("public.not_check")}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_need_check}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_need_check}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_need_check}</td>
                                                            </tr>
                                                            <tr class="bg-theme-24 text-white">
                                                                <td class="border-b dark:border-dark-5">{Lang("public.rejected")}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_rejected}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_rejected}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_rejected}</td>
                                                            </tr>
                                                            <tr class="bg-theme-26 text-white">
                                                                <td class="border-b dark:border-dark-5">{Lang(["public.send_by","public.teacher"])}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_send_by_teacher}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_send_by_teacher}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_send_by_teacher}</td>
                                                            </tr>
                                                            <tr class="bg-theme-26 text-white">
                                                                <td class="border-b dark:border-dark-5">{Lang(["public.send_by","public.student"])}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_send_by_student}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_send_by_student}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_send_by_student}</td>
                                                            </tr>
                                                            <tr class="bg-theme-26 text-white">
                                                                <td class="border-b dark:border-dark-5">{Lang(["public.send_by","public.personnels"])}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_send_by_personnels}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_send_by_personnels}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.post_send_by_personnels}</td>
                                                            </tr>
                                                            <tr class="bg-theme-30">
                                                                <td class="border-b dark:border-dark-5">{Lang(["public.total","public.posts"])}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.posts}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.posts}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.posts}</td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div className="col-span-12 lg:col-span-12 tab-pane classTabList" id="like" role="tabpanel" aria-labelledby="content-tab">
                                    <div class="intro-y box mt-5">
                                        <div class="flex flex-col sm:flex-row items-center p-5 border-b border-gray-200">
                                            <h2 class="font-medium text-base ml-auto">{Lang("public.votes")}</h2>
                                        </div>
                                        <div class="p-5" id="row-states-table">
                                            <div class="preview">
                                                <div class="overflow-x-auto">
                                                    <table class="table">
                                                        <thead>
                                                            <tr>
                                                                <th class="border-b-2 dark:border-dark-5 whitespace-nowrap">{Lang("public.report_subjects")}</th>
                                                                <th class="border-b-2 dark:border-dark-5 whitespace-nowrap">{Lang("public.this_month")}</th>
                                                                <th class="border-b-2 dark:border-dark-5 whitespace-nowrap">{Lang("public.last_month")}</th>
                                                                <th class="border-b-2 dark:border-dark-5 whitespace-nowrap">{Lang("public.total")}</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <tr class="bg-theme-10 text-white">
                                                                <td class="border-b dark:border-dark-5">{Lang("public.like")}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.vote_like}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.vote_like}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.vote_like}</td>
                                                            </tr>
                                                            <tr class="bg-theme-24 text-white">
                                                                <td class="border-b dark:border-dark-5">{Lang("public.dislike")}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.vote_dislike}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.vote_dislike}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.vote_dislike}</td>
                                                            </tr>
                                                            <tr class="bg-theme-30">
                                                                <td class="border-b dark:border-dark-5">{Lang(["public.total","public.votes"])}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.votes}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.votes}</td>
                                                                <td class="border-b dark:border-dark-5">{item?.votes}</td>
                                                            </tr>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </>
                }
            </div>
        </Frame>
    );
}
