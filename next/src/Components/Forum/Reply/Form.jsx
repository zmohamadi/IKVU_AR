"use client";
import { useState } from "react";
import { useLang } from "@/lib/lang";
import Link from "next/link";
import { Button,Frame } from "@/Theme/Midone/Forms";
import { Form } from "@/Components/Forum/Post/Form";
import { List } from '@/Components/Forum/Reply/List';

export function FormReply({ course,forum,post,laraPath,nextPath }){
    const {Lang} = useLang();
    const [formAction, setFormAction] = useState("");
    const [subPost, setSubPost] = useState();
    const [lock, setLock] = useState();
    const toolsUrl = nextPath+"/courses/"+course+"/tools";
    const classNameBtn = "btn bg-white bg-opacity-20 dark:bg-dark-1 hover:bg-opacity-30 w-20 mr-1 ml-1";

    const changeBox = ()=>setFormAction("new");
    
    return(
        <>
            <Frame title={Lang(["public.dialog"])}>
                {(formAction == "")?
                    <div className="col-span-12 xl:col-span-12 xxl:col-span-12 z-10 mt-6 -mb-6 intro-y">
                        <div className="alert alert-dismissible show box bg-theme-14 text-white flex items-center mb-6" role="alert">
                        {(lock)?
                            <span className="ml-5">{Lang("public.because_forum_locked_not_post")}</span>
                        :
                            <span className="ml-5">{Lang("public.please_click_post_in_forum")}
                                {/* <a href="https://www.rtl-theme.com/user-profile/afaridteam/" className="underline ml-1" target="blank">راست چین</a>.  */}
                                <Button className="btn border-transparent bg-white bg-opacity-20 dark:bg-dark-1 hover:bg-opacity-30 py-2 px-3 -my-3 ml-2 mr-5 p-3"
                                    label="btn_title_reply" onClick={changeBox} />
                            </span>
                        }
                        <span className="mr-auto">
                            <Link className={classNameBtn} href={toolsUrl}>{Lang(["public.tools_link"])}</Link>
                            <Link className={classNameBtn} href={toolsUrl+`/forum/${forum}/posts`}>{Lang(["public.back"])}</Link>
                        </span>
                        </div>
                    </div>
                :
                    <Form post={post} forum={forum} course={course} laraPath={laraPath} formAction={formAction} funcFormAction={setFormAction} subPost={subPost} />
                }
            </Frame>
            <List post={post} forum={forum} course={course} laraPath={laraPath} formAction={setFormAction} subPost={setSubPost} statusLock={setLock} />
        </>
    );
}
