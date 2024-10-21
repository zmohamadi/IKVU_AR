"use client";
import { useConfig } from "@/lib/config";
import { List } from "@/Components/Forum/Post/List";

export default function ListPost({params}){
    const { laraAdmin,nextAdmin } = useConfig();

    return(
        <div>
            <List forum={params.toolsId} course={params.id} nextPath={nextAdmin} laraPath={laraAdmin} access={true} />
        </div>
    );
}
