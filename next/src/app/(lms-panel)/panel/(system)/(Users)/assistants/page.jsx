"use client";
import List from '@/app/(lms-panel)/panel/(system)/(Users)/users/page';

export default function Assistants(){
    return(
        <div>
            <List title="assistants" link="/assistants" displayRole={false} view={true}></List>
        </div>
    );
}