"use client";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useData } from "@/Theme/Midone/Utils/Data";
import { Grid, Frame, FeatherIcon} from "@/Theme/Midone/Utils";

export default function List(){
    const {Lang, local} = useLang();
    const {laraAdmin,nextAdmin} = useConfig();
    const {destroy} = useData();
    const formUrl = nextAdmin+"/roles";
    const laraUrl = laraAdmin+"/roles";

    let info = {
        insertLink: formUrl+"/new",
        url: laraUrl,
        columns: [
            {label: "title", field: "title_fa"},
            // {label: "title", field: "title_en"},
            {label: "status", jsx: (item)=><span className={"text-"+item?.active_status?.color}>{item?.active_status?.["title_"+local]}</span>},
            {label: "", sort:false, 
                jsx:(item)=><>
                    <div className='flex justify-center '>
                        <FeatherIcon name="Edit" url={formUrl+"/"+item?.id+"/edit"} tooltip={Lang('public.edit')} />
                        {/* <FeatherIcon name="Settings" url={formUrl+"/"+item?.id+"/access"} tooltip={Lang('public.access')} /> */}
                        {/* <FeatherIcon name="XOctagon" tooltip={Lang('public.delete')} color="darkred" onClick={()=>destroy(laraUrl+"/"+item?.id)} /> */}
                    </div>
                </>
            }, 
        ],
    }

    return(
        <>
            <Frame title={Lang(["public.users"])}>
                <div className="intro-y col-span-12">
                    <Grid {...info} />
                </div>
            </Frame>
        </>
    );
}