"use client";
import List from '@/app/(lms-panel)/panel/(system)/(Users)/users/page';

export default function Students(){
    return(
        <div>
            <List title="students" link="/students" displayRole={false} view={true}></List>
        </div>
    );
}