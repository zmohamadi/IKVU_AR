"use client";
import { Form } from "@/Components/OnlineClassroom/Archives/Form"
import { useConfig } from "@/lib/config";

export default function Edit({params}){
    const {laraAdmin } = useConfig();
    const toolsId = params?.mid;
    const course =  params?.id;
    const fileId = params?.fileId;

    return(
        <div>
            <Form fileId={fileId} toolsId={toolsId} course={course} laraPath={laraAdmin} />
        </div>
    );
}
