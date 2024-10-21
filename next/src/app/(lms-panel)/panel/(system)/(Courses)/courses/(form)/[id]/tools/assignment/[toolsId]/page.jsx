"use client";

import { useConfig } from "@/lib/config";
import { View } from "@/Components/Assignment/View"

export default function Page({params}){
    const {laraAdmin } = useConfig();

    return(
        <div>
            <View id={params.toolsId} course={params.id} laraPath={laraAdmin} />
        </div>
    );
}
