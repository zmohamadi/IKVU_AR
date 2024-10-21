"use client";
import { Radio, Textarea } from "@/Theme/Midone/Forms";
import { FeatherIcon, Tools } from "@/Theme/Midone/Utils";
export function Show({question,component,qindex,time}){
    let answer = question?.answers[0];
    // let reply = false;
    // reply = answer? true : false;
    const qType = question?.question_type_id==1 ? 1 : 2;
    return(<>
            <li className="mt-3" >
                <div className="font-bold"  dangerouslySetInnerHTML={{ __html: qindex+1 +") "+ question?.title +" (score: "+question?.score+")"}}></div>

                {time ?qType==1 ?<Textarea defaultValue={answer?.answer} label="Your Answer" className="col-span-6" refItem={[component, "response_"+question?.id]} />
                        :<Radio defaultValue={answer?.answer_option_id} value="0" label=" " data={question?.question_options} refItem={[component, "response_"+question?.id]} />
                    
                    :qType==1?<div  dangerouslySetInnerHTML={{ __html: " <b>Your Answer :</b> "+ answer?.answer }}></div>
                    : <ul className="pl-5">
                        {Tools.getArray(question?.question_options).map((options,index)=>{
                                return <li>
                                    { index+1 +"- "+ options?.title }{ answer?.answer_option_id==options?.id?
                                    <FeatherIcon spanWrapperClass="display-inline pl-1" size="16" name="CheckCircle" color="green"  />
                        :""}
                                </li>
                            })}
                    </ul>}
            </li>    
        </>
    );
}