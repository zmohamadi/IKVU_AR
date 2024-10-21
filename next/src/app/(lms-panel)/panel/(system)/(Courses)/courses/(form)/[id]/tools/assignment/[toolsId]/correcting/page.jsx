"use client";

import { useConfig } from "@/lib/config";
import { Page } from "@/Components/Assignment/Correcting/Page"

export default function List({params}){
    const {laraAdmin , nextAdmin } = useConfig();

    return <Page course={params.id} toolsId={params.toolsId} nextPath={nextAdmin} laraPath={laraAdmin} access={true} />
}