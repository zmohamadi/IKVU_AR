"use client";
import { useConfig } from "@/lib/config";
import { Page } from "@/Components/OnlineClassroom/Page"
import { useAuth } from "@/lib/auth";

export default function List({params}){
    const {laraAdmin ,nextAdmin } = useConfig();
    const { user } = useAuth({ guard: "admin" });
    const access = user?.role_id == 1;
    // console.log(access);

    const isAdmin = ![1, 2, 3].includes(user?.role_id);
    const formUrl = nextAdmin + "/courses/" + params.id + "/tools/onlineClassroom";

    return <Page course={params.id} formUrl={formUrl} laraPath={laraAdmin} nextPath={nextAdmin} access={access} isAdmin={isAdmin} />
}