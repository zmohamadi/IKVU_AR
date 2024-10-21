"use client";
import { useEffect, useState } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useData,useFormRefs,Input,Button,ButtonContainer,Box,CheckBox, SelectTail, Frame } from "@/Theme/Midone/Forms";
import { useRouter } from 'next/navigation';
import { Tools } from "@/Theme/Midone";
import { YearGroup } from "@/Components/Public/YearGroup";

export function Form({laraPath,course,id}){
    const {Lang, local} = useLang();
    const router = useRouter();
    let component = useFormRefs();
    let {save, get, getNeedles} = useData();
    let [needles, setNeedles] = useState();
    const formUrl = "/present" ; 
    let url = laraPath+formUrl, key = 0;
    let method = "save";
    // console.log(id);
    
    if(id != undefined) url = laraPath+formUrl+"/"+id, method = "edit";

    // console.log(method);

    useEffect(() => {
        getNeedles(laraPath+'/present/get-needles', setNeedles);
        get(url, component, "info");
    }, []);

    const saveItem = ()=>save(url, component, method, `/courses/${course}/present`);
    const back = ()=>router.back(); 

    return <>
            <Frame>
                <Box>
                    <Input type="hidden" refItem={[component, "code"]} defaultValue={course} />

                    <SelectTail  required="true" label="teacher" refItem={[component, "teacher_person_id"]}>
                        {Tools.getArray(needles?.teacher).map((teacher, index)=>
                                <option key={index} value={teacher.id}> {teacher.firstname} {teacher.lastname} </option>
                        )}
                    </SelectTail>
                    <SelectTail multiple={true}  label="assistant"
                        refItem={[component, "assistants"]} defaultValue={component?.state?.info?.user_assistants}
                    >
                        {Tools.getArray(needles?.assistant).map((assistant, index)=>
                                <option key={index} value={assistant.id}> {assistant.firstname} {assistant.lastname} </option>
                        )}
                    </SelectTail>
                
                    <YearGroup component={component} needles={needles} showSemester={true} />
                </Box>
            </Frame>
            <ButtonContainer>
                <Button label="save" onClick={saveItem} />
                <Button label="back" onClick={back} />
            </ButtonContainer>
        </>;
}