"use client";

import { useConfig } from "@/lib";
import { useLang } from "@/lib/lang";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { Grid,Frame,FeatherIcon,Tools,Pic } from "@/Theme/Midone/Utils";
import { Button,ButtonContainer } from "@/Theme/Midone";

export function Page({ laraPath, course, toolsId, nextPath = "" }) {
    const { Lang, local } = useLang();
    const router = useRouter();

    // Function to navigate back
    const back = () => router.back();

    const { mediaPath } = useConfig();

    // URL for correcting form
    let formUrl = nextPath + "/courses/" + course + "/tools/assignment/" + toolsId + "/correcting/";

    // Grid configuration
    let info = {
        url: laraPath + "/assignment-answers/" + toolsId,
        columns: [
            {label: "",jsx: (item) => (<Pic src={mediaPath+"/users/"+item?.photo} defaultImg={`${mediaPath}/public/default/avatar.png`} classImg="user-avatar rounded-full" key={"img"+item?.photo} />),},
            { label: "name", field: "firstname" },
            { label: "lname", field: "lastname" },
            { label: "email", field: "email" },
            { label: "mobile", field: "mobile" },
            {label: "date", jsx: (item) => <span>{Tools.toJalaliDateString(item.assignment_answers?.[0]?.created_at)}</span>},
            {label: "score", jsx: (item) => (
                    <span>{item.assignment_answers?.[0]?.score ? item.assignment_answers?.[0]?.score + "/" + item.assignment_answers?.[0]?.assignment?.score : "-"}</span>
                ),
            },
            {label: "", sort: false,
                jsx: (item) => (
                    <div className="flex justify-center ">
                        <FeatherIcon name="CheckSquare" url={formUrl + item.id + "/attemp"} tooltip={Lang("public.correcting")} />     
                    </div>
                ),
            },
        ],
    };

    return (
        <Frame title={Lang(["public.students"])}>
            <div className="intro-y col-span-12">
                <Grid {...info} key={"table key"} />
                <ButtonContainer>
                    <Link href={nextPath + "/courses/" + course + "/tools"} className="btn btn-primary w-20 mr-1 ml-1">
                        {Lang(["public.tools_link"])}
                    </Link>
                    <Button label="back" onClick={back} />
                </ButtonContainer>
            </div>
        </Frame>
    );
}
