"use client";
import { useConfig } from "@/lib/config";
import { Form } from "@/Components/Survey/Form";

export default function Edit({params}){
    const { laraAdmin } = useConfig();

    return(
        <div>
            <Form course={params.id} laraPath={laraAdmin} />
        </div>
    );
}
