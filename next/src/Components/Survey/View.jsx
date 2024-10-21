"use client";

import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useData,useFormRefs,Frame } from "@/Theme/Midone/Utils";
import { Box } from "@/Theme/Midone/Base";
import { CourseInfo,SurveyInfo,Description,SurveyComplete } from '@/Components/Survey/ReplyDetails';
import { ShowReply } from '@/Components/Survey/ReplyDetails/ShowReply';

export function View({ id,course,laraPath,nextPath="",dispalyResult=false,dispalyComplete=false }){
    const {Lang} = useLang();
    let component = useFormRefs();
    let {get} = useData();
    let url = laraPath+"/survey/reply-info/"+id;
    useEffect(() => {
        get(url, component, "info");
    }, []);

    let data = component?.state?.info;
    // let result = data?.result;
    let item = data?.item;
    let dataCourse = data?.course;
    let questions = data?.questions;
    let answer = [];
    let complete = "";
    let description = "";
    let classForm = "lg:col-span-12 xxl:col-span-12";
    if(item?.description)
    {
        description = <Description data={item?.description} />;
        classForm = "lg:col-span-9 xxl:col-span-9";
    }
    if(dispalyComplete)
    {
        complete = <SurveyComplete data={item} isPersonnel={data?.ISPERSONNEL} />;
    }

    return(
        <Frame title={Lang(["public.survey"])}>
            <div className="col-span-12 xxl:col-span-9">
                {(item == undefined || dataCourse == undefined)?
                    <span className="alert alert-secondary-soft show flex items-center mb-2 mt-5">{Lang("public.loading")+"....."}</span>
                :
                    <>
                        <div className="grid grid-cols-12 gap-6">
                            <SurveyInfo data={item} />
                            <CourseInfo data={dataCourse} />
                        </div>
                        <div className="grid grid-cols-12 gap-6">
                            <div className={"col-span-12 "+classForm}>
                                <Box cols="grid-cols-1" >
                                    <ShowReply questions={questions} answer={answer} dispalyResult={dispalyResult} responseCount={item?.count_response} />
                                </Box>
                            </div>
                            <div className="col-span-12 lg:col-span-3 xxl:col-span-3 flex lg:block flex-col-revers">
                                {complete}
                                {description}
                            </div>
                        </div>
                    </>
                }
            </div>
        </Frame>
    );
}