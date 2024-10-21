"use client";
import { useEffect, useMemo } from "react";
import { useLang } from "@/lib/lang";
import { useRouter } from 'next/navigation';
import { useData, useFormRefs, Input, Button, ButtonContainer, Frame, Box } from "@/Theme/Midone/Forms";
import { FeatherIcon, Tools } from "@/Theme/Midone";
import { Select } from "@/Theme/Midone/Forms/Select";

export function UserPage({ laraPath, toolsId, attemp, course, nextPath = "" }) {
    const { Lang } = useLang();
    const component = useFormRefs();
    const router = useRouter();
    const { save, get } = useData();
    
    const formUrl = "/quiz-attemp/";
    const url = `${laraPath}${formUrl}${attemp}`;
    const method = "edit";

    useEffect(() => {
        if (attemp) get(url, component, "info");
    }, []); // اضافه کردن آرایه خالی به عنوان وابستگی‌ها

    const saveItem = () => {
        const redirectUrl = `${nextPath}/courses/${course}/tools/quiz/${toolsId}/correcting?${Math.random()}`;
        save(url, component, method,redirectUrl);
    };

    const back = () => router.back();

    const attempInfo = component?.state?.info;
    const answers = Tools.getArray(attempInfo?.answers);

    return (
        <>
            <Frame>
                <Box>
                    <p className="col-span-12">
                        <b>{Lang("public.student")}:</b> {`${attempInfo?.user?.firstname} ${attempInfo?.user?.lastname}`} , {attempInfo?.user?.email || "---"}
                    </p>
                    <p className="col-span-12">
                        <b>{Lang("public.date")} {Lang("public.reply")}:</b> {Tools.toJalaliDateString(attempInfo?.created_at)}
                    </p>
                </Box>
                <Input type="hidden" defaultValue={toolsId} refItem={[component, "quiz_id"]} />
                
                {answers.map((answer, index) => (
                    <Box key={index}>
                        <QuestionBox answer={answer} index={index} Lang={Lang} component={component} />
                    </Box>
                ))}
            </Frame>
            <ButtonContainer>
                <Button label="correcting" onClick={saveItem} />
                <Button label="back" onClick={back} />
            </ButtonContainer>
        </>
    );
}

function QuestionBox({ answer, index, Lang, component }) {
    const isMultipleChoice = answer?.question?.question_type_id !== 1;
    const questionTitle = `${Lang("public.question")} ${index + 1} ) ${answer?.question?.title}`;
    
    const maxScore = answer?.question?.score;

    const scoreOptions = Array.from({ length: parseInt(maxScore) + parseInt(1) }, (_, i) => i);

    return (
        <>
            <p className="col-span-12"><b>{questionTitle}</b> ({Lang("public.score_bar")}: {answer?.question?.score} - {Lang("public.score")} {Lang("public.student")}  : {answer?.score})</p>
            
            {isMultipleChoice ? (
                <MultipleChoiceQuestion answer={answer} Lang={Lang} component={component} />
            ) : (
                <>
                    <p className="sm:col-span-11 md:col-span-10 pl-5">
                        <span className="font-bold">{Lang("public.reply")}:</span> 
                        {answer?.answer || Lang("public.no_reply_question")}
                    </p>
                    <Select className="sm:-span-11 md:col-span-2"
                        label={Lang("public.score")}
                        refItem={[component, `mark_${answer?.id}`]}
                        required={true}
                        defaultValue={answer?.score}
                    >
                        {Tools.getArray(scoreOptions).map((score, index) => (
                            <option key={index} value={score}>
                                {score}
                            </option>
                        ))}
                    </Select>
                </>
            )}
        </>
    );
}


function MultipleChoiceQuestion({ answer, Lang, component }) {
    return (
        <>
            {Tools.getArray(answer?.question?.question_options).map((option, index) => (
                < >
                    <Input type="hidden" defaultValue={answer?.answer_option_id === answer?.question?.correct_option_id ? answer?.question?.score : 0} refItem={[component, `mark_${answer?.id}`]} required />
                    <p key={index} className={option?.id === answer?.question?.correct_option_id ? "col-span-5 pl-5 bg-blue-200" : "col-span-12 pl-5"}>
                        {index + 1}) {option?.title}
                        {answer?.answer_option_id == option?.id && (
                            <FeatherIcon
                                spanWrapperClass="display-inline pl-1"
                                size="16"
                                name="CheckCircle"
                                color={answer?.answer_option_id == answer?.question?.correct_option_id ? "green" : "red"}
                            />
                        )}
                    </p>
                </>
            ))}
        </>
    );
}
