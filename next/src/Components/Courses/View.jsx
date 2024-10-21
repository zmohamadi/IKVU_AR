"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useUtility } from "@/lib/utility";
import { Button, ButtonContainer, Frame, Pic, useData, useFormRefs } from "@/Theme/Midone";
import { usePathname, useRouter } from 'next/navigation';
import Link from "next/link";

export function View({laraPath,id,isAdmin}){
    const { getRelation } = useUtility();
    const router = useRouter();
    const back = ()=>router.back();
    const {mediaPath,nextAdmin } = useConfig();
    const {Lang,local} = useLang();
    const formUrl = "/courses" ; 
    const title = "course" ; 
    let url = laraPath+formUrl+"/"+id;
    let component = useFormRefs();
    let {get} = useData();
    useEffect(() => {get(url, component, "info");}, []);
    let data = component?.state?.info;
    const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'courses';

    return(<>
        <Frame>
            <div className="intro-y col-span-12 lg:col-span-9">
                <div className="box p-5 intro-y news">
                    <div className="intro-y">
                        <div className="news__preview image-fit" style={{ height: '500px',width:"350px" ,textAlign:"center",margin:"auto" }}>
                            <Pic src={`${mediaPath}/courses/${data?.thumbnail}`} defaultImg={`${mediaPath}/public/default/course.jpg`} classImg="rounded-md" key={"img"+data?.thumbnail}/>
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
                    <strong>{Lang('public.lesson_group')} : </strong> {data?.category?.["title_"+local]}
                </div>
                <div className="intro-y mb-2">
                    <strong>{Lang('public.system')} : </strong> {data?.system?.title}
                </div>
                {isAdmin&&
                    <>
                        <div className="intro-y mb-2">
                            <strong>{Lang('public.creator')} : </strong> {getRelation(data?.creator)}
                        </div>
                        <div className="intro-y mb-2">
                            <strong>{Lang('public.editor')} : </strong> {getRelation(data?.editor)}
                        </div>
                    </>
                }
                {
                    menuPath!='myCourses' ?<>
                    <div className="intro-y mb-2 ">
                        <Link className="text-center btn btn-outline-primary" href={`${nextAdmin}/courses/${data?.code}/present`}>
                            {Lang("public.click_here_for_classes")}
                        </Link> 
                    </div>
                    <div className="intro-y mb-2 ">
                        <Link className="text-center btn btn-outline-primary" href={`${nextAdmin}/courses/${data?.code}/tools`}>
                            {Lang("public.click_here_tools")}
                        </Link> 
                    </div>
                    </> :""
                }
                  
            </div>
        </Frame>
        <ButtonContainer>
            <Button label="back" onClick={back} />
        </ButtonContainer>
    </>
);
}