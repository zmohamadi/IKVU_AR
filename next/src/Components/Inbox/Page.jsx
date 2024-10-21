"use client";
import { useLang } from "@/lib/lang";
import { Box, Button, ButtonContainer } from "@/Theme/Midone/Forms";
import { Grid, Frame, useData, FeatherIcon, Tools } from "@/Theme/Midone/Utils";
import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import { useAuth } from "@/lib/auth";
import { useUtility } from "@/lib";

export function Page({ laraPath, nextPath, course }) {
    const { user } = useAuth({ guard: "admin" });
    const access = user?.role_id !== 2;
    const router = useRouter();
    const back = () => router.back();
    const { Lang, local } = useLang();
    const { destroy } = useData();
    const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'courses';
    const formUrl = nextPath + "/"+menuPath+"/" + course + "/tools/inbox";
    let [type, setType] = useState('inbox');  // Set default to 'inbox'
    let [url, setUrl] = useState(`${laraPath}/inbox-list/${course}?type=inbox`);  // Initialize URL with 'inbox'
    const { getYearSemester, getGroupCode } = useUtility();


    let info = {
        insertLink: formUrl + "/new",
        url: url,
        columns: [
            { label: "title", field: "title" },
            { label: "text", field: "text" },
            {label: "year_semester", jsx: (item) => getYearSemester(item.group, Lang)},
            {label: "group",  jsx: (item)=>getGroupCode(item.group, Lang)},
            ...(type === 'inbox' ? [{ label: "sender", jsx: (item) => <span>{item?.sender?.[0]?.firstname + " " + item?.sender?.[0]?.lastname}</span> }] : []),
            ...(type === 'outbox' ? [{label: "receiver", jsx: (item) => <span>{item?.receiver?.[0]?.firstname + " " + item?.receiver?.[0]?.lastname}</span>}] : []),
            // //access ?{label: "creator", jsx: (item)=><span>{item.creator?.firstname+" "+item.creator?.lastname}</span>}:"",
            { label: "created_at", jsx: (item) => <span className="ltr">{Tools.toJalaliDateString(item?.created_at)}</span> },

            {
                label: "",
                sort: false,
                width: "110px",
                jsx: (item) => <>
                    <div className='flex justify-center '>
                        {type=="inbox" && <FeatherIcon name="ThumbsUp" url={formUrl + "/" + item.id + "/reply"} tooltip={Lang('public.reply')} />}
                        {/* <FeatherIcon name="Edit" access={access} url={formUrl + "/" + item.id + "/edit"} tooltip={Lang('public.edit')} /> */}
                        <FeatherIcon name="Eye" url={formUrl + "/" + item.id} tooltip={Lang('public.view')} />
                        {/* <FeatherIcon name="XOctagon" access={access} tooltip={Lang('public.delete')} color="darkred" onClick={() => destroy(laraPath + "/inbox/" + item.id)} /> */}
                    </div>
                </>
            },
        ],
    }

    useEffect(() => {
        setUrl(`${laraPath}/inbox-list/${course}?type=${type}`);
    }, [type]);

    const handleFilterClick = (selectedType) => {
        setType(selectedType);
    }

    const setClass = (item, btnClass) => {
        return "col-span-2 btn " + btnClass + (type !== item ? " btn-secondary-soft" : "")
    }

    const getLabel = (label, item) => {
        return <>
            {(type !== item) ?
                <FeatherIcon name="Square" spanWrapperClass="mx-2" />
                : <FeatherIcon name="Check" spanWrapperClass="mx-2" />
            }
            {Lang('public.' + label)}
        </>
    }

    return (
        <Frame title={Lang(["public.inbox"])}>
            <Box shadow={false}>
                <Button label={getLabel("inbox", "inbox")} onClick={() => handleFilterClick("inbox")} className={setClass('inbox', 'btn-success')} />
                <Button label={getLabel("outbox", "outbox")} onClick={() => handleFilterClick("outbox")} className={setClass('outbox', 'btn-primary')} />
            </Box>
            <div className="intro-y col-span-12">
                <Grid {...info} key={url} />
                <ButtonContainer>
                    <Link className="btn btn-success w-20 mr-1 ml-1" href={`${nextPath}/${menuPath}/${course}/tools`}>{Lang(["public.tools_link"])}</Link>
                    <Button label="back" onClick={back} />
                </ButtonContainer>
            </div>
        </Frame>
    );
}
