"use client";

import { useConfig } from "@/lib/config";
import { Reply } from "@/Components/Assignment/Reply"

export default function Page({params}){
    const {laraAdmin } = useConfig();

    return(
        <div>
            <Reply id={params.toolsId} course={params.id} laraPath={laraAdmin} />
        </div>
    );
}
