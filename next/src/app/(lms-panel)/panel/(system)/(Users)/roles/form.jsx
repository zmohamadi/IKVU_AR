"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { menu } from "@/lib/menu-list";
import { useData, useFormRefs, Input, Button, ButtonContainer, Box, CheckBox } from "@/Theme/Midone/Forms";
import { useRouter } from 'next/navigation';

export default function Form({ id }) {
    const { activeLang, Lang } = useLang();
    const { laraAdmin } = useConfig();
    const router = useRouter();
    let component = useFormRefs();
    let { save, get } = useData();
    let menus = menu;

    let url = laraAdmin + "/roles", method = "new";
    if (id != 0 && id != undefined) url = laraAdmin + "/roles/" + id, method = "edit";

    useEffect(() => {
        get(url, component, "info");
    }, []);

    const saveItem = () => save(url, component, method, "/roles");
    const back = () => router.back();

    return (
        <>
            <Box title={Lang(["public.roles"])}>
                <Input className="col-span-6" label={Lang("public.title")}
                    refItem={[component, "title_fa"]} required="true"
                />
                <CheckBox label="status" name={Lang('public.active')} refItem={[component, "status_id"]} />
            </Box>

            {/* <Box title={Lang(["public.access"])}>
                <ul className="space-y-2">
                    {menus.map((menu, index) => (
                        <li key={index}>
                            {menu.childs ? (
                                <>
                                    <span className="font-bold">{Lang('public.' + menu.title)}</span>
                                    <ul className="ml-4 space-y-1">
                                        {menu.childs.map((child, childIndex) => (
                                            <li key={childIndex}>
                                                <CheckBox className="col-span-3" label={Lang('public.' + child.title)} refItem={[component, `access_${child.title}`]} />
                                            </li>
                                        ))}
                                    </ul>
                                </>
                            ) : (
                                <CheckBox className="col-span-3" label={Lang('public.' + menu.title)} refItem={[component, `access_${menu.title}`]} />
                            )}
                        </li>
                    ))}
                </ul>
            </Box> */}

            <ButtonContainer>
                <Button label="save" onClick={saveItem} />
                <Button label="back" onClick={back} />
            </ButtonContainer>
        </>
    );
}
