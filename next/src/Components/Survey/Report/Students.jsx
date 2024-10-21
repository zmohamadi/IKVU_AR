"use client";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { Grid, Frame } from "@/Theme/Midone/Utils";

export function Students({ id, displayRole=false }){
    const {Lang, local} = useLang();
    const { mediaPath,laraAdmin } = useConfig();
    const formUrl = "/survey/get-users/"+id;

    let info = {
        url: laraAdmin+formUrl,
        columns: [
            {label: "", jsx:(item)=><img className="user-avatar rounded-full" src={mediaPath+"/users/"+item?.user?.photo} alt="user" />},
            {label: "gender", sort:false, field: "user.gender.title_"+local},
            {label: "name", field: "user.firstname"},
            {label: "lname", field: "user.lastname"},
            (displayRole)? {label: "role", sort:false, field: "user.role.title_"+local} : "",
            {label: "mobile", field: "user.mobile"},
            {label: "email", field: "user.email"},
        ],
    }

    return(
        <>
            <Frame title={Lang(["public.users"])}>
                <div className="intro-y col-span-12">
                    <Grid {...info} activeSearch={false} />
                </div>
            </Frame>
        </>
    );
}