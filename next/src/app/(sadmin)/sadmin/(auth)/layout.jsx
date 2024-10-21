"use client";

import { config } from "@/lib/config";

export default function Panel({children}){
    return <>        
            <div className="login">
                {children}
            </div>
        </>
}