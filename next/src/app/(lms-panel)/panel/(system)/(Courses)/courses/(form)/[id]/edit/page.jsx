"use client";
import { Form } from "@/Components/Courses/Form"
import { useConfig } from "@/lib/config";

export default function Edit({params}){
    const {laraAdmin } = useConfig();

    return(
        <div>
            <Form laraPath={laraAdmin} id={params.id}></Form>
        </div>
    );
}