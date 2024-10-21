"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import {  Button, ButtonContainer, Frame, Pic, useData, useFormRefs } from "@/Theme/Midone";
import { useRouter } from 'next/navigation';
import Link from "next/link";
import { useUtility } from "@/lib";

export function View({id,isAdmin}){
    const { getRelation } = useUtility();
    const router = useRouter();
    const back = ()=>router.back();
    const {mediaPath,laraAdmin,nextAdmin } = useConfig();
    const {Lang,local} = useLang();
    const formUrl = "/classes" ; 
    const title = "class" ; 
    let url = laraAdmin+formUrl+"/"+id;
    let component = useFormRefs();
    let {get} = useData();
    useEffect(() => {get(url, component, "info");}, []);
    
    let data = component?.state?.info?.course;
    let courseClass = component?.state?.info;
    return(<>
            <Frame>
                <div className="intro-y col-span-12 lg:col-span-9">
                    <div className="box p-5 intro-y news">
                        <div className="intro-y">
                            <div className="news__preview image-fit" style={{ height: '500px',width:"350px" ,textAlign:"center",margin:"auto" }}>
                                <Pic src={`${mediaPath}/courses/${data?.thumbnail}`} classImg="rounded-md" defaultImg={`${mediaPath}/public/default/course.jpg`} />

                                
                            </div>
                        </div>
                        
                        <h2 className="intro-y font-medium text-xl sm:text-2xl mt-2">
                            {Lang('public.description')} : 
                        </h2>
                        <div dangerouslySetInnerHTML={{ __html: data?.description }} className="intro-y text-justify leading-relaxed">
                        </div>
                    
                    </div>
                </div>
                <div className="col-span-12 box p-5 lg:col-span-3">
                    
                    <div className="intro-y mb-2">
                        <strong>{Lang('public.title')} {Lang('public.course')} : </strong> {data?.title}
                    </div>
                    <div className="intro-y mb-2">
                        <strong>{Lang('public.code')} {Lang('public.course')} : </strong> {data?.code}
                    </div>
                    <div className="intro-y mb-2">
                        <strong>{Lang('public.group')} : </strong> {courseClass?.group?.substring(0, 4)} - {Lang('public.semester')} {courseClass?.group?.substring(4,5)}
                    </div>
                    <div className="intro-y mb-2">
                        <strong>{Lang('public.teacher')} : </strong> {courseClass?.teacher?.firstname} {courseClass?.teacher?.lastname}
                    </div>
                    <div className="intro-y mb-2">
                        <strong>{Lang('public.lesson_group')} : </strong> {data?.category?.["title_"+local]}
                    </div>
                    <div className="intro-y mb-2">
                        <strong>{Lang('public.system')} : </strong> {data?.system?.title}
                    </div>
                    <div className="intro-y mb-2">
                        <strong>{Lang('public.count')} {Lang('public.student')} : </strong> {courseClass?.count_students}
                    </div>
                    <div className="intro-y mb-2">
                        <strong>{Lang('public.start_date')} : </strong> <span dir="ltr">{courseClass?.start_date}</span>
                    </div>
                    <div className="intro-y mb-2">
                        <strong>{Lang('public.end_date')} : </strong> <span dir="ltr">{courseClass?.end_date}</span>
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
                    <div className="intro-y mb-2 ">
                        <Link className="text-center btn btn-outline-primary" href={`${nextAdmin}/courses/${data?.code}/tools`}>
                            {Lang("public.click_here_tools")}
                        </Link> 
                    </div>
                </div>
            </Frame>
            <ButtonContainer>
                <Button label="back" onClick={back} />
            </ButtonContainer>
        </>
    );
}