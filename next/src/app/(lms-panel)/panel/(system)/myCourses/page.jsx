"use client";
import { useConfig } from "@/lib/config";
import { PageProfile } from "@/Components/Courses/PageProfile"

export default function List(){
    const {laraAdmin ,nextAdmin } = useConfig();

    return <PageProfile laraPath={laraAdmin} nextPath={nextAdmin} access={true} />
}