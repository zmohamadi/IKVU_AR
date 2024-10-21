"use client";
import Form from '@/app/(lms-panel)/panel/(system)/(Users)/users/form';

export default function New(){
    return(
        <div>
            <Form link="/teachers" roleFilter="1" titleFrame="teachers"></Form>
        </div>
    );
}