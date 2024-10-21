"use client";
import { useLang } from "@/lib/lang";
import { Grid, Frame} from "@/Theme/Midone/Utils";
import {Items} from './Items'

export function PageProfile({laraPath, nextPath, access}){

    const {Lang} = useLang();
    const formUrl = "/courses/list?url=myCourses"; 

    let info = {
        url: laraPath+formUrl,
        theme: (item)=> <Items formUrl={formUrl}  access={access} item={item} laraPath={laraPath} nextPath={nextPath} />
    }

    return(
        <Frame title={Lang(["public.myCourses"])}>
            <div className="intro-y col-span-12">
                <Grid {...info} key={"table key"} />
            </div>
        </Frame>
    );
}