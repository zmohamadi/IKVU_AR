"use client";
import { Pic } from "@/Theme/Midone";
import { useConfig } from "@/lib/config";
import { useLang } from "@/lib/lang";


export function Course({data,title}){

    const {Lang} = useLang();
    const {mediaPath,nextAdmin } = useConfig();
    const formUrl = "/courses"; 

    return<>
            <div class="col-span-12 mt-6">
                <div class="intro-y block sm:flex items-center h-10">
                    <h2 class="text-lg font-medium truncate ml-5">
                    {Lang('public.'+title)}
                    </h2>
                    
                </div>
                <div class="intro-y overflow-auto lg:overflow-visible mt-8 sm:mt-0">
                    <table class="table table-report sm:mt-2">
                        <tbody>
                        {data?.map((info,index)=>{
                                return <tr class="intro-x">
                                <td class="w-40">
                                    <div class="flex">
                                        <div class="w-10 h-10 image-fit zoom-in">
                                            <Pic src={`${mediaPath}/courses/${info?.thumbnail}`} classImg="tooltip" defaultImg={`${mediaPath}/public/default/course.jpg`} key={"img"+info?.thumbnail} />

                                        </div>
                                    
                                    </div>
                                </td>
                                <td>
                                    <a href="" class="font-medium whitespace-nowrap"> {info?.title}</a> 
                                    <div class="text-gray-600 text-xs whitespace-nowrap mt-0.5">{info?.category?.title_fa}</div>
                                </td>
                                <td class="w-40">
                                    {
                                        info?.status_id==1 ? <><div class="flex items-center justify-center text-theme-10"> 
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" strokeLinejoin="round" class="feather feather-check-square w-4 h-4 ml-2"><polyline points="9 11 12 14 22 4"></polyline><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"></path></svg>
                                            {info?.active_status?.title_fa} 

                                        </div>
                                        </> : <>
                                        <div class="flex items-center justify-center text-theme-24"> 
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" strokeLinejoin="round" class="feather feather-check-square w-4 h-4 ml-2"><polyline points="9 11 12 14 22 4"></polyline><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"></path></svg> 
                                            {info?.active_status?.title_fa} 
                                        </div>
                                        </>
                                    }
                                    
                                </td>
                                <td class="table-report__action w-56">
                                    <div class="flex justify-center items-center">
                                        <a class="flex items-center ml-3 text-theme-22" href={nextAdmin+formUrl+"/"+info.code+"/edit"}> 
                                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" strokeLinejoin="round" class="feather feather-check-square w-4 h-4 ml-1"><polyline points="9 11 12 14 22 4"></polyline><path d="M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11"></path></svg> 
                                            {Lang(["public.edit"])}
                                        </a>
                                        <a class="flex items-center text-theme-26" href={nextAdmin+formUrl+"/"+info.code}> 
                                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" className="feather feather-eye w-4 h-4 ml-2"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                                        {Lang(["public.view"])} </a>
                                    </div>
                                </td>
                            </tr>
                            })}
                            
                        </tbody>
                    </table>
                </div>
                
            </div>
           
                    
        </>;
}