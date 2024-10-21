"use client";

import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useRouter } from "next/navigation";
import { useState } from "react";
import Link from "next/link";
import { Button, ButtonContainer } from "@/Theme/Midone/Forms";
import { Grid,Frame,FeatherIcon, Pic } from "@/Theme/Midone/Utils";
import { useAuth } from "@/lib/auth";

export const List = ({ course,forum,laraPath,nextPath }) => {
    const { Lang, local } = useLang();
    const { mediaPath } = useConfig();
    const { user } = useAuth({ guard: "admin" });
    const router = useRouter();
    const back = ()=>router.back();
    const toolsUrl = nextPath+"/courses/"+course+"/tools";
    const nextUrl = toolsUrl+"/forum/"+forum;
    const formUrl = "/posts";
    const [getAccess, setGetAccess] = useState();
    const [lock, setLock] = useState();

    let info = {
        insertLabel: Lang('public.start_dialog'),
        insertLink: (lock)? "" : nextUrl+formUrl+"/new",
        url: laraPath+formUrl+"?course="+course+"&forum="+forum+"&type=starterPost",
        columns: [
            { label: "", jsx:(item)=><Pic src={`${mediaPath}/courses/${item?.sender?.photo}`} defaultImg={`${mediaPath}/public/default/course.jpg`} classImg="user-avatar" />},

            {label: "name", jsx: (item)=><span>{item?.sender?.firstname}</span>},
            {label: "lname", jsx: (item)=><span>{item?.sender?.lastname}</span>},
            {label: "subject_title", jsx: (item)=><span>{<Link href={nextUrl+formUrl + "/" + item?.id + "/reply"}>{item?.title}</Link>}</span>},
            (getAccess)? {label: "last_post", field: "last_post"}
            : {label: "last_post",  field: "last_post_general"},
            {label: "view", field: "count_view"},
            {label: "like", field: "count_like"},
            {label: "dislike", field: "count_dislike"},
            getAccess? {label: "status", jsx: (item)=><span className={"text-"+item?.type?.color}>{item?.type?.["title_"+local]}</span>}:'',
            {label: "", sort:false, width:"160px", jsx:(item)=><>
                    <div className='flex justify-center'>
                        <FeatherIcon name="Mail" url={nextUrl+formUrl + "/" + item?.id + "/reply"} tooltip={Lang('public.reply')} />
                        <FeatherIcon name="Edit" url={nextUrl+formUrl + "/" + item?.id + "/edit"} tooltip={Lang('public.edit')}
                            access={(!lock && (getAccess ||(item?.sender_id==user?.id && item?.type_id==0)))}
                        />
                    </div>
                </>
            },  
        ],
        callback: (data)=>{
            setGetAccess(data?.accessOperation);
            setLock(data?.lock)
        }
    }

    return(
        <Frame title={Lang(["public.forums"])}>
            <div className="intro-y col-span-12">
                <Grid {...info} key={"table key"} />
                <ButtonContainer>
                    <Link className="btn btn-success  w-20 mr-1 ml-1" href={toolsUrl}>{Lang(["public.tools_link"])}</Link>
                    <Button label="back" onClick={back} />
                </ButtonContainer>
            </div>
        </Frame>
    );
}