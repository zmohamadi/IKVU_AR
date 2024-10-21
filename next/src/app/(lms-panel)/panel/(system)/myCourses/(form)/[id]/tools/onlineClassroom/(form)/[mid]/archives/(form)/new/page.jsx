"use client";
import { Form } from "@/Components/OnlineClassroom/Archives/Form"
import { useConfig } from "@/lib/config";

export default function Edit({params}){
    const {laraAdmin } = useConfig();
    const toolsId = params?.mid;
    const course =  params?.id;
    return(
        <div>
            <Form toolsId={toolsId} course={course} laraPath={laraAdmin} />
        </div>
    );
}
