"use client";

import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useData,useFormRefs,Frame } from "@/Theme/Midone/Utils";
import { Box } from "@/Theme/Midone/Base";
import { CourseInfo,SurveyInfo,Description } from '@/Components/Survey/ReplyDetails';
import { FormReply } from '@/Components/Survey/ReplyDetails/FormReply';
import { ShowReply } from '@/Components/Survey/ReplyDetails/ShowReply';
import { AlertReply } from '@/Components/Survey/ReplyDetails/AlertReply';

export function Reply({ id,course,laraPath,nextPath="" }){
    const {Lang} = useLang();
    let component = useFormRefs();
    let {get} = useData();
    let url = laraPath+"/survey/reply-info/"+id;
    useEffect(() => {
        get(url, component, "info");
    }, []);

    let data = component?.state?.info;
    let result = data?.result;
    let item = data?.item;
    let dataCourse = data?.course;
    let questions = data?.questions;
    let attemp = data?.attemp;
    let answer = data?.answer;
    let description = "";
    let classForm = "lg:col-span-12 xxl:col-span-12";
    if(item?.description)
    {
        description = <Description data={item?.description} />;
        classForm = "lg:col-span-9 xxl:col-span-9";
    }

    return(
        <Frame title={Lang(["public.survey"])}>
            <div className="col-span-12 xxl:col-span-9">
                {(item == undefined || dataCourse == undefined)?
                    <span className="alert alert-success-soft show flex items-center mb-2 mt-5">{Lang("public.loading")+"....."}</span>
                :
                    <>
                        <div className="grid grid-cols-12 gap-6">
                            <SurveyInfo data={item} />
                            <CourseInfo data={dataCourse} />
                        </div>
                        <div className="grid grid-cols-12 gap-6">
                            <div className={"col-span-12 "+classForm}>
                                <Box cols="grid-cols-1" >
                                    {/* {(answer instanceof Array)? */}
                                    {(attemp == null)?
                                        (result?.flag)?
                                            <FormReply id={id} course={course} laraPath={laraPath} nextPath={nextPath} questions={questions} />
                                        :
                                            <AlertReply data={item} result={result} id={id} course={course} laraPath={laraPath} nextPath={nextPath} questions={questions} />
                                    :
                                        <ShowReply questions={questions} answer={answer} />
                                    }
                                </Box>
                            </div>
                            <div className="col-span-12 lg:col-span-3 xxl:col-span-3 flex lg:block flex-col-revers">
                                {description}
                            </div>
                        </div>
                    </>
                }
            </div>
        </Frame>
    );
}