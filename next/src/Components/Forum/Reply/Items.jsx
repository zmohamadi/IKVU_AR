"use client"

import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useEffect, useState } from "react";
import { useData,useFormRefs,Radio } from "@/Theme/Midone/Forms";
import { FeatherIcon,Pic,Tools } from "@/Theme/Midone/Utils";
import { useUtility } from "@/lib/utility";
import { Select } from "@/Theme/Midone/Forms/Select";
import { Files } from "@/Components/Forum/Reply/Files";
import { LikedUsers } from "@/Components/Forum/Reply/LikedUsers";
import styles from "./styles.module.css";
import { useAuth } from "@/lib/auth";

export const Items = ({ item,laraPath,nextPath="",nextUrl="",backStatus,backAction,formAction,subPost,displayIcon=true,status=[],getAccess=false,lock }) => {
    const {Lang,local} = useLang();
    const {mediaPath} = useConfig();
    const { user } = useAuth({ guard: "admin" });
    const { postData,save } = useData();
    let component = useFormRefs();
    let {reload} = useUtility();

    let url = laraPath+"/posts-action", method = "new";

    const getId = (id, paramAction, type="")=>
    {
        subPost(id);
        formAction(paramAction);
        if([0,1].includes(type)) saveAction(id, type);
        else Tools?.scrollPage(false, "0");
    }
    const saveAction = (id,type)=>save(url+"/"+id+"?type="+type, component, method, backAction);

    let displayReply = ""
    let displayEdit = ""
    let btnLike = <button className="btn btn-success mr-1 mb-2" onClick={()=>getId(item?.id, "", 1)}><FeatherIcon className="w-5 h-5" name="ThumbsUp" tooltip={Lang('public.like')} /></button>
    let btnDisLike = <button className="btn btn-danger mr-1 mb-2" onClick={()=>getId(item?.id, "", 0)}><FeatherIcon className="w-5 h-5" name="ThumbsDown" tooltip={Lang('public.dislike')} /></button>
    let countLike = <div className="mt-3 mr-1"><span className={"px-4 py-3 rounded-full bg-theme-10 text-white ml-0 " + styles.mark_count}>{item?.count_like}</span></div>
    let countDisLike = <div className="mt-3 mr-1"><span className={"px-4 py-3 rounded-full bg-theme-24 text-white ml-0 " + styles.mark_count}>{item?.count_dislike}</span></div>
    let actionLike = <mark className={"p-1 pt-3 mr-1 bg-green-200 text-white "+styles.mark}>{Lang("public.I_agree")}</mark>
    let actionDisLike = <mark className={"p-1 pt-3 mr-1 bg-red-200 text-white "+styles.mark}>{Lang("public.I_disagree")}</mark>
    let displayAction = <> {countLike} {countDisLike} </>

    if(!lock)
    {
        displayReply=<button className="btn btn-secondary mr-1 mb-2" onClick={()=>getId(item?.id, "reply", "")}><FeatherIcon className="w-5 h-5" name="Mail" tooltip={Lang('public.reply')}/></button>
        
        if(getAccess ||(item?.sender_id==user?.id && item?.type_id==0))
            displayEdit=<button className="btn btn-primary mr-1 mb-2" onClick={()=>getId(item?.id, "edit", "")}><FeatherIcon className="w-5 h-5" name="Edit2" tooltip={Lang('public.edit')}/></button>
    
        if(item?.myAction == undefined) displayAction = <> {btnLike} {countLike} {btnDisLike} {countDisLike} </>
        else if(item?.myAction == 0) displayAction = <> {countLike} {actionDisLike} {countDisLike} </>
        else if(item?.myAction == 1) displayAction = <> {actionLike} {countLike} {countDisLike} </>
    }

    let limit = 100;
    let parentReply = item?.parent_reply?.message;
    if(parentReply?.length > limit) parentReply = parentReply.substring(0, limit)+"...";
    
    const changeStatus = (e, id)=>{
        postData(laraPath+"/posts-update/change-status/"+id, {type_id: e.target.value}, 'edit', backStatus);
        // postData(laraPath+"/posts-update/change-status/"+id, {type_id: e.target.value}, 'edit', '', ()=>reload());
    }
    
    return(
        <>
            <div className="col-span-12 md:col-span-12 xxl:col-span-12" id={item?.id}>
                <div className="intro-x relative flex items-center mb-3">
                    <div className="report-timeline__image">
                        <div className="w-10 h-10 flex-none image-fit rounded-full overflow-hidden">
                            <Pic src={`${mediaPath}/users/${item?.sender?.photo}`} defaultImg={`${mediaPath}/public/default/avatar.png`} classImg="user-avatar" />
                        </div>
                    </div>
                    {/* <div className="box px-5 py-3 mr-4 md:flex w-full"> */}
                    <div className="box px-5 py-3 mr-4 w-full">
                        <div className="md:flex">
                            <div className="text-center md:w-48 flex flex-row md:flex-col">
                                <div className="font-medium ml-auto">{item?.sender?.firstname+" "+item?.sender?.lastname}</div>
                                <div className="font-medium mt-2">{item?.sender?.studentID}</div>
                                <div className="text-xs text-gray-500 mt-3" dir="ltr">
                                    {item?.created_at}
                                    <div className="text-xs text-gray-500 mt-1 mb-3"><span className={"text-"+item?.type?.color}>{item?.type?.["title_"+local]}</span></div>
                                </div>
                            </div>
                            <div className="md:border-r w-full dark:border-dark-5 md:mr-3 px-5">
                                <div className="flex items-center">
                                    <div className="font-medium">{item?.title}</div>
                                    {item?.parent_reply?
                                        <a href={"#"+item?.reply_to}><div className="alert alert-secondary show mb-2" role="alert">{parentReply}</div></a>
                                    : "" }
                                    {/* <div className="text-xs text-gray-500 mr-auto" dir="ltr">{item?.created_at}</div> */}
                                </div>
                                <div className="text-gray-600">
                                    <div className="mt-2 w-full text-justify">{item?.message}</div>
                                    <div className="mt-2 mb-3 border-b border-gray-200 dark:border-dark-5 pb-5">
                                        <div className="pos flex">
                                            <Files data = {item?.attachments} />
                                        </div>
                                    </div>
                                    <div className="nav nav-tabs flex-row justify-center lg:justify-start">
                                        {(displayIcon)?
                                            <>
                                                <div className="mr-auto"></div>
                                                {displayReply} {displayEdit} {displayAction}
                                            </>
                                        :
                                            <>
                                                {(nextUrl!="")? <button className="btn btn-secondary ml-3 mb-2">
                                                        {/* <FeatherIcon spanWrapperClass="mr-auto" name="Eye" tooltip={Lang('public.view')} url={(item?.parent_id == 0)? nextPath+nextUrl+"/"+item?.id : nextPath+nextUrl+"/"+item?.parent_id} /> */}
                                                        <FeatherIcon spanWrapperClass="mr-auto" name="Eye" tooltip={Lang('public.view')} url={nextPath+nextUrl+"/"+item?.parent_id+"/"+item?.id+"/#"+item?.id} />
                                                    </button>
                                                : "" }
                                                {(!lock && item?.type_id==0)? <Radio type="col" className="contents mr-3" label={Lang("public.display_status")} defaultValue={item?.type_id} refItem={[component, "type_id"]}
                                                            data={status} titleKey={"title_"+local} valueKey="code" onChange={(e)=>changeStatus(e, item?.id)}
                                                        />
                                                : "" }
                                            </>
                                        }
                                    </div>
                                </div>
                            </div> 
                        </div>
                        {item?.likeUsers?.length > 0?
                            <div className="nav nav-tabs flex-row justify-center lg:justify-start md:border-t dark:border-dark-5 mt-5">
                                <div class="p-5">
                                    {Lang("public.voters")+" : "}<LikedUsers likeUsers={item?.likeUsers} />
                                </div>
                            </div>
                        :
                            ""
                        }
                    </div>
                </div>
                {/* <div className="intro-x text-gray-500 text-xs text-center my-4">12 خرداد</div> */}
            </div>
        </>
    );
}