"use client";

import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { Grid, Frame, FeatherIcon, useData } from "@/Theme/Midone/Utils";

export default function List(){
    const {Lang} = useLang();
    const {laraSAdmin, nextSAdmin} = useConfig();
    const {destroy} = useData();

    let info = {
        insertLink: nextSAdmin+"/systems/new",
        url: laraSAdmin+"/systems",
        columns: [
            // {label: "", jsx:(item)=><image src={host+"/media/public/"+item.image} width={100} height={100} alt="Picture of the author" />},
            {label: "name", field: "name"},
            {label: "title", field: "title_fa"},
            {label: "comments", field: "comments"},
            {label: "",
                sort:false, 
                width:"110px",
                jsx:(item)=><>
                        <div className='flex justify-center '>
                            <FeatherIcon name="Edit" url={nextSAdmin+"/systems/"+item.id+"/edit"} tooltip={Lang('public.edit')} />
                            <FeatherIcon name="XOctagon" tooltip={Lang('public.delete')} color="darkred" onClick={()=>destroy(laraSAdmin+"/systems/"+item.id)} />
                        </div>
                    </>
            },
        ],
    }

    return(
        <Frame title={Lang(["public.subjects"])}>
            <div className="intro-y col-span-12">
                <Grid {...info} key={"table key"} />
            </div>
        </Frame>
    );
}