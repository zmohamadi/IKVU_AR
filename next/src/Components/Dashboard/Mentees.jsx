"use client";
import { Pic } from "@/Theme/Midone";
import { useConfig } from "@/lib/config";
import { useLang } from "@/lib/lang";


export function Mentees({data,title}){

    const {Lang} = useLang();
    const {mediaPath } = useConfig();

    return<>
            <div className="intro-y flex items-center h-10">
                <h2 className="text-lg font-medium truncate ml-5">
                    {Lang('public.'+title)}
                </h2>
            </div>
            {data?.length>0?
            <div className="mt-5">
                {data?.map((mentee,index)=>{
                    return <div className="intro-y" key={index}>
                    <div className="box px-4 py-4 mb-3 flex items-center zoom-in">
                        <div className="w-10 h-10 flex-none image-fit rounded-md overflow-hidden">
                            <Pic src={`${mediaPath}/users/${mentee?.photo}`} classImg="rounded-full" defaultImg={`${mediaPath}/public/default/avatar.png`} key={"img"+mentee?.photo} />
                        </div>
                        <div className="ml-4 mr-auto">
                            <div className="font-medium">{mentee.firstname} {mentee.lastname}</div>
                            <div className="text-gray-600 text-xs mt-0.5">{mentee?.created_at}</div>
                            
                        </div>
                        
                    </div>
                </div>
                })}
                
                
            </div>
            :
            <a className="intro-y w-full block text-center rounded-md py-4 border border-dotted border-theme-27 dark:border-dark-5 text-theme-28 dark:text-gray-600">
                {Lang('public.no_data')}
            </a>
            }            
        </>;
}