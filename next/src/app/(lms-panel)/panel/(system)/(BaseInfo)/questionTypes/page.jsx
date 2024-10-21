"use client";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { Grid,Frame,FeatherIcon } from "@/Theme/Midone/Utils";

export default function List(){
    const { Lang,local } = useLang();
    const { laraAdmin ,nextAdmin } = useConfig();
    const formUrl = "/questionTypes"; 

    let info = {
        url: laraAdmin+formUrl,
        activeSearch:false,
        columns: [
            {label: "title", field: "title_"+local},
            {label: "",
                sort:false, 
                jsx:(item)=><>
                    <div className='flex justify-center '>
                        <FeatherIcon name="Edit" url={nextAdmin+formUrl+"/"+item.id+"/edit"} tooltip={Lang('public.edit_title')} />
                    </div>
                </>
            },
        ],
    }

    return(
        <Frame title={Lang(["public.questionTypes"])}>
            <div className="intro-y col-span-12">
                <Grid {...info} key={"table key"} />
            </div>
        </Frame>
    );
}