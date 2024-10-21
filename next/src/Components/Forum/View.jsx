"use client";

import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useData,useFormRefs,Frame } from "@/Theme/Midone/Utils";
import { useRouter } from 'next/navigation';
import { Box } from "@/Theme/Midone/Base";
import { ButtonContainer,Button } from "@/Theme/Midone/Forms";
import { CourseInfo,ForumInfo,Description,ForumComplete } from '@/Components/Forum/Details';

export function View({ id,course,laraPath,nextPath="" }){
    const {Lang} = useLang();
    let component = useFormRefs();
    let {get} = useData();
    const router = useRouter();
    let url = laraPath+"/forum/show-info/"+id;
    useEffect(() => {
        get(url, component, "info");
    }, []);

    let data = component?.state?.info;
    let item = data?.item;
    let dataCourse = data?.course;
    let complete = "";
    let classForm = "lg:col-span-12 xxl:col-span-12";
    if(data?.ISPERSONNEL)
    {
        complete = <ForumComplete data={item} />;
        classForm = "lg:col-span-9 xxl:col-span-9";
    }
    const back = ()=>router.back();

    return(
        <Frame title={Lang(["public.forum"])}>
            <div className="col-span-12 xxl:col-span-9">
                {(item == undefined || dataCourse == undefined)?
                    <span className="alert alert-success-soft show flex items-center mb-2 mt-5">{Lang("public.loading")+"....."}</span>
                :
                    <>
                        <div className="grid grid-cols-12 gap-6">
                            <ForumInfo data={item} />
                            <CourseInfo data={dataCourse} />
                        </div>
                        <div className="grid grid-cols-12 gap-6">
                            <div className={"col-span-12 "+classForm}>
                                <Description data={item?.description} />
                                <ButtonContainer>
                                    <Button label="back" onClick={back} />
                                </ButtonContainer>
                            </div>
                            <div className="col-span-12 lg:col-span-3 xxl:col-span-3 flex lg:block flex-col-revers">
                                {complete}
                            </div>
                        </div>
                    </>
                }
            </div>
        </Frame>
    );
}