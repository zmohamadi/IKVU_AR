"use client";
import { useConfig } from "@/lib/config";
import { useLang } from "@/lib/lang";
import { useData, useFormRefs, Input, Button, ButtonContainer, Frame, Box } from "@/Theme/Midone/Forms";
import { useRouter } from 'next/navigation';
import { Dropzone } from "@/Theme/Midone/Forms/Dropzone";

export default function Page({ params }) {
    const course = params?.id || ''; // Safeguard against undefined params
    const { Lang } = useLang();
    const { laraAdmin, nextAdmin } = useConfig();
    const router = useRouter();
    let component = useFormRefs();
    const { save } = useData();

    let uploadUrl = laraAdmin + "/upload/.-media-onlineclass";
    let deleteUrl = laraAdmin + "/deleteFile/.-media-onlineclass";
    let uploadDir = 'media/onlineclass/';

    const saveItem = () => save(
        laraAdmin + "/onlineClassroom/excel",
        component,
        "new",
        nextAdmin + "/courses/" + course + "/tools/onlineClassroom?cacheBuster=" + Math.random()
    );
    const back = () => router.back();

    return (
        <>
            <Frame title={Lang(["public.onlineClassroom"])}>
                <Box>
                    <Input type="hidden" defaultValue={course} refItem={[component, "course"]} />
                    <Dropzone 
                        required={true} 
                        refItem={[component, "excel_file"]} 
                        uploadUrl={uploadUrl} 
                        deleteUrl={deleteUrl + "/"} 
                        uploadDir={uploadDir} 
                    />
                </Box>
            </Frame>
            <ButtonContainer>
                <Button label="save" onClick={saveItem} />
                <Button label="back" onClick={back} />
            </ButtonContainer>   
        </>
    );
}
