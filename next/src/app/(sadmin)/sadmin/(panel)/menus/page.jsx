
"use client"

import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { Grid, Frame, FeatherIcon, useData } from "@/Theme/Midone";
import {MenuItem} from "./MenuItem";

const MenuList = () => {
    const {Lang} = useLang();
    const {laraSAdmin, nextSAdmin} = useConfig();
    const {destroy} = useData();

    let info = {
        insertLink: nextSAdmin+"/systems/new",
        url: laraSAdmin+"/systems",
        theme: (item)=> <MenuItem item={item} />
    }

    return(
        <Frame title={Lang(["public.subjects"])}>
            <div className="intro-y col-span-12">
                <Grid {...info} key={"table key"} />
            </div>
        </Frame>
    );
}

export default MenuList;