"use client";
import { useLang } from "@/lib/lang";
import { BackBtn, Button, ButtonContainer, CourseToolsBtn } from "@/Theme/Midone/Forms";
import { Grid, Frame,useData} from "@/Theme/Midone/Utils";
import { FeatherIcon} from "@/Theme/Midone/Utils/FeatherIcon";
import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { useState } from "react";

export function Page({laraPath, nextPath ,course}){

    const router = useRouter();
    const back = ()=>router.back();
    const {Lang,local} = useLang();
    const {destroy} = useData();
    const [access, setAccess] = useState(false)
    const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'courses';
    let formUrl = "/"+menuPath+"/"+course+"/tools/learnpath";

    let info = {
        // insertLink: access? nextPath+formUrl+"/new": "",
        ...(menuPath === "courses" || access ? { insertLink: nextPath + formUrl + "/new" } : {}),
        perPage:20,
        url: laraPath+"/content-list/"+course,
        columns: [
            {label: "title", minWidth:"250px", jsx: (item)=><span>{<Link href={nextPath+formUrl + "/" + item.id}>{item.title}</Link> }</span>},
            {label: "duration", field: "duration"},
            access?{label: "view", width:"70px",  field: "view_count"}:"",
            access?{label: "status", width:"60px",  jsx: (item)=><span className={item.active_status?.color}>{item.active_status?.["title_"+local]}</span>}:'',
            {label: "",
                sort:false, 
                width:"110px", 
                jsx:(item)=><>
                    <div className='flex justify-center '>
                        <FeatherIcon name="Users" access={access} url={nextPath+formUrl+"/"+item.id+"/visitors"} tooltip={Lang('public.visitors')} />
                        <FeatherIcon name="Edit" access={access} url={nextPath+formUrl+"/"+item.id+"/edit"} tooltip={Lang('public.edit')} />
                        <FeatherIcon name="Eye" url={nextPath+formUrl+"/"+item.id} tooltip={Lang('public.view')} />
                        <FeatherIcon name="XOctagon" access={access} tooltip={Lang('public.delete')} color="darkred" onClick={()=>destroy(laraPath+"/contents/"+item.id)} />
                    </div>
                </>
            },
        ],
        callback: (data)=>{ setAccess(data?.userAccess) }
    }

    return(
        <Frame title={Lang(["public.contents"])}>
            <div className="intro-y col-span-12">
                <Grid {...info} key={"table key"} />
                <ButtonContainer>
                    <CourseToolsBtn href={`${nextPath}/${menuPath}/${course}/tools`} />
                    <BackBtn onClick={back} />
                </ButtonContainer>
            </div>
        </Frame>
        
    );
}