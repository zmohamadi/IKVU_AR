"use client";

import { useLang } from "@/lib/lang";
import { useRouter } from 'next/navigation';
import { ButtonContainer,Button } from "@/Theme/Midone/Forms";

export function ShowReply({ questions, answer, dispalyResult, responseCount }){
        const {Lang} = useLang();
        const router = useRouter();
        const back = ()=>router.back();

        return <>
                {questions?.map((question, index)=>{
                        return(
                                <>
                                        <div className="flex">
                                                <li className="ml-auto"><strong>{index+1+") "+question?.title}</strong></li>
                                                {(index == 0 && dispalyResult)? <div className="font-medium">{Lang("public.title_selected")}</div>: ""}
                                        </div>
                                        <ul className="">
                                                {question?.question_options?.map((option, i)=>{
                                                        let percent = (responseCount>0)? (option?.count_selected*100)/responseCount : 0;
                                                        let result = (dispalyResult && percent >= 0)? percent+"%" : "";
                                                        let display = (answer?.[question?.id] == option?.id)?
                                                                <li className="text-theme-10"><strong>{i+1+") "+option?.title}</strong> </li>
                                                        :
                                                                <div className="flex">
                                                                        <li className="ml-auto">{i+1+") "+option?.title}</li>
                                                                        <div className="font-medium">{result}</div>
                                                                </div>

                                                        return display
                                                        // return <li>{ index+1 } ")" {option?.title} </li>
                                                })}
                                        </ul>
                                </>
                        );}
                )}
                <ButtonContainer>
                    <Button label="back" onClick={back} />
                </ButtonContainer>
        </>;
}