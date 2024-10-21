"use client";

import { Box } from "@/Theme/Midone/Base";

export function Description({data}){
    return(
        <>
            <Box cols="grid-cols-1" >
                <div class="mt-5 items-center">{data}</div>
            </Box>
        </>
    );
}