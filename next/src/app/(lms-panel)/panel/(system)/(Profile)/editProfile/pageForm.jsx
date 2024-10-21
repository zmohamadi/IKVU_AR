"use client";
import { useEffect, useState } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useData, useFormRefs, Input, Button, ButtonContainer, Box, CheckBox } from "@/Theme/Midone/Forms";
import { SelectTail } from "@/Theme/Midone/Forms/SelectTail";
import { Dropzone } from "@/Theme/Midone/Forms/Dropzone";
import { useRouter } from 'next/navigation';
import { useAuth } from "@/lib/auth";
import { Select } from "@/Theme/Midone/Forms/Select";

export default function Form() {
    const { Lang, local } = useLang();
    const { mediaPath, laraAdmin, nextAdmin } = useConfig();
    const { user } = useAuth({ guard: "admin" });
    const router = useRouter();
    let component = useFormRefs();
    let { save, get, getNeedles } = useData();
    let [needles, setNeedles] = useState();

    let uploadUrl = laraAdmin + "/upload/.-media-users";
    let deleteUrl = laraAdmin + "/deleteFile/.-media-users";
    let uploadDir = 'media/users/';

    const id = user?.id;
    let url = laraAdmin + "/users", method = "new";
    if (id != 0 && id != undefined) url = laraAdmin + "/users/" + id, method = "edit";

    useEffect(() => {
        getNeedles(laraAdmin + '/users/get-needles', setNeedles);
        get(url, component, "info");
    }, []);

    const saveItem = () => save(url, component, method, "/");
    const back = () => router.back();

    let roles = needles?.role?.filter((role, i)=>role.id == component?.state?.info?.role_id)

    return <>
        <Box title={Lang(["public.edit_profile"])}>
            <Input label="name" refItem={[component, "firstname"]} required="true" />
            <Input label="family" refItem={[component, "lastname"]} required="true" />
            <Select label="gender" refItem={[component, "gender_id"]}
                data={needles?.gender} titleKey={"title_" + local} required="true" />
            <Input dir="ltr" label="codemeli" refItem={[component, "codemeli"]} />
            <Select label="role" refItem={[component, "role_id"]} defaultValue={component?.state?.info?.role_id}
                data={roles} titleKey={"title_"+local} required="true" />
            <Input dir="ltr" label="username" refItem={[component, "username"]} required="true" disabled={true} />
            <Input label="mobile" refItem={[component, "mobile"]} required="true" disabled={true} />
            <Input label="email" refItem={[component, "email"]} required="true" />
            <Dropzone refItem={[component, "photo"]} uploadUrl={uploadUrl} deleteUrl={deleteUrl + "/"} uploadDir={uploadDir} required="true" />
            {/* <CheckBox label="status" name={Lang('public.active')} refItem={[component, "status_id"]} /> */}
        </Box>
        <ButtonContainer>
            <Button label="save" onClick={saveItem} />
            <Button label="back" onClick={back} />
        </ButtonContainer>
    </>;
}