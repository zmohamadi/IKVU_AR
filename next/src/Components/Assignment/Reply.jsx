"use client";

import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useData, useFormRefs, FeatherIcon, Frame } from "@/Theme/Midone/Utils";
import { AlertReply,AssDescription,AssInfo,FormDescriptive,FormMultipleChoice,OtherReply } from '@/Components/Assignment/Details';

export function Reply({ id, course, laraPath, nextPath = "" }) {
    const { Lang } = useLang();
    const component = useFormRefs();
    const { save,get } = useData();
    const url = `${laraPath}/assignment/reply-info/${id}`;

    useEffect(() => {
        get(url, component, "info");
    }, []);

    useEffect(() => {
        if(component?.state?.info?.answer?.id)
            save(laraPath+`/assignments-answer/visit-reply?reply=${component?.state?.info?.answer?.id}`, component, "edit");
    }, [component?.state?.info?.answer?.id]);

    const { info } = component?.state ?? {};
    const { result, item, answer, answerDetail } = info ?? {};

    let displayBox = <AssDescription description={item?.description} files={item?.files} options={item?.options} detail={answerDetail} />;
    let displayForm = "";
    let displayAlert = "";
    if(result?.flag)
    {
        if(!answer?.score)
        {
            if(item?.question_type_id===1)
                displayForm = <FormDescriptive answer={answer} id={id} course={course} laraPath={laraPath} nextPath={nextPath} />
            else if(item?.question_type_id===2)
                displayBox = <FormMultipleChoice id={id} course={course} laraPath={laraPath} nextPath={nextPath} data={item} />
        }
    }
    else
        displayAlert = <AlertReply data={item} result={result} />
    
    return (
        <Frame title={Lang(["public.assignment"])}>
            <div className="col-span-12 xxl:col-span-9">
                {(!item)?
                    <div class="intro-y grid grid-cols-12 sm:gap-6 gap-y-6 box px-5 py-8 mt-5">
                        <div className="col-span-6 sm:col-span-3 xl:col-span-2 flex flex-col justify-end items-center">
                            {/* <i data-feather="User" className="w-8 h-8"></i>  */}
                            {/* <i data-loading-icon="circles" className="w-8 h-8"></i>  */}
                            {/* <FeatherIcon name="User" className="w-8 h-8" /> */}
                            <div className="text-center text-xs mt-2">دایره</div>
                        </div>
                    </div>
                    // <span className="alert alert-success-soft show flex items-center mb-2 mt-5">{Lang("public.loading")+"....."}</span>
                :
                    <>
                        <div className="grid grid-cols-12 gap-6">
                            <div className="col-span-12 lg:col-span-12 sm:hidden">
                                {displayBox}
                                <AssInfo data={item} />
                                {displayAlert}
                                {(item?.question_type_id===1)?
                                    (!answer?.score || (answer?.score && item?.to_students))?
                                        <OtherReply detail={answerDetail} />
                                    :
                                        <div className="alert alert-outline-danger alert-dismissible show flex items-center mt-5" role="alert">
                                            <FeatherIcon name="AlertCircle" className="w-4" />
                                            <span className="pr-3"></span>{Lang("public.not_access_view_reply")}
                                        </div> 
                                : ""                                   
                                }
                                {displayForm}
                            </div>
                            <div className="col-span-12 lg:col-span-8 hidden sm:block">
                                {displayBox}
                                {displayAlert}
                                {(item?.question_type_id===1)?
                                    (!answer?.score || (answer?.score && item?.to_students))?
                                        <OtherReply detail={answerDetail} />
                                    :
                                        <div className="alert alert-outline-danger alert-dismissible show flex items-center mt-5" role="alert">
                                            <FeatherIcon name="AlertCircle" className="w-4" />
                                            <span className="pr-3"></span>{Lang("public.not_access_view_reply")}
                                        </div> 
                                : ""                                   
                                }
                                {displayForm}
                            </div>
                            <div className="col-span-12 lg:col-span-4 hidden sm:block">
                                <AssInfo data={item} />
                            </div>
                        </div>
                    </>
                }
            </div>
        </Frame>
    );
}
