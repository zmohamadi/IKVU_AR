"use client";
import { Page } from "@/Components/LearnPath/Page";
import { useConfig } from "@/lib/config";

export default function List({params}){
    const {laraAdmin ,nextAdmin } = useConfig();

    return <Page course={params.id} laraPath={laraAdmin} nextPath={nextAdmin} />
}