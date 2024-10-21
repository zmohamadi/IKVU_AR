"use client";
import { useConfig } from "@/lib/config";
import { Form } from "@/Components/Forum/Form";

export default function New({params}){
    const { laraAdmin } = useConfig();

    return(
        <div>
            <Form course={params.id} laraPath={laraAdmin} />
        </div>
    );
}
