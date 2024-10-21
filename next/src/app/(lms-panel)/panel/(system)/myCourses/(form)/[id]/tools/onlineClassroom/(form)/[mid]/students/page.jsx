"use client";
import { useConfig } from "@/lib/config";
import { useLang } from "@/lib/lang";
import { Button, ButtonContainer } from "@/Theme/Midone";
import { Grid, Frame, Tools} from "@/Theme/Midone/Utils";
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
        columns: [
            {label: "", jsx:(item)=><img className="user-avatar rounded-full" src={mediaPath+"/users/"+item?.photo} alt="user" />},
            {label: "name", field: "firstname"},
            {label: "lname", field: "lastname"},
            {label: "mobile", field: "mobile"},
            {label: "email", field: "email"},
            // {label: "role",  jsx: (item)=><span>{item?.role?.title_fa}</span>},
            {label: "attendance",  jsx: (item)=><span className="ltr" dir="ltr">{Tools.toJalaliDateString(item?.online_classrooms?.[0]?.pivot?.created_at)}</span>},
        ],
    }

    return(<>
            <Frame title={Lang(["public.attendees"])}>
                <div className="intro-y col-span-12">
                    <Grid {...info} key={url} />
                    <ButtonContainer>
                        <Link className="btn btn-primary w-20 mr-1 ml-1" href={nextAdmin+"/courses/"+course+"/tools"}>{Lang(["public.tools_link"])}</Link>
                        <Button label="back" onClick={back} />
                    </ButtonContainer>
                </div>
            </Frame>
        </>
    );
}