"use client";
import { useConfig } from "@/lib/config";
import { Form } from "@/Components/Quiz/Form"

export default function Edit({params}){
    const {laraAdmin } = useConfig();

    return(
        <div>
            <Form  id={params.toolsId} course={params.id} laraPath={laraAdmin} />
        </div>
    );
}
