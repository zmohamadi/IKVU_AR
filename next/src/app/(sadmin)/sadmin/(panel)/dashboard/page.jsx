"use client"

import {Frame} from '@/Theme/Midone';
import {useLang} from '@/lib/lang';


export default function Dashboard(options) {
    let {Lang} = useLang();
    return <>
        <Frame title={Lang(["public.dashboard"])}>
            <div className="intro-y col-span-12">
                
            </div>
        </Frame>
    </>
}