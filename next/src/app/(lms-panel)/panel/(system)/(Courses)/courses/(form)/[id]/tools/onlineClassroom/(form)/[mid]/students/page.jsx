"use client";
import { useConfig } from "@/lib/config";
import { useLang } from "@/lib/lang";
import { BackBtn, Button, ButtonContainer, CourseToolsBtn } from "@/Theme/Midone";
import { Grid, Frame, Tools, Pic} from "@/Theme/Midone/Utils";
import Link from "next/link";
import { useRouter } from "next/navigation";

export default function Page({params}){
    const toolsId = params.mid;
    const course = params.id;
    const {laraAdmin,mediaPath,nextAdmin} = useConfig();
    const {Lang} = useLang();
    const router = useRouter();
    const back = ()=>router.back();
    let url = laraAdmin+"/onlineClassroom/"+toolsId+"/students";

    let info = {
        url: url,
        perPage:50,
        columns: [
            {
                label: "",
                jsx: (item) => (
                    <Pic
                        src={mediaPath + "/users/" + item?.photo} 
                        defaultImg={`${mediaPath}/public/default/avatar.png`} 
                        classImg="user-avatar rounded-full" 
                        key={"img" + item?.photo} 
                    />
                ),
            },
            {
                label: "name", 
                jsx: (item) => <span>{item?.firstname + " " + item?.lastname}</span>,
            },
            { label: "mobile", field: "mobile" },
            { label: "codemeli", field: "codemeli" },
            { label: "username", field: "username" },
            // {label: "role",  jsx: (item)=><span>{item?.role?.title_fa}</span>},
            // {label: "attendance",  jsx: (item)=><span className="ltr" dir="ltr">{Tools.toJalaliDateString(item?.online_classrooms?.[0]?.pivot?.created_at)}</span>},
            {label: "presence",  jsx: (item)=><span className="ltr" dir="ltr">{item?.presence_online_classrooms?.[0]?.presence_time}</span>},
        ],
    }

    return(<>
            <Frame title={Lang(["public.attendees"])}>
                <div className="intro-y col-span-12">
                    <Grid {...info} key={url} />
                    <ButtonContainer>
                        <CourseToolsBtn href={`${nextAdmin}/courses/${course}/tools`} />
                        <BackBtn onClick={back} />
                        
                    </ButtonContainer>
                </div>
            </Frame>
        </>
    );
}