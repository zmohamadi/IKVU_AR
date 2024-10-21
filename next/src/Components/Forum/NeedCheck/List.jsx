
"use client"

import { useLang } from "@/lib/lang";
import { useEffect, useState, Fragment } from "react";
import { Frame,FeatherIcon,useData,Tools } from "@/Theme/Midone/Utils";
import { Items } from "@/Components/Forum/Reply/Items";

export const List = ({ course,laraPath,nextPath,access }) => {
    const {Lang} = useLang();
    const nextUrl = "/courses/"+course+"/tools/forum/needCheck";
    const { getNeedles } = useData();
    const [item, setItem] = useState();
    const [status, setStatus] = useState();

    let text = "grid_loading"; let bg = "success";

    useEffect(() => {
        getNeedles(laraPath+"/forum/posts-need-check?course="+course, setItem);
    }, []);

    useEffect(() => {
        getNeedles(laraPath+"/posts-status", setStatus);    
    }, []);
    
    useEffect(() => {
        item?.data?.map(talar=>{
            talar.subjects = {};
            talar.unchecked_posts.map(post => {
                if(post.parent == null){ // در صورتی که پست یک موضوع باشد
                    talar.subjects[post.id] = post;
                }else{ // در صورتی که پست یک پیام باشد
                    // در صورتی که قبلا پرنت این پیام به آرایه اضافه نشده باشد
                    if(talar.subjects[post.parent_id] == null){
                        talar.subjects[post.parent_id] = post.parent;
                    }
                    // در صورتیکه هیچ پیامی به عنوان زیر مجموعه موضوع ثبت نشده باشد
                    if (talar.subjects[post.parent_id].messages == null){
                        talar.subjects[post.parent_id].messages = []
                    }
                    talar.subjects[post.parent_id].messages.push(post);
                }
            })
            return talar;
        });
    }, [item?.data]);

    let data = item?.data;
    if(data?.length == 0)
    {
        text = "no_data_registered"; bg = "warning";
    }

    return <Frame title={Lang(["public.forum"])}>
            <div className="col-span-12 md:col-span-12 xxl:col-span-12 mt-3 xxl:mt-6">
                {(data?.length == 0 || data == undefined)?
                    <span className={`alert alert-${bg}-soft show flex items-center mb-2 mt-5`}>{Lang("public."+text)+"....."}</span>
                :
                    <>
                        <div className="intro-x flex items-center h-10">
                            <FeatherIcon spanWrapperClass="text-left" name="ArrowDownCircle" onClick={() => Tools?.scrollPage(true,"")} />
                        </div>
                        {data?.map(item => {
                            return <Fragment key={"fr"+item.id}>
                                <div className="alert alert-outline-secondary alert-dismissible show flex items-center mb-2">
                                    <h3 className="text-2xl text-theme-17 font-medium leading-none">{item?.title}</h3>
                                </div>
                                {
                                    Object.values(Tools.getObj(item.subjects, {})).map(subject => {
                                        return <Fragment key={subject.id}>
                                            <div className="alert alert-secondary show mb-2">{subject?.title}</div>
                                            {
                                                subject.type_id == "0" && <Items item={subject} laraPath={laraPath} nextPath={nextPath} nextUrl={nextUrl} displayIcon={false} lock={item?.lock} status={status} backStatus={nextUrl+"?"+Math.random()} />
                                            }
                                            {
                                                subject?.messages?.map(message => <Items key={message.id} item={message} laraPath={laraPath} nextPath={nextPath} nextUrl={nextUrl} displayIcon={false} lock={item?.lock} status={status} backStatus={nextUrl+"?"+Math.random()} />)
                                            }
                                        </Fragment>
                                    })
                                }
                            </Fragment>
                        })}
                        <FeatherIcon name="ArrowUpCircle" onClick={() => Tools?.scrollPage(false,"")} />
                    </>
                }
            </div>
        </Frame>
}
