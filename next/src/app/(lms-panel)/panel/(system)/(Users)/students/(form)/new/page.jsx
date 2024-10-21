"use client";
import Form from '@/app/(lms-panel)/panel/(system)/(Users)/users/form';

export default function New(){
    return(
        <div>
            <Form link="/students" roleFilter="2" titleFrame="students" ></Form>
        </div>
    );
}