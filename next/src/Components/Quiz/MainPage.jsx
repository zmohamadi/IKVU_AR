"use client";
import { useUtility } from "@/lib";
import { useLang } from "@/lib/lang";
import { Box, Button, ButtonContainer } from "@/Theme/Midone/Forms";
import { YearGroupFilter } from "@/Components/Public/YearGroupFilter";
import { Grid, Frame, useData, FeatherIcon } from "@/Theme/Midone/Utils";
import { useEffect, useRef, useState, useCallback, useMemo } from "react";

export function MainPage({ laraPath, nextPath }) {
    const { Lang, local } = useLang();
    const { destroy, getNeedles } = useData();
    const formUrl = `${nextPath}/courses/`;
    const formUrlPart2 = "/tools/quiz/";
    const [params, setParams] = useState({ semester: "", group: "" });
    const [url, setUrl] = useState(`${laraPath}/quiz-mainList`);
    const [needles, setNeedles] = useState();
    const effectRan = useRef(false);
    const { getYearSemester, getGroupCode } = useUtility();


    useEffect(() => {
        if (!effectRan.current) {
            getNeedles(`${laraPath}/quiz/get-needles`, setNeedles);
            effectRan.current = true;
        }
    }, [getNeedles, laraPath]);

    const urlItems = useMemo(() => {
        return Object.keys(params)
            .filter(key => params[key])
            .map(key => `${key}=${params[key]}`)
            .join("&");
    }, [params]);

    useEffect(() => {
        setUrl(`${laraPath}/quiz-mainList?${urlItems}`);
    }, [urlItems, laraPath]);

    const filterList = useCallback((e, filter) => {
        setParams((prevParams) => ({ ...prevParams, [filter]: e.target.value }));
    }, []);

    const clearFilter = useCallback(() => {
        setParams({ semester: "", group: "" });
    }, []);

    const info = useMemo(() => ({
        url: url,
        columns: [
            { label: "title", field: "title" },
            { label: "group", field: "group" },
            { label: "start", jsx: (item) => <span dir="ltr">{item?.start_date + " " + item?.start_time}</span> },
            { label: "end", jsx: (item) => <span dir="ltr">{item?.end_date + " " + item?.end_time}</span> },
            { label: "year_semester", jsx: (item) => getYearSemester(item.group, Lang)},
            { label: "group",  jsx: (item)=>getGroupCode(item.group, Lang)},
            { label: "corrected", jsx: (item) => <span>{item.corrected_count}</span> },
            { label: "response", jsx: (item) => <span>{item.response_count}</span> },
            { label: "total_score", jsx: (item) => <span>{item.total_score}</span> },
            {
                label: "",
                sort: false,
                width: "110px",
                jsx: (item) => (
                    <div className='flex justify-center'>
                        <FeatherIcon name="MessageCircle" url={`${formUrl}${item.course_id}${formUrlPart2}${item.id}/reply`} tooltip={Lang('public.reply')} />
                        <FeatherIcon name="CheckSquare" url={`${formUrl}${item.course_id}${formUrlPart2}${item.id}/correcting`} tooltip={Lang('public.correcting')} />
                        <FeatherIcon name="Eye" url={`${formUrl}${item.course_id}${formUrlPart2}${item.id}`} tooltip={Lang('public.view')} />
                        <FeatherIcon name="Edit" url={`${formUrl}${item.course_id}${formUrlPart2}${item.id}/edit`} tooltip={Lang('public.edit')} />
                        <FeatherIcon name="XOctagon" tooltip={Lang('public.delete')} color="darkred" onClick={() => destroy(`${laraPath}/quiz/${item.id}`)} />
                    </div>
                )
            },
        ],
    }), [url, Lang, formUrl, formUrlPart2, destroy, laraPath]);

    return (
        <Frame title={Lang(["public.quiz"])}>
            <Box shadow={false} minIcon={true} min={true}>
                <YearGroupFilter
                    onChange={(e) => filterList(e, "semester")}
                    needles={needles}
                    Lang={Lang}
                />
                <ButtonContainer>
                    <Button
                        label="clear_filter"
                        className="btn btn-secondary w-20 mr-1 ml-1"
                        onClick={clearFilter}
                    />
                </ButtonContainer>
            </Box>
            <div className="intro-y col-span-12">
                <Grid {...info} key={url} />
            </div>
        </Frame>
    );
}
