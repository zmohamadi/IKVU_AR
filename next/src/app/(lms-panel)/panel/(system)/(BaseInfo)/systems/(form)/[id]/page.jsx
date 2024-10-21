"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useData,useFormRefs, Frame, Box, ButtonContainer, Button, Pic } from "@/Theme/Midone";
import { useRouter } from 'next/navigation';

export default function View({params}){
    const {Lang} = useLang();
    const { mediaPath, laraAdmin} = useConfig();
    let component = useFormRefs();
    let {get} = useData();
    const formUrl = "/systems"; 
    let id = params.id , url = laraAdmin+formUrl+"/"+id;
    useEffect(() => {get(url, component, "info");}, []);
    let data = component?.state?.info;
    const router = useRouter();
    const back = () => {
        router.back();
    };
    return(
        <>
        <Frame>
            <Box>
                <div className="intro-y col-span-12 lg:col-span-4">
                        <div className="grid grid-cols-12 gap-5 pt-5  border-theme-25">
                            <div className="box rounded-md p-3 relative  btn-cursor-default">
                                    <div className="flex-none pos-image relative block">
                                        <div className="pos-image__preview image-fit">
                                        <Pic defaultImg={mediaPath+"/public/default/course.jpg"} width={70} height={70} src={mediaPath+"/systems/"+data?.photo} />
                                        </div>
                                    </div>
                                </div>
                        </div>
                    </div>
                    <div className="col-span-12 lg:col-span-8">
                        <div className="intro-y col-span-8 md:col-span-8 xl:col-span-8 xl:col-start-1 xl:row-start-1 xxl:col-start-auto xxl:row-start-auto mt-3">
                            <div className="mt-5 intro-x">
                                <div className="btn-cursor-default">
                                    <div className="tiny-slider" id="important-notes">
                                        <div className="p-5"> 
                                            <div className="text-base font-medium truncate">{data?.title}</div>
                                            <div className="text-gray-500 mt-3">{Lang("public.api")+" : "}</div>{data?.api_key}
                                            <div className="text-gray-500 mt-3">{Lang("public.ip")+" : "}</div>{data?.ip}
                                            <div className="text-gray-500 mt-3">{Lang("public.domain")+" : "}</div>{data?.domain}
                                            <div className="text-gray-600 mt-3">{Lang("public.description")+" : "}</div>
                                            <span dangerouslySetInnerHTML={{ __html: data?.description }}></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
            </Box>

        </Frame>
        <ButtonContainer>
                <Button label="back" onClick={back} />
            </ButtonContainer>
        </>
    );
}