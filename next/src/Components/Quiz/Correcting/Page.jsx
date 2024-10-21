"use client";
import { useLang } from "@/lib/lang";
import { Grid,Frame,FeatherIcon,Pic } from "@/Theme/Midone/Utils";
import { Button, ButtonContainer } from "@/Theme/Midone/Forms";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { useConfig } from "@/lib";

export function Page({laraPath,course,toolsId,nextPath=""}){
    const router = useRouter();
    const back = ()=>router.back();
    const { Lang } = useLang();
    const { mediaPath } = useConfig();

    let formUrl = nextPath+"/courses/"+course+"/tools/quiz/"+toolsId+"/correcting/";    
    let info = {
        // insertLink: nextAdmin+formUrl+"/new",
        url: laraPath+"/quiz-answers/"+toolsId,
        columns: [
            { label: "",jsx: (item) => (<Pic src={mediaPath+"/users/"+item?.photo} defaultImg={`${mediaPath}/public/default/avatar.png`} classImg="user-avatar rounded-full" />)},
            { label: "name", field: "firstname" },
            { label: "lname", field: "lastname" },
            { label: "email", field: "email" },
            { label: "start", jsx: (item)=><span>{item.attemps?.[0]?.start_at}</span>},
            { label: "end", jsx: (item)=><span>{item.attemps?.[0]?.end_at}</span>},
            { label: "score", jsx: (item)=><span>{item.attemps?.[0]?.total_score ? item.attemps?.[0]?.total_score+"/"+item.attemps?.[0]?.quiz_score:""}</span>},
            { label: "",
                sort:false,
                jsx:(item)=><>
                    <div className='flex justify-center '>
                      
                       <FeatherIcon name="CheckSquare" url={formUrl+item.id+"/attemp"} tooltip={Lang('public.correcting')} /> 
                       
                       
                    </div>
                </>
            },
        ],
    }

    return(
        <Frame title={Lang(["public.students"])}>
            <div className="intro-y col-span-12">
                <Grid {...info} key={"table key"} />
                <ButtonContainer>
                    <Link className="btn btn-success  w-20 mr-1 ml-1" href={nextPath+"/courses/"+course+"/tools"}>{Lang(["public.tools_link"])}</Link>
                    <Button label="back" onClick={back} />
                </ButtonContainer>
            </div>
        </Frame>
    );
}