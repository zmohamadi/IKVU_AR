"use client";

import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useData, useFormRefs, Frame } from "@/Theme/Midone/Utils";
import { CourseInfo, ShowReply,Info } from '@/Components/Inbox/ReplyDetails';
import { Input } from "@/Theme/Midone/Forms/Input";

export function View({ id, laraPath }) {
    const { Lang } = useLang();
    const component = useFormRefs();
    const { get } = useData();
    const url = `${laraPath}/inbox/reply-info/${id}`;

    useEffect(() => {
        get(url, component, "info");
    }, []);

    const { info } = component.state;
    const { result, item, course: dataCourse, answer } = info ?? {};

    return (
        <Frame title={Lang(["public.inbox"])}>
            <Input type="hidden" value={dataCourse?.code} refItem={[component, "course_id"]} />
            <div className="col-span-12 xxl:col-span-9">
                {(!item || !dataCourse) ? (
                    <span className="alert alert-danger-soft show flex items-center mb-2 mt-5">{Lang("public.loading")+"....."}</span>
                ) : (
                    <>
                        <div className="grid grid-cols-12 gap-6">
                            <Info data={item} />
                            <CourseInfo data={dataCourse} />
                        </div>
                        <div className="grid grid-cols-12 gap-6">
                            <div className="col-span-12">
                                <ShowReply data={item} />
                                    
                            </div>
                        </div>
                    </>
                )}
            </div>
        </Frame>
    );
}
