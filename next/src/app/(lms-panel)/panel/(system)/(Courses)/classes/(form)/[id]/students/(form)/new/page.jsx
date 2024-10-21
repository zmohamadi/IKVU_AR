"use client";
import { NewStudents } from "@/Components/Class/NewStudents"

export default function page({params}){

    return(
        <div>
            <NewStudents  params={params}/>
        </div>
    );
}
