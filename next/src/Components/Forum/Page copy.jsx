"use client";

import { useLang } from "@/lib/lang";
import { useUtility } from "@/lib/utility";
import { useRouter } from "next/navigation";
import { useState } from "react";
import Link from "next/link";
import { Button, ButtonContainer } from "@/Theme/Midone/Forms";
import { Grid,Frame,useData,FeatherIcon } from "@/Theme/Midone/Utils";

export function Page({ laraPath,nextPath,course }) {
    const { Lang, local } = useLang();
    const { destroy,getNeedles } = useData();
    const router = useRouter();
    const back = ()=>router.back();
    const nextUrl = nextPath+"/courses/"+course+"/tools";
    const formUrl = "/forum";
    const { getYearSemester, getGroupCode } = useUtility();
    const [getAccess, setGetAccess] = useState();

    let info = {
        insertLink: getAccess? nextUrl+formUrl+"/new": "",
        url: laraPath+"/forum-list?course="+course,
        columns: [
            {label: "title", jsx: (item)=><span>{<Link href={nextUrl+formUrl + "/" + item?.id + "/posts"}>{item?.title}</Link>}</span>},
            {label: "year_semester", jsx: (item) => getYearSemester(item?.group, Lang)},
            {label: "group", jsx: (item)=>getGroupCode(item?.group, Lang)},
            (getAccess)? {label: "last_post", field: "last_post"}
            : {label: "last_post",  field: "last_post_general"},
            getAccess? {label: "subjects", field: "count_post_parent"}:'',
            getAccess? {label: "posts", field: "count_post"}:'',
            getAccess? {label: "not_check", field: "count_post_not_check"}:'',
            getAccess? {label: "status", jsx: (item)=><span className={"text-"+item?.active_status?.color}>{item?.active_status?.["title_"+local]}</span>}:'',
            // getAccess? {label: "need_confirmation", jsx:(item)=> (item?.need_to_apply)? <FeatherIcon spanWrapperClass="btn-cursor-default" name="Check" /> : "" }:'',
            // {label: "lock", jsx:(item)=> (item?.lock)? <FeatherIcon spanWrapperClass="btn-cursor-default" name="Lock" color="darkred" />
            //     : <FeatherIcon spanWrapperClass="btn-cursor-default" name="Unlock" /> },
            // getAccess? {label: "status", jsx: (item)=><span className={"text-"+item?.active_status?.color}>{item?.active_status?.["title_"+local]}</span>}:'',
            {label: "", sort:false, width:"160px", jsx:(item)=><>
                    <div className='flex justify-center'>
                        <FeatherIcon name="MessageCircle" url={nextUrl+formUrl + "/" + item?.id + "/posts"} tooltip={Lang('public.posts')} />
                        <FeatherIcon name="Edit" access={getAccess} url={nextUrl+formUrl + "/" + item?.id + "/edit"} tooltip={Lang('public.edit')} />
                        <FeatherIcon name="Eye" access={getAccess} url={nextUrl+formUrl + "/" + item?.id} tooltip={Lang('public.view')} />
                        <FeatherIcon name="XOctagon" access={getAccess} tooltip={Lang('public.delete')} color="darkred" onClick={() => destroy(laraPath+formUrl+"/" + item?.id)} />
                    </div>
                </>
            },
        ],
        callback: (data)=>{ setGetAccess(data?.accessOperation) }
    }

    return(
        <Frame title={Lang(["public.forums"])}>
            <div className="intro-y col-span-12">
                {getAccess?
                    <>
                    <div className="intro-x col-span-12">
                        <Link className="btn btn-primary w-30 ml-1 mt-2 float-left" href={nextUrl+formUrl+"/report"}>{Lang(["public.report"])}</Link>
                        <Link className="btn btn-primary w-30 ml-1 mt-2 float-left" href={nextUrl+formUrl+"/needCheck"}>{Lang(["public.btn_not_check"])}</Link>
                    </div>
                        {/* <Link className="btn btn-primary w-30 ml-1 mt-2 float-left" href={nextUrl+formUrl+"/report"}>{Lang(["public.report"])}</Link>
                        <Link className="btn btn-primary w-30 ml-1 mt-2 float-left" href={nextUrl+formUrl+"/needCheck"}>{Lang(["public.btn_not_check"])}</Link> */}
                    </>
                    : ""}
                <Grid {...info} key={"table key"} />
                <ButtonContainer>
                    <Link className="btn btn-primary w-20 mr-1 ml-1" href={nextUrl}>{Lang(["public.tools_link"])}</Link>
                    <Button label="back" onClick={back} />
                </ButtonContainer>
            </div>
        </Frame>
    );
}