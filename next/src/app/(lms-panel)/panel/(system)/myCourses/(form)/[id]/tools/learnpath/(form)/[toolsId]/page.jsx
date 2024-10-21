"use client";
import { View } from "@/Components/LearnPath/View"
import { useConfig } from "@/lib/config";

export default function Edit({params}){
    const {laraAdmin, mediaPath } = useConfig();

    return(
        <div>
            <View id={params.toolsId} course={params.id} laraPath={laraAdmin} mediaPath={mediaPath} />
        </div>
    );
}
