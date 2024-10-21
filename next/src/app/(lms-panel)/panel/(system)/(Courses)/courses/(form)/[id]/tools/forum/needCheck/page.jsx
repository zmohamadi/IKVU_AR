"use client";
import { useConfig } from "@/lib/config";
import { List } from '@/Components/Forum/NeedCheck/List';

export default function ListPost({params}){
    const { laraAdmin,nextAdmin } = useConfig();

    return(
        <div>
            <List course={params.id} laraPath={laraAdmin} nextPath={nextAdmin} access={true} />
        </div>
    );
}
