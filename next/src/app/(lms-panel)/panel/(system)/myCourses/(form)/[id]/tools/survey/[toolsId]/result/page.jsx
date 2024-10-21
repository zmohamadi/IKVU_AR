"use client";
import { View } from "@/Components/Survey/View"
import { useConfig } from "@/lib/config";

export default function ViewResult({params}){
    const {laraAdmin } = useConfig();

    return(
        <div>
            <View id={params.toolsId} course={params.id} laraPath={laraAdmin} dispalyResult={true} dispalyComplete={true} />
        </div>
    );
}
