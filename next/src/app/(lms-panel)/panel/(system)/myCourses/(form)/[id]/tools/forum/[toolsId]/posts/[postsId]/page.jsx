"use client";
import { useConfig } from "@/lib/config";
import { FormReply } from '@/Components/Forum/Reply/Form';

export default function Reply({ params }){
    const { laraAdmin,nextAdmin } = useConfig();

    return(
        <FormReply post={params.postsId} forum={params.toolsId} course={params.id} laraPath={laraAdmin} nextPath={nextAdmin} />
    );
}
