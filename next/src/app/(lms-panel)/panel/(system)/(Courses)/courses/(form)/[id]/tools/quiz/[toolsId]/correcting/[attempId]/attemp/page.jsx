"use client";
import { useConfig } from "@/lib/config";
import { UserPage } from "@/Components/Quiz/Correcting/UserPage"

export default function List({params}){
    const {laraAdmin } = useConfig();
// console.log(params.attempId);
    return <UserPage  course={params.id} attemp={params.attempId} toolsId={params.toolsId} laraPath={laraAdmin} access={true} />
}