"use client";
import Form from '@/app/(lms-panel)/panel/(system)/(Users)/users/form';

export default function New(){
    return(
        <div>
            <Form link="/assistants" roleFilter="3" titleFrame="assistants"></Form>
        </div>
    );
}