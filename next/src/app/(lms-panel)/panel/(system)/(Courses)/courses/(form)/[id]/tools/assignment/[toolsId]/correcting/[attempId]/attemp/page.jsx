"use client";

import { useConfig } from "@/lib/config";
import { UserPage } from "@/Components/Assignment/Correcting/UserPage"

export default function List({params}){
    const {laraAdmin } = useConfig();

    return <UserPage course={params.id} attemp={params.attempId} toolsId={params.toolsId} laraPath={laraAdmin} />
}