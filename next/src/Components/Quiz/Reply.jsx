"use client";

import { useEffect, useRef, useState } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useData,useFormRefs } from "@/Theme/Midone/Utils";
import { Box, Button, ButtonContainer, Input, Frame, Radio, Textarea } from "@/Theme/Midone/Forms";
import { useRouter } from 'next/navigation';
import CircleTimer from './CircleTimer';
import { useUtility } from "@/lib/utility";
import { Answer } from "../Public/Question/Answer";

export function Reply({laraPath, course, id, nextPath=""}){
    const [ quizInfo, setQuizInfo ] = useState({status: "loading"});
    const effectRan = useRef(false);

    let {getNeedles } = useData();    

    let formUrl = "/quiz";
    // let url = laraPath+formUrl+"/"+id;

    useEffect(() => {
        if (!effectRan.current) {
            getNeedles(laraPath+formUrl+"/attemp/"+id, setQuizInfo);
        }
        return () => effectRan.current = true;
    }, []);

    if(quizInfo.status == "loading"){
        return <Loading />
    }else if(quizInfo.status != "reply_time"){
        return <Message message={quizInfo?.message} quiz={quizInfo?.quiz} />
    }else if(quizInfo.data.one_page == "1"){
        return <OnePageAnswering quizInfo={quizInfo} laraPath={laraPath} course={course} />
    }else{
        return <MultiPageAnswering quizInfo={quizInfo} laraPath={laraPath} course={course} id={id} />
    }
}

const Message = ({message, className = "", quiz = {}}) => {
    const {laraDomain} = useConfig();
    const {Lang, dir} = useLang();
    return<>
        <Frame title = {Lang('quiz_message')}>            
            <Box className="col-span-8 overflow-hidden text-lg" title={Lang("quiz_status")} shadow={false} >
                <div className="col-span-12" style={{overflow: "hidden1", position: "relative1", minHeight: "150px"}}>
                    <div className="w-3/5 " dangerouslySetInnerHTML={{__html: message}}></div>
                    <img className= {"hidden sm:block absolute w-2/5 mb-1 " + (dir == "rtl"? " left-2 ml-4":" right-2 mr-12")}
                        alt="" 
                        style={{top: "100px"}}
                        src={laraDomain+"/admin/Midone-v3/Icewall_v1.0.9/dist/images/phone-illustration.svg"}></img>
                </div>
            </Box>
            <Box className="col-span-4 bg-theme-17 text-white mt-5 rounded-md" title={Lang("quiz_info")} shadow={false} >
                <div className="col-span-12 text-md">
                    <h4><b>{quiz.title}</b></h4>
                    <div className="mt-4"><b className="mx-2">{Lang("start")}: </b>{quiz.start_date}</div>
                    <div className="mt-1 mb-3 mx-6 px-6">{quiz.start_time}</div>
                    <div className="mt-2"><b className="mx-2">{Lang("end")}: </b>{quiz.end_date}</div>
                    <div className="mt-1 mb-3 mx-6 px-6">{quiz.end_time}</div>
                    <div className="mt-2"><b className="mx-2">{Lang("public_score")}: </b>{quiz.total_score}</div>
                    {quiz.limit_time > 0? <div className="mt-2"><b className="mx-2">{Lang("limit")}: </b>{quiz.limit_time} minutes</div>: ""}
                </div>
            </Box>
        </Frame>
    </>
}

const Loading = () => {
    return<>
        <Frame title = "Quiz loading.." className="intro-y">
            <div className="box px-5 mt-5 col-span-8 animated-background min-h-5" 
                style={{height: "250px"}}>
                <div className="p-5 grid gap-4 grid-cols-12">
                </div>
            </div>
            <div className="box px-5 mt-5 col-span-4 animated-background min-h-5">
                <div className="p-5 grid gap-4 grid-cols-12">
                </div>
            </div>
        </Frame>
    </>
}

const OnePageAnswering = ({quizInfo, laraPath, course, id}) => {
    const router = useRouter();
    const back = ()=>router.back();
    let { save, postData } = useData();
    const [ quizEnded, setQuizEnded ] = useState(false);
    let component = useFormRefs();
    let formUrl = "/quiz";
    const closeQuiz = () => {
        setQuizEnded(true);
        postData(laraPath+ formUrl+ "/reply/"+ id, component);
    };
    const colors = ['#FF6347', '#FFD700', '#32CD32'];
    // const saveItem = () => save(laraPath+ formUrl+ "/reply/"+ id, component, "new", nextPath+"/courses/"+course+"/tools/quiz"+"?"+Math.random());
    const saveItem = () => save(laraPath+ formUrl+ "/reply/"+ id, component, "new");
    console.log("answers", quizInfo?.data?.answers);

    return(<>
            <Frame title ="Quiz Answering" className="intro-y">
                <Box cols="grid-cols-1" title={quizInfo?.data?.title} >
                    <Input type="hidden" value={course} refItem={[component, "course_id"]} />
                    <div className="timer">
                        {
                            quizInfo?.data?.deadline_time?
                                <CircleTimer 
                                    duration={quizInfo?.data?.deadline_time} 
                                    onComplete={closeQuiz} />
                            : ""
                        }
                    </div>
                    {
                        quizInfo?.data?.answers?.map((item, index)=>{
                            return <ReplyItem reply={item} component={component} qindex={index} key={index} />
                        })
                    }
                    {quizEnded ? <p className="font-bold text-xl" style={{color:'orange'}}>Time Ended</p> :""}
                </Box>
                <ButtonContainer className="col-span-12">
                    <Button label="back" onClick={back} />
                    {
                        !quizEnded? <Button label="save" onClick={saveItem} /> : ''
                    }
                </ButtonContainer>
            </Frame>
        </>
    );
}

const MultiPageAnswering = ({quizInfo, laraPath, course, id}) => {
    const router = useRouter();
    let { save, postData } = useData();
    const [ quizEnded, setQuizEnded ] = useState(false);
    let component = useFormRefs();
    let formUrl = "/quiz";

    const closeQuiz = () => {
        setQuizEnded(true);
        postData(laraPath+ formUrl+ "/reply/"+ id, component);
    };

    const getCurrentQuestion = () => {
        let last  = 0;
        quizInfo?.data?.answers.map((item, index)=>{
            if(item.answer != undefined || item.answer_option_id != undefined){
                last = index;
            }
        });
        if(last > quizInfo?.data?.answers.length){
            last--;
        }
        return last;
    }

    const showQuestion = (type = "next") => {
        if(type == "next" && current < quizInfo?.data?.answers?.length - 1){
            saveItem();
            setCurrent(current+1);
        }
        else if(type == "previous" && current > 0){
            saveItem();
            setCurrent(current-1);
        }
    }

    const [ current, setCurrent ] = useState(getCurrentQuestion());
    const colors = ['#FF6347', '#FFD700', '#32CD32'];
    const {Lang} = useLang();
    const saveItem = () => {
        save(laraPath+formUrl+"/reply/"+id, component, "new", "", (d, r)=>{
             quizInfo?.data?.answers?.map((item, index)=>{
                if(item.question_id == r[0]['id']){
                    quizInfo.data.answers[index]['answer_option_id'] = r[0]['answer_option_id'];
                    quizInfo.data.answers[index]['answer'] = r[0]['answer'];
                }
             })
        })
    };
    
    return(<>
            <Frame title ={Lang('quiz_answering')} className="intro-y">
                <Box className="col-span-8" title={quizInfo?.data?.title} >
                    <div className="grid-cols-1 col-span-12">
                        <Input type="hidden" value={course} refItem={[component, "course_id"]} />
                        <ReplyItem reply={quizInfo?.data?.answers[current]} component={component} qindex={current} key={current-1} />                        
                        {quizEnded ? <p className="font-bold text-xl" style={{color:'orange'}}>Time Ended</p> :""}
                    </div>
                </Box>
                <Box className="col-span-4 " title={quizInfo?.data?.title} shadow={false} >
                    <div className="col-span-12 relative">
                        <div className="timer">
                            {
                                quizInfo?.data?.deadline_time?
                                    <CircleTimer 
                                        duration={quizInfo?.data?.deadline_time} 
                                        onComplete={closeQuiz} />
                                : ""
                            }
                        </div>
                    </div>
                    <h3 className="col-span-12 text-lg font-bold">{Lang('quiz_overview')}</h3>
                    <div className="col-span-12 grid grid-cols-4 gap-4 mt-12">
                        {
                            quizInfo?.data?.answers.map((item, index) => {
                                let className = index > current ? "bg-gray-300": 
                                    item.answer_option_id > 0 || item.answer != undefined? "bg-purple-300" : "bg-amber-200";
                                return <div key={index} className={"w-full text-center text-md font-bold shadow-lg pb-full rounded-x py-4 " + className}>
                                    {index + 1}
                                </div>
                            })
                        }
                    </div>
                </Box>
                <ButtonContainer className="col-span-12">
                    <Button label="previous" className={"btn w-24 inline-block ml-1 mb-2 " + ((current == 0) ? "btn-outline-primary": "btn-instagram")} 
                        onClick={()=>showQuestion("previous")} disabled = {current == 0} />
                    {
                        !quizEnded? <Button label="save" className={"btn btn-linkedin w-20 mr-1 ml-1"} onClick={saveItem} /> : ''
                    }
                    <Button label="next" className={"btn w-24 inline-block ml-1 mb-2 " + ((current == quizInfo?.data?.answers?.length -1) ? "btn-outline-primary": "btn-instagram")}
                        onClick={()=>showQuestion("next")} disabled = {current == quizInfo?.data?.answers?.length -1} />
                </ButtonContainer>
            </Frame>
        </>
    );
}

const ReplyItem = ({reply, component, qindex})=>{
    let {Lang } = useLang();
    let {question} = reply;
    return <ul>
            {question?.question_type_id==2 ?<>
                    <li>
                        <div className="font-bold" dangerouslySetInnerHTML={{ __html: (parseInt(qindex)+1)+") "+ question?.title }}></div> 
                        <div className="font-bold float-end"> {Lang('public.score')}: {question?.score} </div>
                        <Radio value="0" 
                                label={" "} 
                                data={question?.questionOptions} 
                                refItem={[component, "response_"+question?.id+"#"+question?.question_type_id]}
                                defaultValue={reply.answer_option_id}
                        />
                    </li>
                </>:<>
                    <li>
                        <div className="font-bold" dangerouslySetInnerHTML={{ __html: (parseInt(qindex)+1) +") "+ question?.title }}></div> 
                        <div className="font-bold float-end"> {Lang('public.score')}: {question?.score} </div>
                        <Textarea 
                            label=" " 
                            className="col-span-6" 
                            refItem={[component, "response_"+question?.id+"#"+question?.question_type_id]}
                            defaultValue={reply.answer}
                        />
                    </li>
                </>
            }
        </ul>
}