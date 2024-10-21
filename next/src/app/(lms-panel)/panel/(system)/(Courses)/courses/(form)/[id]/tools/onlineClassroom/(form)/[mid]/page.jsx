"use client";
import { View } from "@/Components/OnlineClassroom/View"
import { useConfig } from "@/lib/config";

export default function Edit({params}){
    const {laraAdmin } = useConfig();

    return(
        <div>
            <View id={params.mid} course={params.id} laraPath={laraAdmin} />
        </div>
    );
}
