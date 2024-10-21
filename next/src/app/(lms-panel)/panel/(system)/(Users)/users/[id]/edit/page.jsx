"use client";
import Form from '@/app/(lms-panel)/panel/(system)/(Users)/users/form';

export default function Edit({params}){
    return(
        <div>
            <Form id={params.id} titleFrame="users"></Form>
        </div>
    );
}