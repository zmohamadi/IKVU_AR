"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useData,useFormRefs, Frame, Box, ButtonContainer, Button } from "@/Theme/Midone";
import { useRouter } from 'next/navigation';

export default function View({params}){
    const {laraAdmin } = useConfig();
    const {Lang} = useLang();
    let component = useFormRefs();
    let {get} = useData();
    const formUrl = "/yearSemesters"; 
    let id = params.id , url = laraAdmin+formUrl+"/"+id;
    useEffect(() => {get(url, component, "info");}, []);
    let data = component?.state?.info;
    const router = useRouter();
    const back = () => {
        router.back();
    };

    return(
        <> <Frame>
                <Box> 
                    <div className="tiny-slider py-5 col-span-12">
                        <div className="px-5 text-center sm:text-right">
                            <div className="font-medium text-lg">{Lang(["public.yearSemesters"])} : {data?.year+"-"+data?.semester}</div>
                            <div className="mt-5"> {Lang(["public.start","public.term"])+" : "+(data?.start_date)}</div>
                            <div className="mt-3"> {Lang(["public.end","public.term"])+" : "+(data?.end_date)}</div>
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