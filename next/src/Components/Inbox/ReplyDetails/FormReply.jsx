"use client";

import { useRouter } from 'next/navigation';
import { useData, useFormRefs, ButtonContainer, Button, Textarea, Box } from "@/Theme/Midone/Forms";
import { useLang } from '@/lib';

export function FormReply({ id, course, laraPath, nextPath = "",data }) {
    let component = useFormRefs();
    let { save } = useData();
    const { Lang } = useLang();

    const router = useRouter();
    let url = `${laraPath}/inbox/reply/${id}`;

    const saveItem = () => save(url, component, "edit", `${nextPath}/courses/${course}/tools/inbox`);
    const back = () => router.back();

    return (
        <>
            <Box cols="grid-cols-1">
                <li><strong>{Lang("public.message")} :</strong>{data?.text}</li>

                <Textarea defaultValue={data?.reply} required={true}  label={Lang("public.your_answer")} className="col-span-12" refItem={[component, "reply"]} />
            </Box>
            <ButtonContainer>
                <Button label="save" onClick={saveItem} />
                <Button label="back" onClick={back} />
            </ButtonContainer>
        </>
    );
}
