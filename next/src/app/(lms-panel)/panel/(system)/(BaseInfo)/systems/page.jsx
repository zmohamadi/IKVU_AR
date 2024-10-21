"use client";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { Grid,Frame,useData,FeatherIcon, Pic } from "@/Theme/Midone/Utils";

export default function List(){
    const { Lang} = useLang();
    const { laraAdmin ,nextAdmin ,mediaPath} = useConfig();
    const { destroy } = useData();
    const formUrl = "/systems"; 

    let info = {
        insertLink: nextAdmin+formUrl+"/new",
        url: laraAdmin+formUrl,
        columns: [
            {label: "", jsx:(item)=><Pic defaultImg={mediaPath+"/public/default/course.jpg"} width={70} height={70} src={mediaPath+"/systems/"+item?.photo} />},
            {label: "system", field: "title"},
            {label: "link", field: "domain"},
            {label: "ip", field: "ip"},
            {label: "api_key", field: "api_key"},
           // {label: "creator", jsx: (item)=><span>{item.creator?.firstname+" "+item.creator?.lastname}</span>},
           // {label: "editor", jsx: (item)=><span>{item.editor?.firstname+" "+item.editor?.lastname}</span>},
            {label: "",
                sort:false, 
                width:"110px", 
                jsx:(item)=><>
                    <div className='flex justify-center '>
                        <FeatherIcon name="Edit" url={nextAdmin+formUrl+"/"+item.id+"/edit"} tooltip={Lang('public.edit')} />
                        <FeatherIcon name="Eye" url={nextAdmin+formUrl+"/"+item.id} tooltip={Lang('public.view')} />
                        <FeatherIcon name="XOctagon" tooltip={Lang('public.delete')} color="darkred" onClick={()=>destroy(laraAdmin+formUrl+"/"+item.id)} />
                    </div>
                </>
            },
        ],
    }

    return(
        <Frame title={Lang(["public.systems"])}>
            <div className="intro-y col-span-12">
                <Grid {...info} key={"table key"} />
            </div>
        </Frame>
    );
}