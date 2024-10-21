"use client";
import { useConfig } from "@/lib/config";
import { Page } from "@/Components/Courses/Page"

export default function List(){
    const {laraAdmin ,nextAdmin } = useConfig();

    return <Page laraPath={laraAdmin} nextPath={nextAdmin} access={true} />
}