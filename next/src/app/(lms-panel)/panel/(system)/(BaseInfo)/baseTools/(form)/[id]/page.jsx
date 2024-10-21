"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useData,useFormRefs,Tools } from "@/Theme/Midone";

export default function View({params}){
    const { Lang,local } = useLang();
    const { mediaPath, laraAdmin} = useConfig();
    let component = useFormRefs();
    let {get} = useData();
    const formUrl = "/baseTools"; 
    let id = params.id , url = laraAdmin+formUrl+"/"+id;
    useEffect(() => {get(url, component, "info");}, []);
    let data = component?.state?.info;
    
    return(
        <>
            <div className="pos intro-y grid grid-cols-12 gap-5 mt-5">
                <div className="intro-y col-span-12 lg:col-span-4">
                    <div className="grid grid-cols-12 gap-5 pt-5 border-t border-theme-25">
                        <a href="#" data-toggle="modal" data-target="#add-item-modal" className="intro-y block col-span-12 sm:col-span-12 xxl:col-span-3">
                            <div className="box rounded-md p-3 relative zoom-in btn-cursor-default">
                                <div className="flex-none pos-image relative block">
                                    <div className="pos-image__preview image-fit">
                                        <img alt={data?.title} src={mediaPath+"/baseTools/"+data?.img} />
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <div className="col-span-12 lg:col-span-8">
                    <div className="intro-y col-span-8 md:col-span-8 xl:col-span-8 xl:col-start-1 xl:row-start-1 xxl:col-start-auto xxl:row-start-auto mt-3">
                        <div className="mt-5 intro-x">
                            <div className="box zoom-in btn-cursor-default">
                                <div className="tiny-slider" id="important-notes">
                                    <div className="p-5"> 
                                        <div className="text-base font-medium truncate">{Lang("public.tools")+" : "} {data?.title_fa}</div>
                                        <div className="text-gray-500 mt-3">{Lang("public.href")+" : "}</div>{data?.href}
                                        <div className="text-gray-500 mt-3">{Lang("public.order")+" : "}</div>{data?.order}
                                       
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
}