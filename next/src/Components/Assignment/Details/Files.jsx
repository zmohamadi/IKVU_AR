"use client";

import { useConfig } from '@/lib/config';
import { FeatherIcon } from "@/Theme/Midone";

export const Files = ({ data,path="/assignmentAnswer/",colorIcon="instagram",Lang }) => {
    const {mediaPath} = useConfig();

    return(
        <>
            {data?.filter(file => file !== "")?.map((file, index)=>{                
                    return(
                        <a key={file} className={`btn btn-${colorIcon} w-24 mr-2 mb-2`} href={`${mediaPath}${path}${file}`} target="_blank" rel="noopener noreferrer">
                            <FeatherIcon name="Download" className="w-4 h-4 ml-2" />
                            {Lang("public.file")} {index + 1}
                        </a>                    
                    );
                })
            }
        </>
    );
}