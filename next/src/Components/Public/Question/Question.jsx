"use client";
import { useEffect, useState } from "react";
import { useLang } from "@/lib";
import { Input ,Textarea , Radio , Box } from "@/Theme/Midone/Forms";

export function Question({ index, parent, needles }) {
    const { Lang, local } = useLang()
    let question = parent?.state?.info?.questions?.[index];
    const [answerType, setAnswerType] = useState(question?.question_type_id == 2? 2 : 1);    
    useEffect(()=>{
        setAnswerType(question?.question_type_id == 2? 2 : 1)
    }, [question]);

    let i = index + 1;
    let options= [];
    for(let i = 0; i < 4; i++)
    {
        if(question?.question_options[i])
            options.push("id"+question?.question_options[i]?.id);
        else
            options.push(i+1);
    }
    return <>
        <Box shadow={false}>
            <Textarea className="col-span-9" label={Lang("public.question")+" "+i} required="true"
                refItem={[parent, "question_"+index]} defaultValue={question?.title}
            />
            <div className="col-span-3">
                <div className="grid p-1 gap-4 grid-cols-1">
                    {
                        question?.id? <Input type="hidden" refItem={[parent, "id_"+index]} defaultValue={question?.id} /> : ""
                    }
                    <Input className="col-span-12" label={Lang("public.score")} required="true" 
                        refItem={[parent, "score_"+index]} defaultValue={question?.score}
                    />
                    <Input className="col-span-12" label={Lang("public.order")} required="true"
                        refItem={[parent, "order_"+index]} defaultValue={question?.order ?? (index+1)}
                    />
                    <Radio type="col" className="col-span-12" label={Lang("public.type")} required="true"
                        refItem={[parent, "qTypes_"+index]} defaultValue={answerType}
                        data={needles?needles:[]} titleKey={"title_" + local} key={"type_id" + answerType} 
                        onChange={(e) => setAnswerType(e.target.value)}
                    />
                </div>

            </div>
            {
                (answerType == 2) ? <>
                    <div className="col-span-12 grid grid-cols-12">
                        <Radio defaultValue={"id"+question?.correct_option_id} data={[{id:options[0]}]} refItem={[parent, "correctOption_"+index]} id={"correctOption_"+index} className="col-span-1 mt-4" label=" " />
                        <Input label="option_1" refItem={[parent, "qOption_" + index + '#' + options[0]]} defaultValue={question?.question_options[0]?.title} className="col-span-11" />
                    </div>

                    <div className="col-span-12 grid grid-cols-12">
                        <Radio defaultValue={"id"+question?.correct_option_id} data={[{id:options[1]}]} refItem={[parent, "correctOption_"+index]} id={"correctOption_"+index} className="col-span-1 mt-4" label=" " />
                        <Input label="option_2" refItem={[parent, "qOption_" + index + '#' + options[1]]} defaultValue={question?.question_options[1]?.title} className="col-span-11" />
                    </div>

                    <div className="col-span-12 grid grid-cols-12">
                        <Radio defaultValue={"id"+question?.correct_option_id} data={[{id:options[2]}]} refItem={[parent, "correctOption_"+index]} id={"correctOption_"+index} className="col-span-1 mt-4" label=" " />
                        <Input label="option_3" refItem={[parent, "qOption_" + index + '#' + options[2]]} defaultValue={question?.question_options[2]?.title} className="col-span-11" />
                    </div>

                    <div className="col-span-12 grid grid-cols-12">
                        <Radio defaultValue={"id"+question?.correct_option_id} data={[{id:options[3]}]} refItem={[parent, "correctOption_"+index]} id={"correctOption_"+index} className="col-span-1 mt-4" label=" " />
                        <Input label="option_4" refItem={[parent, "qOption_" + index + '#' + options[3]]} defaultValue={question?.question_options[3]?.title} className="col-span-11" />
                    </div>
                </>
                :''
            }
    </Box>
    </>
}