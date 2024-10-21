"use client";
import { useEffect, useState } from "react";
import { useLang } from "@/lib/lang";
import { useData,useFormRefs,Input,Button,ButtonContainer,CheckBox, Frame, Box, DatePicker, TimePicker } from "@/Theme/Midone/Forms";
import { usePathname, useRouter } from 'next/navigation';
import { YearGroup } from "../Public/YearGroup";

export function Form({laraPath,course,id,nextPath=""}){
    
    const {Lang} = useLang();
    const router = useRouter();
    let component = useFormRefs();
    const { save, get, getNeedles } = useData();
    const [needles, setNeedles] = useState();
    let formUrl = laraPath+"/onlineClassrooms" ; 
    let url = formUrl, method = "new", key = 0;
    if(id != 0 && id != undefined) url = formUrl+"/"+id, method = "edit";
    const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'courses';

    useEffect(() => {
        const fetchData = async () => {
            await getNeedles(`${laraPath}/onlineClassrooms/get-needles`, setNeedles);
            if (id) {
                await get(url, component, "info");
            }
        };
        fetchData();
    }, [id, laraPath, url]);

    const saveItem = ()=>save(url, component, method, nextPath+"/"+menuPath+"/"+course+"/tools/onlineClassroom"+"?"+Math.random());
    const back = ()=>router.back();

    return <>
        <Frame title={Lang(["public.onlineClassroom"])}>
            <Box>     
                <Input type="hidden" defaultValue={course} refItem={[component, "course_id"]} />
                <Input required="true"  refItem={[component, "title"]} />
                <DatePicker  refItem={[component,"date"]} required="true" />
                <YearGroup component={component} needles={needles}  />
                <Input className="col-span-4" required="true" placeholder="10:10"  refItem={[component, "start_hour"]} />
                <Input className="col-span-4" required="true" placeholder="30" label="duration(min)" refItem={[component, "duration"]} />
                <Input  className="col-span-4" refItem={[component, "order"]} />
                {/* <CheckBox defaultValue={component?.state?.info?.status_id} label="status" name={Lang('public.active')} refItem={[component, "status_id"]} value={0} />         */}
            </Box>
        </Frame>
        <ButtonContainer>
            <Button label="save" onClick={saveItem} />
            <Button label="back" onClick={back} />
        </ButtonContainer>   
    </>;
}