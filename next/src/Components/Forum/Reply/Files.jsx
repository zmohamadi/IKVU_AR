"use client";

import { useConfig } from '@/lib/config';

export const Files = ({ data }) => {
    const {mediaPath} = useConfig();

    return(
        <>
            {data?.map((data, i)=>{
                let display = (data?.file_type_id > 1)?
                    <div className="file">
                        <a href={mediaPath+"/forum/"+data?.name} download={data?.name} target="blank" className="font-medium">
                            <span href="" className="w-12 file__icon file__icon--file">
                                <div className="file__icon__file-name text-xs">{data?.extension}</div>
                            </span>
                        </a>
                    </div>
                :
                    // <img alt="Pic" className="rounded-md border border-white" src={mediaPath+"/forum/"+data?.name} />
                    <div className="grid grid-cols-12 gap-6">
                        <div className="intro-y col-span-3 lg:col-span-3">
                                <div id="image-zoom" className="">
                                    <div className="preview">
                                        <div className="leading-relaxed">
                                            <div className="w-full h-64">
                                                <img alt="Pic" src={mediaPath+"/forum/"+data?.name} data-action="zoom" className="rounded-md border border-white" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                        </div>
                    </div>
                return(
                        <div className="tooltip w-8 h-8 col-span-12 lg:col-span-12 image-fit ml-5 zoom-in btn-cursor-default">
                            {display}
                        </div>
                    );
                })
            }
        </>
    );
}