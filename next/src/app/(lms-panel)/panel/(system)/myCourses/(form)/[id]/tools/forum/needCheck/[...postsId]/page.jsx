"use client";
import { useConfig } from "@/lib/config";
import { View } from '@/Components/Forum/NeedCheck/View';

export default function ViewPost({ params }){
    const { laraAdmin,nextAdmin } = useConfig();

    return(
        <View parent={params.postsId[0]} post={params.postsId[1]} course={params.id} laraPath={laraAdmin} nextPath={nextAdmin} access={true} />
    );
}
