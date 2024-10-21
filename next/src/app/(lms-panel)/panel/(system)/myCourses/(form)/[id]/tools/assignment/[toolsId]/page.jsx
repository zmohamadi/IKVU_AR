"use client";
import { View } from "@/Components/Assignment/View"
import { useConfig } from "@/lib/config";

export default function ViewPage({params}){
    const {laraAdmin } = useConfig();

    return(
        <div>
            <View  id={params.toolsId} course={params.id} laraPath={laraAdmin} />
        </div>
    );
}
