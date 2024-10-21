"use client";
import { View } from "@/Components/Courses/View"
import { useConfig } from "@/lib/config";

export default function Edit({params}){
    const {laraAdmin } = useConfig();

    return(
        <div>
            <View laraPath={laraAdmin} id={params.id} />
        </div>
    );
}