"use client";
import { useConfig } from "@/lib/config";
import { useLang } from "@/lib/lang";
import { useData, useFormRefs, Input, Button, ButtonContainer, Frame, Box, SelectTail } from "@/Theme/Midone/Forms";
import { useRouter } from 'next/navigation';
import { Dropzone } from "@/Theme/Midone/Forms/Dropzone";
import { YearGroup } from "@/Components/Public/YearGroup";
import { useEffect, useState } from "react";

export default function Page({ params }) {
    const course = params?.id || ''; // Safeguard against undefined params
    const { Lang } = useLang();
    const { laraAdmin, nextAdmin } = useConfig();
    const router = useRouter();
    let component = useFormRefs();
    const { save ,getNeedles} = useData();
    const [needles, setNeedles] = useState();

    let uploadUrl = laraAdmin + "/upload/.-media-onlineclass";
    let deleteUrl = laraAdmin + "/deleteFile/.-media-onlineclass";
    let uploadDir = 'media/onlineclass/';
    useEffect(() => {
        const fetchData = async () => {
            await getNeedles(`${laraAdmin}/assignments/get-needles`, setNeedles);
           
        };
        fetchData();
    }, []);
    const saveItem = () => save(
        laraAdmin + "/onlineClassroom/excel",
        component,
        "new",
        "/onlineClasses"
    );
    const back = () => router.back();

    return (
        <>
            <Frame title={Lang(["public.onlineClassroom"])}>
                <Box>
                 {/* <SelectTail key={"system"+needles?.yearsemester?.length} required="true" label="year" refItem={[component, "year"]} data={needles?.yearsemester} titleKey={"year"} /> */}

                    <SelectTail className="col-span-6" label="year" refItem={[component, "year"]}
                        key={"year"+needles?.yearsemester?.length} required="true">
                        <>
                            <option key={1} value={0}>{Lang("public.year")}</option>

                                {
                                    (needles?.yearsemester)?.map((item, index)=>{
                                            return <option key={index} value={item?.year}>{item?.["year"]}</option>
                                    })
                                }
                        </>
                    </SelectTail>
                    <SelectTail className="col-span-6" label="semester" refItem={[component, "semester"]}
                        key={"semester_"+needles?.yearsemester?.length} required="true">
                        <>
                            <option key={1} value={0}>{Lang("public.semester")}</option>

                                {
                                    (needles?.yearsemester)?.map((item, index)=>{
                                            return <option key={index} value={item?.semester}>{item?.semester}</option>
                                    })
                                }
                        </>
                    </SelectTail>
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
