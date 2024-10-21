"use client";
import { useConfig } from "@/lib/config";
import { Reply } from "@/Components/Survey/Reply"

export default function Edit({params}){
    const {laraAdmin} = useConfig();

    return(
        <div>
            <Reply id={params.toolsId} course={params.id} laraPath={laraAdmin} />
        </div>
    );
}
