"use client";

import { useLang } from "@/lib/lang";
import Link from "next/link";
import { useRouter } from 'next/navigation';
import { useEffect } from "react";
import { Button, ButtonContainer, CheckBox, Frame, useData, useFormRefs } from "@/Theme/Midone/Forms";
import { useConfig } from "@/lib/config";

export function Tools({ courseId , path}) {
    const { laraAdmin, mediaPath, nextAdmin } = useConfig();
    const { Lang ,local} = useLang();
    const router = useRouter();
    const component = useFormRefs();
    const { get } = useData();
    const toolsUrl = `${laraAdmin}/courses/tools/${courseId}`;

    const ROLES = {
        Teacher: 1,
        Student: 2,
        // Assistant: 3,
        // Admin: [4,5,6,7,8,9],
    };

    useEffect(() => {
        get(toolsUrl, component, "info");
    }, []);

    const updateToolStatus = async (tool) => {
        await get(`${laraAdmin}/courses/change-tools/${courseId}/${tool}`, component, "course");
        await get(toolsUrl, component, "info"); // Reload data after change
    };

    const toolsData = component?.state?.info?.tools;
    const course = component?.state?.info?.course;
    const role = component?.state?.info?.role?.role_id;
    const hasAccess = ![1,2,3].includes(role);
    // const hasAccess = role == ROLES.Admin;
    const isStudent = role == ROLES.Student;

    const inactiveImgClass = "filter grayscale pointer-events-none";
    const back = () => router.back();

    return (
        <>
            <Frame title={Lang("public.tools")} cols={10}>
            {toolsData?.map((tool, index) => {
                let hrefTools = course?.[tool.title_en] === 0 && isStudent ? "#" : `${nextAdmin}/${path}/${courseId}/tools/${tool.href}`;

                return (
                    <div key={index} className="col-span-5 md:col-span-4 lg:col-span-3 xl:col-span-2 file box rounded-md px-5 pt-8 pb-5 sm:px-5 relative zoom-in btn-cursor-default">
                        <Link href={hrefTools} className="w-3/5 file__icon file__icon--image mx-auto">
                            <div className={`file__icon--image__preview image-fit ${course?.[tool.title_en] === 0 ? inactiveImgClass : ''}`}>
                                <img alt={tool.title_en} src={`${mediaPath}/baseTools/${tool.img}`} />
                            </div>
                        </Link>
                        <Link href={hrefTools} className="block font-medium mt-4 text-center truncate">
                            {tool['title_'+local]}
                        </Link>
                        {hasAccess && (
                            <CheckBox
                                onChange={() => updateToolStatus(tool.title_en)}
                                defaultValue={course?.[tool.title_en]}
                                label=" "
                                name={Lang('public.active')}
                                refItem={[component, "status_id"]}
                                value={0}
                            />
                        )}
                    </div>
                );
            })}

            </Frame>
            <ButtonContainer>
                <Button label="back" onClick={back} />
            </ButtonContainer>
        </>
    );
}
