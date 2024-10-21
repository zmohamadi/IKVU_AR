"use client";
import { Form } from "@/Components/Courses/Form"
import { useConfig } from "@/lib/config";

export default function New(){
    const {laraAdmin } = useConfig();

    return(
        <div>
            <Form laraPath={laraAdmin}></Form>
        </div>
    );
}