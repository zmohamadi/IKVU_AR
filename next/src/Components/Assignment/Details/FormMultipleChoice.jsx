"use client";

import { useLang } from "@/lib/lang";
import { useData, useFormRefs, ButtonContainer, Button, Radio, Input } from "@/Theme/Midone/Forms";
import { Files } from "@/Components/Assignment/Details";

export function FormMultipleChoice({ id, course, laraPath, nextPath = "", data }) {
    const { Lang } = useLang();
    let { save } = useData();
    let component = useFormRefs();
    let url = `${laraPath}/assignment/reply/${id}`;
    let attachments = (data?.files)? data?.files?.split("###") : [];

    const saveItem = () => save(url, component, "edit", `${nextPath}/courses/${course}/tools/assignment`);

    return (
        <>
            <div className="post intro-y p-3 box">
                <Input type="hidden" defaultValue={course} refItem={[component, "course_id"]} />
                <ul>
                    <li>
                        <Radio required={true} label={data?.description} data={data?.options} refItem={[component, "response"]} />
                    </li>
                </ul>
                <Files data={attachments} Lang={Lang} path="/assignment/" colorIcon="facebook" />
                <ButtonContainer>
                    <Button label="save" onClick={saveItem} />
                </ButtonContainer>
            </div>
        </>
    );
}
