"use client";

import { useConfig} from "@/lib/config";
import { utility } from "@/lib/utility";
import { MobileMenu, TopBar, Menu, Wrapper } from "@/Theme/Midone/Base";
import { useEffect, useState } from "react";
// import { menus } from "../../sadminMenus";
import {menu} from "@/lib/menu-list";


export default function Panel({children}){
    window.document.body.style.padding = "15px 28px";
    const {adminMenuType, laraDomain} = useConfig();
    const [menuType, setMenuType] = useState(adminMenuType);
    
    useEffect(()=>{
        utility.addScriptFile(
            'appScriptFile', 
            laraDomain+"/admin/Midone-v3/Icewall_v1.0.9_min/dist/js/app.js",
            ()=>window.loadTheme()
        );
    }, []);

    return <>
        <MobileMenu prefix={"/sadmin"} menus={menu} />
        <TopBar setMenuType = {setMenuType} user={{}} logout={()=>{}} />
        <Wrapper Menu={<Menu prefix={"/sadmin"} menus={menu} key={"menu-"+menuType} />} key={menuType} >
            {children}
        </Wrapper>
    </>
}