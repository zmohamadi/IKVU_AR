"use client";
import { useAuth } from "@/lib/auth";

import EditPersonnel from '@/app/(lms-panel)/panel/(system)/(Users)/personnels/(form)/[id]/edit/page';
import EditTeacher from '@/app/(lms-panel)/panel/(system)/(Users)/teachers/(form)/[id]/edit/page';
import EditStudent from '@/app/(lms-panel)/panel/(system)/(Users)/students/(form)/[id]/edit/page';
import EditAssistant from '@/app/(lms-panel)/panel/(system)/(Users)/assistants/(form)/[id]/edit/page';

export default function EditProfile(){
    const {user} = useAuth({guard: "admin"});
    const id = user?.id;
    const role = user?.role_id;

    let display = <EditPersonnel id={id} />
    if(role == 1)
        display = <EditTeacher id={id} />
    else if(role == 2)
        display = <EditStudent id={id} />
    else if(role == 3)
        display = <EditAssistant id={id} />

    return(
        <div>{display}</div>
    );
}