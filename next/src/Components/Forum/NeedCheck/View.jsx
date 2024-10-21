"use client";
import { useLang } from "@/lib/lang";
import { useEffect,useState } from "react";
import { useData,Frame } from "@/Theme/Midone/Utils";
import { List } from '@/Components/Forum/Reply/List';

export function View({ course,parent,post,laraPath }){
    const {Lang} = useLang();
    const { getNeedles } = useData();
    const [status, setStatus] = useState();
    useEffect(() => {
        getNeedles(laraPath+"/posts-status", setStatus);
    }, []);

    return(
        <Frame title={Lang(["public.forum"])}>
            <List parent={parent} post={post} course={course} laraPath={laraPath} status={status} displayIcon={false}/>
        </Frame>
    );
}
