"use client";
import { useConfig } from "@/lib/config";
import { Page } from "@/Components/Inbox/Page"
// import { useAuth} from "@/Theme/Site/Components/Auth/auth";

export default function List({params}){
    const {laraAdmin ,nextAdmin } = useConfig();
    // const {user} = useAuth();
    // let access = (user?.role_id==2)?false:true;

    return <Page course={params.id} laraPath={laraAdmin} nextPath={nextAdmin} access={true} />
}