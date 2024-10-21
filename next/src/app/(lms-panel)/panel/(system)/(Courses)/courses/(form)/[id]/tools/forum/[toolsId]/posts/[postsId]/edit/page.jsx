"use client";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { Frame } from "@/Theme/Midone/Utils";
import { Form } from "@/Components/Forum/Post/Form";

export default function Edit({params}){
    const {Lang} = useLang();
    const { laraAdmin } = useConfig();

    return(
        <Frame title={Lang(["public.dialog"])}>
            <Form post={params.postsId} forum={params.toolsId} course={params.id} laraPath={laraAdmin} />
        </Frame>
    );
}
