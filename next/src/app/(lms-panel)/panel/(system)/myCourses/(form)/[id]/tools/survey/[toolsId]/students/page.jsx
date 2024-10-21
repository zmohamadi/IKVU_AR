"use client";
import { Students } from "@/Components/Survey/Report/Students"
import { useConfig } from "@/lib/config";

export default function ListStudents({params}){
    const {laraAdmin } = useConfig();

    return(
        <div>
            <Students id={params.toolsId} displayRole={true} />
        </div>
    );
}
