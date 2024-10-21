"use client";
import { useConfig } from "@/lib/config";
import { Form } from "@/Components/Forum/Form";

export default function Edit({params}){
    const { laraAdmin } = useConfig();

    return(
        <div>
            <Form id={params.toolsId} course={params.id} laraPath={laraAdmin} />
        </div>
    );
}
