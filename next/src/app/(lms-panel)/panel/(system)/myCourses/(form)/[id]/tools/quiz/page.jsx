"use client";
import { useConfig } from "@/lib/config";
import { Page } from "@/Components/Quiz/Page"
import { useAuth } from "@/lib/auth";
import { usePathname } from "next/navigation";

export default function List({params}){
    const {laraAdmin ,nextAdmin } = useConfig();
    const { user } = useAuth({ guard: "admin" });
    const access = user?.role_id == 1;
    const isAdmin = ![1, 2, 3].includes(user?.role_id);
    const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'courses';

    const formUrl = nextAdmin + "/"+menuPath+"/" + params.id + "/tools/quiz";

    return <Page course={params.id} formUrl={formUrl} laraPath={laraAdmin} nextPath={nextAdmin} access={access} isAdmin={isAdmin} />
}