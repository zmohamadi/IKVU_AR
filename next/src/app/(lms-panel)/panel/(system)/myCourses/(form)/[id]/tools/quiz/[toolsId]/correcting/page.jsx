"use client";
import { useConfig } from "@/lib/config";
import { Page } from "@/Components/Quiz/Correcting/Page"

export default function List({params}){
    const {laraAdmin ,nextAdmin } = useConfig();

    return <Page course={params.id} toolsId={params.toolsId} laraPath={laraAdmin} nextPath={nextAdmin} access={true} />
}