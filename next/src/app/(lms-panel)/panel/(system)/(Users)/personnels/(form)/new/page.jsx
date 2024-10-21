"use client";
import Form from '@/app/(lms-panel)/panel/(system)/(Users)/users/form';

export default function New(){
    return(
        <div>
            <Form titleFrame="personnels" link="/personnels" roleFilter="0"></Form>
        </div>
    );
}