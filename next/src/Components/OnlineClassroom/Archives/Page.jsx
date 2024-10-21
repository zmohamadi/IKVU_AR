"use client";
import { useLang } from "@/lib/lang";
import { Grid, Frame,useData} from "@/Theme/Midone/Utils";
import { FeatherIcon} from "@/Theme/Midone/Utils/FeatherIcon";

export function Page({toolsId,course,access,laraPath,nextPath=""}){
    const {Lang} = useLang();
    const formUrl = "/courses/"+course+"/tools/onlineClassroom/"+toolsId+"/archives" ; 
    const {destroy} = useData();
    let info = {
        insertLink: access? nextPath+formUrl+"/new": "",
        url: laraPath+"/onlineClassroom/"+toolsId+"/archives",
        columns: [
            {label: "link", field: "link"},
            {label: "size", field: "size"},
            {label: "download_count", field: "download_count"},
            {label: "",
                sort:false, 
                width:"110px", 
                jsx:(item)=><>
                    <div className='flex justify-center '>
                        <FeatherIcon name="Edit" access={access} url={nextPath+formUrl+"/"+item.id+"/edit"} tooltip={Lang('public.edit')} />
                        <FeatherIcon name="XOctagon" access={access} tooltip={Lang('public.delete')} color="darkred" onClick={()=>destroy(laraPath+"/onlineClassroom-files/"+item.id)} />
                    </div>
                </>
            },
        ],
    }

    return(
        <Frame title={Lang(["public.archives"])}>
            <div className="intro-y col-span-12">
                <Grid {...info} key={"table key"} />
            </div>
        </Frame>
    );
}