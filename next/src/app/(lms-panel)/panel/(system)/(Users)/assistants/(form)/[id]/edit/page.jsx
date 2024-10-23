"use client";

import Form from '@/app/(lms-panel)/panel/(system)/(Users)/users/form';

export default function EditAssistant({params,id}){
    let userId = params? params?.id : id;

    return(
        <div>
            <Form id={userId} link="/assistants" roleFilter="3" roleTitle="assistant" titleFrame="assistants"></Form>
        </div>
    );
}