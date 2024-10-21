"use client";

import { Tools} from "@/Theme/Midone/Utils";
import { Radio, Textarea } from "@/Theme/Midone/Forms";


export function Answer({questions, component}){
    return(<>
            {Tools.getArray(questions).map((question, qindex)=>{
                return <ul>
                        {question?.question_type_id==2 ?<>
                            <li>
                            <Radio value="0" label={ [(parseInt(qindex)+1)+") "+ question?.title+" (score: "+question?.score+")"]} data={question?.question_options} refItem={[component, "response_"+question?.id]} />
                            
                        </li></> :<>
                            <div className="font-bold"  dangerouslySetInnerHTML={{ __html: qindex+1 +") "+ question?.title+" (score: "+question?.score+")" }}></div> 
                            <li><Textarea label="Your Answer" className="col-span-6" refItem={[component, "response_"+question?.id]} /></li>
                        </>
                        }
                    </ul>
                })
            }
    </>
);
}