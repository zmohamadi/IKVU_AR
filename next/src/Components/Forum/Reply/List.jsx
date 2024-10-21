
"use client"

import { useLang } from "@/lib/lang";
import { useState } from "react";
import { Grid,FeatherIcon,Tools } from "@/Theme/Midone/Utils";
import { Items } from "@/Components/Forum/Reply/Items";

export const List = ({ course, forum, parent="0", post, laraPath, formAction, subPost, statusLock=()=>{}, displayIcon=true, status=[] }) => {
    const {Lang} = useLang();
    const nextUrl = "/courses/"+course+"/tools/forum";
    const formUrl = "/posts";
    let sendParam = (parent == 0)? post : parent;
    const url = laraPath+formUrl+"?course="+course+"&post="+sendParam+"&type=allOnePost";
    const [getAccess, setGetAccess] = useState();
    const [lock, setLock] = useState();

    let info = {
        // url: laraPath+formUrl+"?forum="+forum+"&post="+post+"&type=allOnePost",
        url: url,
        theme: (item)=> <Items item={item} laraPath={laraPath} status={status} displayIcon={displayIcon} formAction={formAction} subPost={subPost}
                getAccess={getAccess} lock={lock} 
                backStatus={nextUrl+"/needCheck/"+parent+"/"+post+"?"+Math.random()} backAction={nextUrl+"/"+forum+formUrl+"/"+post+"/reply?"+Math.random()}
            />,
        callback: (data)=>{
            setGetAccess(data?.accessOperation);
            setLock(data?.lock)
            statusLock(data?.lock)
        }
    }

    return(
        <>
            <div className="col-span-12 md:col-span-12 xxl:col-span-12 mt-3 xxl:mt-6">
                <div className="intro-x flex items-center h-10">
                    <FeatherIcon spanWrapperClass="text-left" name="ArrowDownCircle" onClick={() => Tools?.scrollPage(true,"")} />
                    <h2 className="text-lg font-medium truncate mr-3">{Lang("public.messages")}</h2>
                </div>
                <div className="report-timeline mt-5 relative">
                    <Grid {...info} activeSearch={false} key={"table key"} />
                </div>
                <FeatherIcon name="ArrowUpCircle" onClick={() => Tools?.scrollPage(false,"")} />
            </div>
        </>
    );
}
