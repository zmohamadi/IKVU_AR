"use client";
import { Students } from "@/Components/Class/Students"

export default function page({params}){

    return(
        <div>
            <Students  params={params}/>
        </div>
    );
}
