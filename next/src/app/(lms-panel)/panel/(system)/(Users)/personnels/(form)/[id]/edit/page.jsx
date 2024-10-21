"use client";

import Form from '@/app/(lms-panel)/panel/(system)/(Users)/users/form';

export default function EditPersonnel({params,id}){
    let userId = params? params?.id : id;

    return(
        <div>
            <Form titleFrame="personnels" id={userId} link="/personnels" roleFilter="0"></Form>
        </div>
    );
}