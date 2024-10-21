"use client";
import { View } from "@/Components/Quiz/View"
import { useConfig } from "@/lib/config";
import { useAuth } from "@/lib/auth";

export default function ViewPage({params}){
    const {laraAdmin } = useConfig();
    const { user } = useAuth({ guard: "admin" });
    const access = user?.role_id !== 2;
    return(
        <div>
            <View  id={params.toolsId} course={params.id} laraPath={laraAdmin}  access={access} />
        </div>
    );
}
