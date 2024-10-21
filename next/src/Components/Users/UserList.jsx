"use client";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { Grid, Frame} from "@/Theme/Midone/Utils";
import { Button, ButtonContainer } from "@/Theme/Midone/Forms";
import { useRouter } from "next/navigation";

export function UserList({access  , url}){
    const router = useRouter();
    const back = ()=>router.back();
    const {Lang} = useLang();
    const {mediaPath } = useConfig();    
    let info = {
        url: url,
        columns: [
            {label: "", jsx:(item)=><img className="user-avatar rounded-full" src={mediaPath+"/users/"+item?.photo} alt="user" />},
            {label: "name", field: "firstname"},
            {label: "lname", field: "lastname"},
            {label: "mobile", field: "mobile"},
            {label: "email", field: "email"},
        ],
    }

    return(
        <Frame title={Lang(["public.users"])}>
            <div className="intro-y col-span-12">
                <Grid {...info} key={"table key"} />
                <ButtonContainer>
                    <Button label="back" onClick={back} />
                </ButtonContainer>
            </div>
        </Frame>
    );
}