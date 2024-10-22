"use client";

import Form from '@/app/(lms-panel)/panel/(system)/(Users)/users/form';

export default function EditStudent({params,id}){
    let userId = params? params?.id : id;

    return(
        <div>
            <Form id={userId} link="/students" roleFilter="2" roleTitle="student" titleFrame="students" ></Form>
        </div>
    );
}