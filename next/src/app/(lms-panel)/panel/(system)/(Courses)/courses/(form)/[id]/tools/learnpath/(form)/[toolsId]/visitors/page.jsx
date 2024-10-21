"use client";
import { UserList } from "@/Components/Users/UserList"
import { useConfig } from "@/lib/config";

export default function page({params}){
    const {laraAdmin } = useConfig();
    const tools = params.toolsId;
    let url= laraAdmin+"/content-visited/"+tools;

    return(
        <div>
            <UserList url={url} access={true} />
        </div>
    );
}