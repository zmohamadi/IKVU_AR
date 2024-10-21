"use client";
import { Reply } from "@/Components/Assignment/Reply"
// import { Reply } from "@/Components/Assignment/ReplyMultiPage"
import { useConfig } from "@/lib/config";

export default function Page({params}){
    const {laraAdmin } = useConfig();

    return(
        <div>
            <Reply id={params.toolsId} course={params.id} laraPath={laraAdmin} />
        </div>
    );
}
