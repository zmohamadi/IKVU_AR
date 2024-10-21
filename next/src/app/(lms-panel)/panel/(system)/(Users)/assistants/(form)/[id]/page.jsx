"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useRouter } from "next/navigation";
import { useData, useFormRefs, ButtonContainer, Button, Frame } from "@/Theme/Midone";
import { Info, Detail, Register } from '@/app/(lms-panel)/panel/(system)/(Users)/users/view';

export default function View({ params }) {
    const { Lang } = useLang();
    const { laraAdmin } = useConfig();
    const component = useFormRefs();
    const { get } = useData();
    const router = useRouter();

    const id = params.id;
    const url = `${laraAdmin}/users/show-info/${id}`;

    useEffect(() => {
        get(url, component, "info");
    }, []);

    const item = component?.state?.info?.item;
    const registers = component?.state?.info?.registers;
    const back = ()=>router.back();

    return (
        <>
            <Frame title={Lang(["public.assistants"])}>
                <div className="col-span-12 lg:col-span-4 xxl:col-span-3 flex lg:block flex-col-reverse">
                    <Info item={item} linkView="assistants" />
                    <Detail item={item} />
                </div>
                <div className="col-span-12 lg:col-span-8 xxl:col-span-9">
                    <Register data={registers} />
                </div>
            </Frame>
            <ButtonContainer>
                <Button label="back" onClick={back} />
            </ButtonContainer>
        </>
    );
}
