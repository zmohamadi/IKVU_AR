"use client";
import { Reply } from "@/Components/Quiz/Reply"
// import { Reply } from "@/Components/Quiz/ReplyMultiPage"
import { useConfig } from "@/lib/config";

export default function page({params}){
    const {laraAdmin } = useConfig();

    return(
        <div>
            <Reply id={params.toolsId} course={params.id} laraPath={laraAdmin} />
        </div>
    );
}
