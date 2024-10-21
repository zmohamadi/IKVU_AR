"use client";
import { useCallback, useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import {  Button, ButtonContainer, Frame, Pic, useData, useFormRefs } from "@/Theme/Midone";
import { usePathname, useRouter } from 'next/navigation';
import Link from "next/link";
import { useUtility } from "@/lib";

export function View({id,isAdmin}){
    const { getRelation } = useUtility();
    const router = useRouter();
    const back = ()=>router.back();
    const {mediaPath,laraAdmin,nextAdmin } = useConfig();
    const {Lang,local} = useLang();
    const formUrl = "/onlineClassrooms" ; 
    const title = "onlineClassroom" ;
    const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'courses';
    let url = laraAdmin+formUrl+"/"+id;
    let component = useFormRefs();
    let {get} = useData();
    useEffect(() => {get(url, component, "info");}, []);
    
    let onlineClass = component?.state?.info;
    let data = component?.state?.info?.course;
    let courseClass = component?.state?.info;
    const handleClick = useCallback((e, item) => {
        e.preventDefault();
        if (document.getElementById('a-loading')) return;
        e.target.innerHTML = loading + e.target.innerHTML;
        // console.log("item is ", item);
        get(laraAdmin + "/bbb/" + item?.id, "", "", (data) => {
            // console.log("callback!!");
            let a = document.createElement("a");
            const id = "a-" + Math.random();
            a.href = data.url;
            a.target = "_blank";
            a.id = id;
            document.body.appendChild(a);
            Element.prototype.remove = function () {
                this.parentElement.removeChild(this);
            };
            document.getElementById('a-loading').remove();
            document.getElementById(id).click();
        });
    }, []);
    return(<>
            <Frame>
                <div className="intro-y col-span-12 lg:col-span-9">
                    <div className="box p-5 intro-y news">
                        
                    <h2 className="intro-y font-medium text-xl sm:text-2xl">
                        <strong>{Lang('public.title')} : </strong> {onlineClass?.title}  
                    </h2>
                    <div className="intro-y mb-2">
                        <strong>{Lang('public.date')} : </strong>  {onlineClass?.date}
                    </div>
                    <div className="intro-y mb-2">
                        <strong>{Lang('public.start_hour')} : </strong>  {onlineClass?.start_hour}
                    </div>
                    <div className="intro-y mb-2">
                        <strong>{Lang('public.duration')}: </strong>  {onlineClass?.duration} {Lang('public.minute')}
                    </div>
                    <div className="intro-y mb-2">
                        <strong>{Lang('public.class')} : </strong>  {onlineClass?.is_cancel!=null ? <span className={`btn  btn-danger-soft`}>کنسل</span>  :<>
                                {onlineClass?.checkDateTime?.status == "before_time" &&
                                <span className="btn  btn-warning-soft">{Lang('public.before_time_class')}</span>}
                                {onlineClass?.checkDateTime?.status == "after_time" &&
                                <span className={`btn btn-rounded btn-${onlineClass?.userInClass === "غائب" ? "danger" : "success"}-soft`}>
                                     {onlineClass?.userInClass === "غائب" ? onlineClass?.userInClass : "زمان ورود: "+onlineClass?.userInClass?.presence_time}

                                </span>}
                                {onlineClass?.checkDateTime?.status == "on_time" &&
                                    <a
                                        className="btn btn-success-soft"
                                        href="#"
                                        onClick={(e) => handleClick(e, onlineClass)}
                                    >
                                        {Lang('public.login_to_class')}
                                    </a>
                                }</>
                            }
                    </div>
                    
                    
                    </div>
                </div>
                <div className="col-span-12 box p-5 lg:col-span-3">
                    <div className="intro-y mb-2 text-center">
                        <Pic key={"img"+data?.thumbnail} style={{margin:"auto"}} src={`${mediaPath}/courses/${data?.thumbnail}`} defaultImg={`${mediaPath}/public/default/course.jpg`} />
                    </div>
                    <div className="intro-y mb-2">
                        <strong>{Lang('public.title')} {Lang('public.course')} : </strong> {data?.title} -  {data?.code}
                    </div>
                    
                    <div className="intro-y mb-2">
                        <strong>{Lang('public.group')} : </strong> {courseClass?.group?.substring(0, 4)} - {Lang('public.semester')} {courseClass?.group?.substring(4,5)}
                    </div>
                    
                   
                    
                    {isAdmin&&
                        <>
                        <div className="intro-y mb-2">
                            <strong>{Lang('public.creator')} : </strong> {getRelation(courseClass?.creator)}
                        </div>
                        <div className="intro-y mb-2">
                            <strong>{Lang('public.editor')} : </strong> {getRelation(courseClass?.editor)}
                        </div>
                          
                        </>
                     }
                    
                </div>
            </Frame>
            <ButtonContainer>
                <Link className="btn btn-success  w-20 mr-1 ml-1" href={`${nextAdmin}/courses/${data?.code}/tools`}>{Lang(["public.tools_link"])}</Link>
                <Button label="back" onClick={back} />
            </ButtonContainer>
        </>
    );
}
const loading = '<svg id="a-loading" style="display: inline-block; margin: 0 6px" width="25" viewBox="0 0 120 30" xmlns="http://www.w3.org/2000/svg" fill="rgb(45, 55, 72)"><circle cx="15" cy="15" r="15"><animate attributeName="r" from="15" to="15" begin="0s" dur="0.8s" values="15;9;15" calcMode="linear" repeatCount="indefinite"></animate><animate attributeName="fill-opacity" from="1" to="1" begin="0s" dur="0.8s" values="1;.5;1" calcMode="linear" repeatCount="indefinite"></animate></circle><circle cx="60" cy="15" r="9" fill-opacity="0.3"><animate attributeName="r" from="9" to="9" begin="0s" dur="0.8s" values="9;15;9" calcMode="linear" repeatCount="indefinite"></animate><animate attributeName="fill-opacity" from="0.5" to="0.5" begin="0s" dur="0.8s" values=".5;1;.5" calcMode="linear" repeatCount="indefinite"></animate></circle><circle cx="105" cy="15" r="15"><animate attributeName="r" from="15" to="15" begin="0s" dur="0.8s" values="15;9;15" calcMode="linear" repeatCount="indefinite"></animate><animate attributeName="fill-opacity" from="1" to="1" begin="0s" dur="0.8s" values="1;.5;1" calcMode="linear" repeatCount="indefinite"></animate></circle></svg>';
