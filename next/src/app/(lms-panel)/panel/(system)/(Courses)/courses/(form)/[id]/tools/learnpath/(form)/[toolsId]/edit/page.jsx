"use client";
import { Form } from "@/Components/LearnPath/Form"
import { useConfig } from "@/lib/config";

export default function Edit({params}){
    const {laraAdmin } = useConfig();

    return(
        <div>
            <Form id={params.toolsId} course={params.id} laraPath={laraAdmin} />
        </div>
    );
}
