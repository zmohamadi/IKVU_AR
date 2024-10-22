"use client";

import Form from '@/app/(lms-panel)/panel/(system)/(Users)/users/form';

export default function EditTeacher({params,id}){
    let userId = params? params?.id : id;

    return(
        <div>
            <Form id={userId} link="/teachers" roleFilter="1" roleTitle="teacher" titleFrame="teachers"></Form>
        </div>
    );
}