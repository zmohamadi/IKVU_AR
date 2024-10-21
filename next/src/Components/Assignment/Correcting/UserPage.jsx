"use client";

import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useData,useFormRefs,Frame } from "@/Theme/Midone/Forms";
import { AssDescription,AssInfo,ResponderInfo,FormDescriptive,FormScore,OtherReply } from '@/Components/Assignment/Details';

export function UserPage({ laraPath, toolsId, attemp, course, nextPath = "" }) {
    const { Lang } = useLang();
    const component = useFormRefs();
    const { save,get } = useData();

    // Define form URL and HTTP method
    let formUrl = "/assignments-answer/";
    let url = laraPath + formUrl;
    if (attemp !== 0 && attemp !== undefined) {
        url = laraPath + formUrl + toolsId + "/" + attemp;
    }

    // Fetch data on component mount if `attemp` is not 0 or undefined
    useEffect(() => {
        get(url, component, "info");
    }, []);

    useEffect(() => {
        if(component?.state?.info?.answer?.id)
            save(laraPath+`/assignments-answer/visit-reply?reply=${component?.state?.info?.answer?.id}`, component, "edit");
    }, [component?.state?.info?.answer?.id]);

    // Destructure the fetched data
    const { info } = component?.state ?? {};
    const { assignment, answer, answerDetail } = info ?? {};
    let comOther = "";
    let displayForm = "";
    let classType1 = "col-span-12";
    if(assignment?.question_type_id == 1)
    {
        classType1 = "col-span-8";
        comOther =<OtherReply detail={answerDetail} />;
        displayForm = <FormDescriptive answer={answer} id={toolsId} course={course} laraPath={laraPath} nextPath={nextPath}
                        saveUrl={`/assignments-answer/${toolsId}/${attemp}/text?reply=${answer?.id}`} backUrl={`/${toolsId}/correcting`} />
    }

    return (
        <Frame>
            <div className="col-span-12 xxl:col-span-9">
                <div className="grid grid-cols-12 gap-6">
                    <div className="col-span-12 lg:col-span-12 sm:hidden">
                        <AssDescription description={assignment?.description} files={assignment?.files} options={assignment?.options} correct={assignment?.correct_option_id} detail={answerDetail} />
                        <AssInfo data={assignment} />
                        <ResponderInfo responder={answer?.user} />
                        {comOther}
                        {displayForm}
                        <div className="intro-y box p-5 mt-3 sm:mt-0">
                            <FormScore toolsId={toolsId} course={course} answerId={answer?.id} assignmentScore={assignment?.score} answerScore={answer?.score} url={url} Lang={Lang} parent={component} nextPath={nextPath} />
                        </div>
                    </div>
                    <div className="col-span-12 lg:col-span-8 hidden sm:block">
                        <AssDescription description={assignment?.description} files={assignment?.files} options={assignment?.options} correct={assignment?.correct_option_id} detail={answerDetail} />
                        {comOther}
                        {displayForm}
                    </div>
                    <div className="col-span-12 lg:col-span-4 hidden sm:block">
                        <AssInfo data={assignment} />
                        <ResponderInfo responder={answer?.user} />
                        <div className="intro-y box p-5">
                            <FormScore toolsId={toolsId} course={course} answerId={answer?.id} assignmentScore={assignment?.score} answerScore={answer?.score} url={url} Lang={Lang} parent={component} nextPath={nextPath} />
                        </div>
                    </div>
                </div>
            </div>
        </Frame>
    );
}
