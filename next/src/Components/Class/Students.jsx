"use client";
import { useConfig } from "@/lib/config";
import { useLang } from "@/lib/lang";
import { Button, ButtonContainer } from "@/Theme/Midone";
import { Grid, Frame,useData, Pic} from "@/Theme/Midone/Utils";
import { FeatherIcon} from "@/Theme/Midone/Utils/FeatherIcon";
import { useRouter } from "next/navigation";

export function Students({params}){
    const id = params?.toolsId;
    let course = params?.id;
    const {laraAdmin, nextAdmin,mediaPath} = useConfig();
    const {Lang, local} = useLang();
    const formUrl = `courses/${course}/present/${id}/students`; 
    const {destroy} = useData();
    const router = useRouter();
    const back = ()=>router.back();

    let url = laraAdmin+"/classes/"+id+"/students";
    // let url = `${laraAdmin}/courses/${course}/present/${id}/students`;
    let access=true;

    let info = {
        insertLink: access? nextAdmin+"/"+formUrl+"/new": "",
        insertLabel:"membership_student",
        url: url,
        columns: [
            { label: "", jsx:(item)=><Pic classImg="user-avatar rounded-full" src={`${mediaPath}/users/${item?.photo}`} defaultImg={`${mediaPath}/public/default/user.png`}  />},
            {label: "name", field: "firstname"},
            {label: "lname", field: "lastname"},
            {label: "mobile", field: "mobile"},
            {label: "email", jsx:(item)=><span dir="ltr">{item.email}</span>},
            // {label: "role", field: "role.title_"+local},
            {label: "",
                sort:false, 
                width:"110px", 
                jsx:(item)=><>
                    <div className='flex justify-center '>
                        <FeatherIcon name="Eye" url={nextAdmin+"/students/"+item.id} tooltip={Lang('public.view')} />
                        <FeatherIcon name="XOctagon" access={access} tooltip={Lang('public.delete_membership')} color="darkred" onClick={()=>destroy(`${laraAdmin}/classes/${id}/students/delete/${item.id}`)} />
                    </div>
                </>
            },
        ],
    }

    return(<>
            <Frame title={Lang(["public.students"])}>
                <div className="intro-y col-span-12">
                    <Grid {...info} key={url} />
                    <ButtonContainer>
                        <Button label="back" onClick={back} />
                    </ButtonContainer>
                </div>
            </Frame>
        </>
    );
}