"use client";
import { View } from "@/Components/Courses/View"
import { useConfig } from "@/lib/config";
import { useAuth } from "@/lib/auth";

export default function Edit({params}){
    const {laraAdmin } = useConfig();
    const { user } = useAuth({ guard: "admin" });
    const access = user?.role_id !== 2;
    const isAdmin = ![1, 2, 3].includes(user?.role_id);

    return(
        <div>
            <View laraPath={laraAdmin} id={params.id} access={access} isAdmin={isAdmin} />
        </div>
    );
}