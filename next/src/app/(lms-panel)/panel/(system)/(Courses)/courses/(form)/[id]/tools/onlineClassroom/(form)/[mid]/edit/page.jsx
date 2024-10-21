"use client";
import { Form } from "@/Components/OnlineClassroom/Form"
import { useConfig } from "@/lib/config";

export default function Edit({params}){
    const {laraAdmin,nextAdmin } = useConfig();

    return(
        <div>
            <Form id={params.mid} course={params.id} laraPath={laraAdmin} />
        </div>
    );
}
