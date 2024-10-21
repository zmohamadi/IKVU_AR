"use client";
import { useConfig } from "@/lib/config";
import { Page } from "@/Components/OnlineArchives/Page"
import { useAuth } from "@/lib/auth";

export default function List({params}){
    const {laraAdmin ,nextAdmin } = useConfig();
    const { user } = useAuth({ guard: "admin" });
    const access = user?.role_id == 1;

    return <Page course={params.id} laraPath={laraAdmin} nextPath={nextAdmin} access={access} />
}