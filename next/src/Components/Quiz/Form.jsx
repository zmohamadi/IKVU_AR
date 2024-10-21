"use client";
import { useEffect, useState } from "react";
import { useLang } from "@/lib/lang";
import { usePathname, useRouter } from 'next/navigation';
import { useData, useFormRefs, SelectTail, Input, Button, ButtonContainer, Frame, Box, CheckBox, TimePicker, DatePicker } from "@/Theme/Midone/Forms";
import { CKEditor } from "@/Theme/Midone/Forms/Ckeditor";
import { Repeat } from "@/Theme/Midone/Utils/Repeat";
import {Question} from "../Public/Question/Question";
import { YearGroup } from "../Public/YearGroup";

export function Form({ laraPath, id, course, nextPath="" }) {
        const { Lang } = useLang();
        const component = useFormRefs();
        const router = useRouter();
        let { save, get, getNeedles } = useData();
        let [needles, setNeedles] = useState();
        let formUrl = "/quiz";
        let url = laraPath+formUrl, method = "new";
        if (id != 0 && id != undefined) url = laraPath+formUrl + "/" + id, method = "edit";
        // console.log("course is:", course);
        const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'courses';


        useEffect(() => {
                getNeedles(laraPath+formUrl + '/get-needles', setNeedles);
                if (id != 0 && id != undefined) get(url, component, "info");
        }, []);


        const saveItem = () => save(url, component, method, nextPath+"/"+menuPath+"/"+course+"/tools/quiz"+"?"+Math.random());
        const back = () => router.back();

        return <>
                <Frame title={Lang(["public.quiz"])}>
                        <Box shadow="false">
                                <Input type="hidden" defaultValue={course} refItem={[component, "course_id"]} />
                                <Input label="title" className="col-span-12" refItem={[component, "title"]} required="true" />
                                <CKEditor label="description" refItem={[component, "description"]} />
                                <YearGroup component={component} needles={needles}  />
                                <DatePicker label="start_date" refItem={[component, "start_date"]} required="true" />
                                <Input type="time" label="start_time" refItem={[component,"start_time"]} required="true" />
                                <DatePicker label="end_date" refItem={[component, "end_date"]} required="true" />
                                <Input type="time" label="end_time" refItem={[component,"end_time"]} required="true" />
                                <Input label="limit_time" refItem={[component, "limit_time"]} />
                                <CheckBox className="col-span-6" label="one_page" name={Lang('public.one_page')} refItem={[component, "one_page"]} />
                                <CheckBox className="col-span-6" label="status" name={Lang('public.active')} refItem={[component, "status_id"]} defaultValue="1" />
                        </Box>
                        <Repeat count_data={component?.state?.info? component?.state?.info?.questions?.length : 1} child={Question} parent={component} needles={needles?.questiontype} />
                </Frame>
                <ButtonContainer>
                        <Button label="save" onClick={saveItem} />
                        <Button label="back" onClick={back} />
                </ButtonContainer>
        </>;
}