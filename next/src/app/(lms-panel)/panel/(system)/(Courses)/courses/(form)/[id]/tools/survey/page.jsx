"use client";
import { useConfig } from "@/lib/config";
import { useAuth } from "@/lib/auth";
import { Page } from "@/Components/Survey/Page";

export default function List({params}){
    const {laraAdmin ,nextAdmin } = useConfig();
    const { user } = useAuth({ guard: "admin" });
    const access = user?.role_id !== 2;
    const isAdmin = ![1, 2, 3].includes(user?.role_id);

    return <Page course={params.id} laraPath={laraAdmin} nextPath={nextAdmin} access={access} isAdmin={isAdmin} />
}