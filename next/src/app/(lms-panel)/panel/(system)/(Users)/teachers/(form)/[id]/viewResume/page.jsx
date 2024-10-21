"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { Button, ButtonContainer, useData, useFormRefs, Frame, Pic } from "@/Theme/Midone";
import { useRouter } from 'next/navigation';

export default function View({ params }) {
    const { Lang, local } = useLang();
    const { laraAdmin, mediaPath } = useConfig();
    const component = useFormRefs();
    const { get } = useData();
    const router = useRouter();

    const id = params.id;
    const url = `${laraAdmin}/users/show-info/${id}`;

    useEffect(() => {
        get(url, component, "info");
    }, []);

    const item = component?.state?.info?.item;
    const back = () => router.back();

    const role = item?.role?.["title_" + local];
    const firstname = item?.firstname;
    const lastname = item?.lastname;
    const gender = item?.gender?.["title_" + local] + (item?.gender_id == 1 ? Lang(["public.y"]) + " " : "");

    return (
        <>
            <Frame title={Lang(["public.resume"])}>
                <div className="intro-y box col-span-12">
                    <div className="flex items-center px-5 py-3 border-b border-gray-200 dark:border-dark-5">
                        <h3 className="text-2xl font-medium mt-3">
                            {`${role}: ${gender} ${firstname} ${lastname}`}
                        </h3>
                    </div>
                    <div className="tiny-slider py-5">
                        <div className="px-5">
                            <div className="flex flex-col lg:flex-row items-center pb-5 w-full justify-between">
                                {/* Image Section */}
                                <div className="sm:mr-5 order-2 sm:order-1">
                                    <div className="w-20 h-20 image-fit">
                                        <Pic src={`${mediaPath}/users/${item?.photo}`} defaultImg={`${mediaPath}/public/default/avatar.png`} classImg="rounded-full" key={"img"+item?.photo} />
                                    </div>
                                </div>
                            </div>
                            {/* Resume Section */}
                            <div className="flex">
                                <h3 className="font-medium ml-2">{Lang(["public.teacher_resume"])}:</h3>
                                <span>{item?.resume? item?.resume : Lang(["public.no_data"])}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </Frame>
            <ButtonContainer>
                <Button label="back" onClick={back} />
            </ButtonContainer>
        </>
    );
}
