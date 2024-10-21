"use client";
import { useEffect, useState } from "react";
import { useLang } from "@/lib/lang";
import { Tools, useData,useFormRefs } from "@/Theme/Midone/Utils";
import { Box, Button, ButtonContainer, Input, Radio, Textarea } from "@/Theme/Midone/Forms";
import { useRouter } from 'next/navigation';
// import { useAuth} from "@/Theme/Site/Components/Auth/auth";

export function ReplyMultiPage({laraPath,course,id,nextPath=""}){
    
    const router = useRouter();
    const back = ()=>router.back();
    const {Lang} = useLang();
    let component = useFormRefs();
    const [currentQuestionIndex, setCurrentQuestionIndex] = useState(0);
    const [timer, setTimer] = useState(600);
    const [quizEnded, setQuizEnded] = useState(false);

    let {get,save} = useData();
    let formUrl = "/quiz";
    let url = laraPath+formUrl+"/"+id;
    useEffect(() => {
        get(url, component, "info");
    }, []);
   
    useEffect(() => {
        const interval = setInterval(() => {
            setTimer(prevTimer => {
              if (prevTimer <= 1) {
                clearInterval(interval);
                setQuizEnded(true); // Set quizEnded to true when timer ends
              }
              return prevTimer - 1;
            });
          }, 1000);
          return () => clearInterval(interval);
    }, []);
    
    const saveItem = () => save(laraPath+formUrl+"reply/"+id, component, "edit", nextPath+"/courses/"+course+"/tools/quiz"+"?"+Math.random());

    const goToNext = () => {
        if (currentQuestionIndex < questions.length - 1) {
          setCurrentQuestionIndex(currentQuestionIndex + 1);
        }
      };
    
      const goToPrevious = () => {
        if (currentQuestionIndex > 0) {
          setCurrentQuestionIndex(currentQuestionIndex - 1);
        }
      };

      
    const data = component?.state?.info;
    const questions = data?.questions;
    const currentQuestion = questions[currentQuestionIndex];

    return(<>
        <Box cols="grid-cols-1" title={Lang(["public.reply", "public.quiz"])} >
            <Input type="hidden" value={course} refItem={[component, "course_id"]} />
            
            <ul className="mb-5">
                <li className=" text-left"> <h4 className="font-bold text-xl mb-3">Time Remaining: {Math.floor(timer / 60)}:{('0' + timer % 60).slice(-2)}</h4></li>
                <li>
                    <h4 className="font-bold text-xl mb-3">{data.title}</h4>
                </li>
            </ul>


            {Tools.getArray(data?.questions).map((question,qindex)=>{
                return <ul className="pl-5">
                    {question?.question_type_id==2 ?<>
                        <li>
                        <Radio label={ [(parseInt(qindex)+1) , question?.title]} data={question?.question_options} refItem={[component, "response_"+question?.id]} />
                        
                    </li></> :<>
                        <div  dangerouslySetInnerHTML={{ __html: qindex+1 +") "+ question?.title }}></div> 
                        <li><Textarea label="Your Answer" className="col-span-6" refItem={[component, "response_"+question?.id]} /></li>
                    </>
                    }
                </ul>
            })
            }
                
            
        </Box>
        <ButtonContainer>
            {currentQuestionIndex > 0 && (
                <Button label="Previous" onClick={goToPrevious} />
            )}
            {currentQuestionIndex < questions.length - 1 ? (
                <Button label="Next" onClick={goToNext} />

            ) : (
                <Button label="save" onClick={saveItem} />
            )}
            {/* <Button label="back" onClick={back} /> */}
        </ButtonContainer>
    </>
);
}