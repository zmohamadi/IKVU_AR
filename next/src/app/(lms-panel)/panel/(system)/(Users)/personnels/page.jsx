"use client";
import List from '@/app/(lms-panel)/panel/(system)/(Users)/users/page';

export default function Personnels(){
    return(
        <div>
            <List title="personnels" link="/personnels" displayRole={true} view={true}></List>
        </div>
    );
}