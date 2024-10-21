"use client";
import { useEffect, useState } from "react";
import { useLang } from "@/lib/lang";
import { usePathname, useRouter } from 'next/navigation';
import { useData, useFormRefs, Input, Textarea, Button, ButtonContainer, CheckBox, DatePicker, SelectTail, Radio, Box, Frame } from "@/Theme/Midone/Forms";
import { Select } from "@/Theme/Midone/Forms/Select";
import { Dropzone } from "@/Theme/Midone/Forms/Dropzone";
import { YearGroup } from "@/Components/Public/YearGroup";

export function Form({ laraPath, id, course, nextPath = "" }) {
    const { Lang, local } = useLang();
    const router = useRouter();
    const component = useFormRefs();
    const { save, get, getNeedles, getRefValue } = useData();
    const [needles, setNeedles] = useState();
    const [type, setType] = useState(1);
    const [assignment, setAssignment] = useState(null);
    const [studentSelection, setStudentSelection] = useState([]);
    const [displaySelect, setDisplaySelect] = useState(false);
    const [selectFor, setSelectFor] = useState(1);
    const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'courses';

    const formUrl = `${laraPath}/assignments`;
    const url = id ? `${formUrl}/${id}` : formUrl;
    const method = id ? "edit" : "new";
    
    let uploadUrl=laraPath+"/upload/.-media-assignment";
    let deleteUrl=laraPath+"/deleteFile/.-media-assignment";

    useEffect(() => {
        const fetchData = async () => {
            await getNeedles(`${laraPath}/assignments/get-needles`, setNeedles);
            if (id) {
                await get(url, component, "info");
            }
        };
        fetchData();
    }, [id, laraPath, url]);

    useEffect(() => {
        if (component?.state?.info) {
            setType(component.state.info.question_type_id);
            setAssignment(component.state.info);

            if(component?.state?.info?.for_students){
                handleStudentSelection("", 2, component);
            }else{
                handleStudentSelection();
            }
                // setSelectFor(2);
        }
    }, [component?.state?.info]);

    const saveItem = () => {
        const saveUrl = `${nextPath}/${menuPath}/${course}/tools/assignment?${Math.random()}`;
        save(url, component, method, saveUrl);
    };

    const chooseType = (e) => { setType(e.value); };
    const back = () => { router.back(); };

    const renderOptions = () => {
        const options = [];
        for (let i = 0; i < 4; i++) {
            const optionId = assignment?.options?.[i]?.id ? `id${assignment.options[i].id}` : i + 1;
            options.push(optionId);
        }

        return options.map((option, index) => (
            <div className="col-span-12 grid grid-cols-12" key={index}>
                <Radio
                    defaultValue={`id${assignment?.correct_option_id}`}
                    data={[{ id: option }]}
                    refItem={[component, `correctOption`]}
                    id={`correctOption`}
                    className="col-span-1 mt-4"
                    label=" "
                />
                <Input
                    label={`option_${index + 1}`}
                    refItem={[component, `option_${index + 1}#${option}`]}
                    defaultValue={assignment?.options?.[index]?.title || ""}
                    className="col-span-11"
                />
            </div>
        ));
    };
    const selected = [
        {'title':Lang("public.text_select_assignment_1"), 'id':1,},
        {'title':Lang("public.text_select_assignment_2"), 'id':2,}
    ];
    const handleStudentSelection = function (e = "", forAll = selectFor, parent = component) {
        let info = parent?.state?.refs?.current;
        let semester = info?.semester?.value;
        let groupCode = info?.group_code?.value;
        // let semester = getRefValue('semester', component);
        // let groupCode = getRefValue('group_code', component);
        let valueSelected = (e == "")? forAll : e.target.value;

        // console.log(semester+" -- "+groupCode);
        if(semester != 0 && groupCode != "00")
        // if(semester > 0 && groupCode > 0)
        {
            // console.log("if 1");
            if(valueSelected == 2)
            {
                getNeedles(`${laraPath}/assignments/get-students?course=${course}&year=${semester}&group=${groupCode}`, setStudentSelection);
                setDisplaySelect(true);
                setSelectFor(2)
            }
            else
            {
                setStudentSelection([]);
                setDisplaySelect(false);
                setSelectFor(1)
            }
        }
        else
        {
            // console.log("else 1");
            if(e == "")
            {
                setSelectFor(valueSelected)
                setDisplaySelect(valueSelected == 2? true: false);
            }
            else
            {
                alert(Lang("public.text_select_student"));
                setStudentSelection([]);
                setDisplaySelect(false);
                setSelectFor(1)
            }
        }
    }
    let sessions = [];
    for(let i=1; i <= 18; i++)
    {
        sessions.push({ id:i });
    }
    return (
        // (component?.state?.info?.for_students == undefined)?
        // "loding"
        // :
            <>
                <Frame title={Lang(["public.assignment"])}>
                    <div className="col-span-12 pos intro-y grid grid-cols-12 gap-5 mt-5">
                        <div className="intro-y col-span-12 lg:col-span-8">
                            <Input className="col-span-12" refItem={[component, "title"]} required="true" />
                            <Input type="hidden" defaultValue={course} refItem={[component, "course_id"]} />
                            <div className="post intro-y p-3 box mt-5 ">
                                <Textarea row="10" className="col-span-12 mb-1" required="true" label="description" refItem={[component, "description"]} />
                                <SelectTail className="mt-1" label="type" refItem={[component, "question_type_id"]}
                                    defaultValue={component?.state?.info?.question_type_id? component?.state?.info?.question_type_id:1} 
                                    data={needles?.questiontype} titleKey={`title_${local}`} key={`question_type_id${needles?.questiontype?.length || 0}`}
                                    onChange={chooseType}
                                />
                                {type == 2 && renderOptions()}
                            </div>
                            <div className="post intro-y p-3 box mt-5 ">
                                <div className="lg:grid grid-cols-12 gap-5 mt-5">
                                    <YearGroup component={component} needles={needles} 
                                    // onGroupChange = {"jfjjfjfj"}
                                    onGroupChange = {function(){handleStudentSelection("", 1)}}
                                    />
                                </div>
                                <Radio className="mt-3" label="text_assignment_label" id="select" refItem={[component, `selectFor`]} defaultValue={selectFor}
                                    data={selected} onChange={(e) => handleStudentSelection(e)} required key={"selectFor-"+Math.random()}
                                    // key={"selectFor-"+selectFor}
                                />
                                {displaySelect?
                                    <SelectTail refItem={[component, "students"]} defaultValue={component?.state?.info?.for_students}
                                    multiple={true} required="true" key={"student"+studentSelection?.length+Math.random()} >
                                        {studentSelection?.map((student, index)=>{
                                                return(
                                                    <option key={index} value={student?.id}> {student?.firstname+" "+student?.lastname+" - "+student?.studentID} </option>
                                                );
                                            })
                                        }
                                    </SelectTail>
                                :""
                                }
                            </div>
                        </div>
                        <div className="col-span-12 lg:col-span-4">
                            <div className="intro-y box p-5">
                                <DatePicker label="start_date" refItem={[component, "start_date"]} required="true" />
                                <DatePicker label="response_deadline" refItem={[component, "expire_date"]} required="true" className="mt-1" />
                                <Input className="mt-1" required="true" label="score" refItem={[component, "score"]} />
                                <Input className="mt-1"  refItem={[component, "order"]} />
                                <Select className="col-span-6" label="session" refItem={[component, "session"]} data={sessions} titleKey="id" titleValue="id" />
                                <div className="lg:grid grid-cols-12 gap-5">
                                <CheckBox className="lg:col-span-8 mt-3" label="access_to_students" name={Lang('public.view_score_answers')} refItem={[component, "to_students"]} value={0} defaultValue={component?.state?.info?.to_students} />
                                <CheckBox className="lg:col-span-4 mt-3" label="status" name={Lang('public.active')} refItem={[component, "status_id"]} value={0} defaultValue={component?.state?.info?.status_id} />
                                </div>
                            </div>
                            <div className="intro-y box p-5 mt-3">
                                <Dropzone label={Lang("public.file")} refItem={[component, "files"]} uploadUrl={uploadUrl} deleteUrl={deleteUrl+"/"} />
                            </div>
                        </div>
                    </div>
                </Frame>
                <ButtonContainer>
                    <Button label="save" onClick={saveItem} />
                    <Button label="back" onClick={back} />
                </ButtonContainer>
            </>
        
    );
}
