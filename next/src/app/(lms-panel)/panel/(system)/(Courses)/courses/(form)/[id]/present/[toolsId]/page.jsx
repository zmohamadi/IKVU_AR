"use client";
import { View } from "@/Components/Class/View"
import { useAuth } from "@/lib/auth";
import { useConfig } from "@/lib/config";

export default function ViewPage({params}){
    const {laraAdmin } = useConfig();
    const { user } = useAuth({ guard: "admin" });
    const isAdmin = ![1, 2, 3].includes(user?.role_id);

    return(
        <div>
            <View isAdmin={isAdmin}  id={params.toolsId} course={params.id} laraPath={laraAdmin} />
        </div>
    );
}