"use client";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useData } from "@/Theme/Midone/Utils/Data";
import { Grid, Frame, FeatherIcon, Pic } from "@/Theme/Midone/Utils";

export default function List({link="/users", displayRole=true, view=false, resume=false, title="users", menuPath="users"}){
    const {Lang, local} = useLang();
    const {mediaPath,laraAdmin,nextAdmin} = useConfig();
    const {destroy} = useData();
    // const formUrl = nextAdmin+link;
    const formUrl = menuPath == "users" ? nextAdmin+link : nextAdmin+"/"+menuPath+link;

    let info = {
        ...(menuPath != "/myCourses" ? { insertLink: formUrl + "/new" } : ""),
        // insertLink: formUrl + "/new",
        perPage:20,
        url: laraAdmin+link,
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
            ...(menuPath !== 'myCourses' ? [
                { label: "mobile", field: "mobile" },
                { label: "codemeli", field: "codemeli" },
                { label: "username", field: "username" },
                (displayRole)? {label: "role", sort:false, field: "role.title_"+local} : "",
                {label: "gender", sort:false, field: "gender.title_"+local},
                {label: "status", jsx: (item)=><span className={"text-"+item?.active_status?.color}>{item?.active_status?.["title_"+local]}</span>},
            ] : [
                { label: "email", field: "email" },
            ]),

            
            {label: "", sort:false, 
                jsx:(item)=><>
                    <div className='flex justify-center '>
                        <FeatherIcon displayIf={menuPath !== 'myCourses'} name="Edit" url={formUrl+"/"+item?.id+"/edit"} tooltip={Lang('public.edit')} />
                        {(menuPath !== 'myCourses'&&view)? <FeatherIcon name="Eye" url={formUrl+"/"+item?.id} tooltip={Lang('public.view')} />:""}
                        {(resume)? <FeatherIcon name="Feather" url={formUrl+"/"+item?.id+"/viewResume"} tooltip={Lang('public.resume')} />:""}
                        <FeatherIcon displayIf={menuPath !== 'myCourses' && !(item?.count_presented > 0)} name="XOctagon" tooltip={Lang('public.delete')} color="darkred" onClick={()=>destroy(laraAdmin+link+"/"+item?.id)} />
                    </div>
                </>
            }, 
        ],
    }

    return(
        <>
            <Frame title={Lang(["public."+title])}>
                <div className="intro-y col-span-12">
                    <Grid {...info} />
                </div>
            </Frame>
        </>
    );
}