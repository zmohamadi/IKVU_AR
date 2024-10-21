"use client";

import { useEffect, useState } from "react";
import { useLang } from "@/lib/lang";
import { usePathname, useRouter } from 'next/navigation';
import { useData, useFormRefs, Input, Button, ButtonContainer, Textarea, Box, Frame, CheckBox, DatePicker, Line } from "@/Theme/Midone/Forms";
import { Repeat, FeatherIcon, Tools } from "@/Theme/Midone/Utils";
import { YearGroup } from "@/Components/Public/YearGroup";
import { Question } from "./Question";

export function Form({ laraPath, id, course, nextPath = "" }) {
    const { Lang } = useLang();
    const component = useFormRefs();
    const router = useRouter();
    const { save, get, getNeedles } = useData();
    const [needles, setNeedles] = useState();
    const formUrl = `${laraPath}/survey`;
    const url = id ? `${formUrl}/${id}` : formUrl;
    const method = id ? "edit" : "new";
    const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'courses';

    useEffect(() => {
        getNeedles(`${formUrl}/get-needles`, setNeedles);
        if (id) get(url, component, "info");
    }, []);

    const saveItem = () => {
        const saveUrl = `${nextPath}/${menuPath}/${course}/tools/survey`;
        save(url, component, method, saveUrl);
    };
    const back = () => router.back();

    const otherProps = component?.state?.info?.questions?.length ? { count_data: component.state.info.questions.length } : {};

    const scrollPage = (toBottom = true) => {
        const position = toBottom ? document.body.scrollHeight : 250;
        typeof window !== "undefined" && window?.$('html,body').animate({ scrollTop: position }, "slow");
    };

    return (
        <>
            <Frame title={Lang(["public.survey"])}>
                <div className="col-span-12 pos intro-y grid grid-cols-12 gap-5 mt-5">
                    <div className="intro-y col-span-12 lg:col-span-8">
                        <Input className="col-span-12" refItem={[component, "title"]} required="true" />
                        <Input type="hidden" defaultValue={course} refItem={[component, "course_id"]} />
                        <div className="post intro-y p-3 box mt-5 ">
                            <Textarea row="12" className="col-span-12" refItem={[component, "description"]} />
                        </div>
                    </div>
                    <div className="col-span-12 lg:col-span-4">
                        <div className="intro-y box p-5">
                            <YearGroup component={component} needles={needles}  />
                            <DatePicker label="start_date" refItem={[component, "start_date"]} required="true" />
                            <DatePicker label="response_deadline" refItem={[component, "expire_date"]} required="true" />
                            <CheckBox label="status" name={Lang('public.active')} refItem={[component, "status_id"]}
                                value={0} defaultValue={component?.state?.info?.status_id}
                            />
                        </div>
                    </div>
                </div>
                <FeatherIcon spanWrapperClass="text-left" name="ArrowDownCircle" onClick={() => Tools?.scrollPage(true,"")} />
                <Repeat {...otherProps} child={Question} parent={component} needles={needles?.questiontype} />
                <FeatherIcon name="ArrowUpCircle" onClick={() => Tools?.scrollPage(false,"")} />
                <ButtonContainer className="col-span-12">
                    <Button label="save" onClick={saveItem} />
                    <Button label="back" onClick={back} />
                </ButtonContainer>
            </Frame>
        </>
    );
}
