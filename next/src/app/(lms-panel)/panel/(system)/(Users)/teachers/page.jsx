"use client";
import List from '@/app/(lms-panel)/panel/(system)/(Users)/users/page';

export default function Teachers(){
    return(
        <div>
            <List title="teachers" link="/teachers" displayRole={false} view={true} resume={true}></List>
        </div>
    );
}