"use client";
import { View } from "@/Components/Survey/View"
import { useConfig } from "@/lib/config";

export default function ViewInfo({params}){
    const {laraAdmin } = useConfig();

    return(
        <div>
            <View id={params.toolsId} course={params.id} laraPath={laraAdmin} />
        </div>
    );
}
