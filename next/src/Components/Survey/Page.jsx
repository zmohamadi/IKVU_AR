"use client";
import { useLang } from "@/lib/lang";
import { BackBtn, Box, Button, ButtonContainer, CourseToolsBtn } from "@/Theme/Midone/Forms";
import { YearGroupFilter } from "@/Components/Public/YearGroupFilter";
import { Grid, Frame, useData, FeatherIcon } from "@/Theme/Midone/Utils";
import { useEffect, useRef, useState, useCallback, useMemo } from "react";
import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { useUtility } from "@/lib";

export function Page({laraPath,nextPath,course,access,isAdmin}) {
    const { Lang, local } = useLang();
    const { destroy, getNeedles } = useData();
    const router = useRouter();
    const back = ()=>router.back();
    const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'courses';
    const formUrl =  nextPath+ "/"+menuPath+"/" +course+"/tools/survey";
    const [params, setParams] = useState({ semester: "", group: "",menuPath:menuPath });
    let [url, setUrl] = useState(laraPath+"/survey-list/"+course);
    const [needles, setNeedles] = useState();
    const effectRan = useRef(false);
    const { getYearSemester, getGroupCode } = useUtility();
    const [getAccess, setGetAccess] = useState();


    let info = {
        // insertLink: getAccess? formUrl+"/new": "",
        ...(menuPath === "courses" || getAccess ? { insertLink: formUrl + "/new" } : {}),
        url: url,
        columns: [
            {label: "title", jsx: (item)=><span>{<Link href={formUrl + "/" + item?.id+ "/reply"}>{item?.title}</Link> }</span>},
            {label: "year_semester", jsx: (item) => getYearSemester(item?.group, Lang)},
            {label: "group",  jsx: (item)=>getGroupCode(item?.group, Lang)},
            { label: "start_date", field: "start_date" },
            { label: "response_deadline", field: "expire_date" },
            access?{label: "status",  jsx: (item)=><span className={item?.active_status?.color}>{item?.active_status?.["title_"+local]}</span>}:'',
            {
                label: "",
                sort: false,
                width: "110px",
                jsx: (item) => <>
                    <div className='flex justify-center '>
                        <FeatherIcon name="ThumbsUp" url={formUrl + "/" + item?.id+ "/reply"} tooltip={Lang('public.reply')} />
                        <FeatherIcon name="Eye" url={formUrl + "/" + item?.id} tooltip={Lang('public.view')} />
                        <FeatherIcon name="BarChart2" access={getAccess} url={formUrl + "/" + item?.id+ "/result"} tooltip={Lang('public.results')} />
                        <FeatherIcon name="Users" access={getAccess} url={formUrl + "/" + item?.id+ "/students"} tooltip={Lang('public.students')} />
                        <FeatherIcon name="Edit" access={getAccess} url={formUrl + "/" + item?.id + "/edit"} tooltip={Lang('public.edit')} />
                        <FeatherIcon name="XOctagon" access={getAccess} tooltip={Lang('public.delete')} color="darkred" onClick={() => destroy(laraPath+"/survey/" + item?.id)} />
                    </div>
                </>
            },
        ],
        callback: (data)=>{ setGetAccess(data?.accessOperation) }
    }
    useEffect(() => {
        if (!effectRan.current) {
            getNeedles(`${laraPath}/survey/get-needles?course=${course}`, setNeedles);
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
        setUrl(`${laraPath}/survey-list/${course}?${urlItems}`);
    }, [urlItems, laraPath]);

    const filterList = useCallback((e, filter) => {
        setParams((prevParams) => ({ ...prevParams, [filter]: e.target.value }));
    }, []);

    const clearFilter = useCallback(() => {
        setParams({ semester: "", group: "",menuPath });
    }, []);

    return (
        <Frame title={Lang(["public.survey"])}>
            {access&&
                <Box shadow={false} minIcon={true} min={true}>
                    <YearGroupFilter isAdmin={isAdmin} needles={needles} Lang={Lang} filterList={filterList} />
                
                    <ButtonContainer>
                        <Button
                            label="clear_filter"
                            className="btn btn-secondary w-20 mr-1 ml-1"
                            onClick={clearFilter}
                        />
                    </ButtonContainer>
                </Box>
           
            }
            <div className="intro-y col-span-12">
                <Grid {...info} key={"table key"} />
                <ButtonContainer>
                    <CourseToolsBtn href={`${nextPath}/${menuPath}/${course}/tools`} />
                    <BackBtn onClick={back} />
                </ButtonContainer>
            </div>
        </Frame>
    );
}