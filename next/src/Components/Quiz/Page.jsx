"use client";
import { useLang } from "@/lib/lang";
import { BackBtn, Box, Button, ButtonContainer, CourseToolsBtn } from "@/Theme/Midone/Forms";
import { YearGroupFilter } from "@/Components/Public/YearGroupFilter";
import { Grid, Frame, useData, FeatherIcon } from "@/Theme/Midone/Utils";
import { useEffect, useRef, useState, useCallback, useMemo } from "react";
import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { useConfig, useUtility } from "@/lib";
// import moment from 'moment-jalaali';

export function Page({ laraPath, nextPath,formUrl , formUrl2=null, course=0, access, isAdmin }) {
    // const getJalaliDate = () => {
    //     return moment().format('jYYYY/jMM/jDD');
    // }
    const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'courses';
    const { Lang } = useLang();
    const { destroy, getNeedles, get } = useData();
    const router = useRouter();
    const back = () => router.back();
    // const [params, setParams] = useState({ semester: "", group: "",date:getJalaliDate(),hour:"" });
    const [params, setParams] = useState({ semester: "", group: "",menuPath:menuPath });
    let [url, setUrl] = useState(laraPath + "/quiz-list/" + course);
    const [needles, setNeedles] = useState();
    const effectRan = useRef(false);
    const { mediaPath } = useConfig();


    useEffect(() => {
        if (!effectRan.current) {
            getNeedles(`${laraPath}/quiz/get-needles?course=${course}`, setNeedles);
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
        setUrl(`${laraPath}/quiz-list/${course}?${urlItems}`);
    }, [urlItems, laraPath]);

    const filterList = useCallback((e, filter) => {
        setParams((prevParams) => ({ ...prevParams, [filter]: e.target.value }));
    }, []);

    const clearFilter = useCallback(() => {
        // setParams({ semester: "", group: "",date:"",hour:"" });
        setParams({ semester: "", group: "",menuPath});
    }, []);

    const { getYearSemester, getGroupCode } = useUtility();

    // تابع مجزا برای onClick
    const handleClick = useCallback((e, item) => {
        e.preventDefault();
        if (document.getElementById('a-loading')) return;
        e.target.innerHTML = loading + e.target.innerHTML;
        // console.log("item is ", item);
        get(laraPath + "/bbb/" + item?.id, "", "", (data) => {
            console.log("callback!!");
            let a = document.createElement("a");
            const id = "a-" + Math.random();
            a.href = data.url;
            a.target = "_blank";
            a.id = id;
            document.body.appendChild(a);
            Element.prototype.remove = function () {
                this.parentElement.removeChild(this);
            };
            document.getElementById('a-loading').remove();
            document.getElementById(id).click();
        });
    }, [get, laraPath]);

    const info = useMemo(() => ({
        // insertLink: access && formUrl2==null ? formUrl + "/new" : "",
        ...(menuPath === "courses" || menuPath === "myCourses") && access && formUrl2 === null ? { insertLink: formUrl + "/new" } : {},
        url: url,
        columns: [
            {label: "title",  jsx: (item)=><span>{<Link href={formUrl + "/" + item.id+ "/reply"}>{item.title}</Link> }</span>},
            {label: "start", jsx: (item)=><span dir="ltr" >{item?.start_date+" "+item?.start_time}</span>},
            {label: "end", jsx: (item)=><span  dir="ltr">{item?.end_date+" "+item?.end_time}</span>},
            {label: "year_semester", jsx: (item) => getYearSemester(item.group, Lang)},
            {label: "group",  jsx: (item)=>getGroupCode(item.group, Lang)},
            access?{ label: "corrected", jsx: (item) => <span>{item.corrected_count}</span> }:'',
            access?{ label: "response", jsx: (item) => <span>{item.answer_count}</span> }:'',
            access?{ label: "total_score", jsx: (item) => <span>{item.total_score}</span> }:'',
            //access ?{label: "creator", jsx: (item)=><span>{item.creator?.firstname+" "+item.creator?.lastname}</span>}:"",

            {
                label: "",
                sort: false,
                width: "110px",
                jsx: (item) => <>
                    <div className='flex justify-center '>
                        <FeatherIcon name="MessageCircle" url={`${formUrl}${formUrl2!=null?item.course_id+formUrl2 : ""}/${item.id}/reply`}  tooltip={Lang('public.reply')} /> 
                        <FeatherIcon name="CheckSquare" access={access} url={`${formUrl}${formUrl2!=null?item.course_id+formUrl2 : ""}/${item.id}/correcting`} tooltip={Lang('public.correcting')} />
                        <FeatherIcon name="Eye" url={`${formUrl}${formUrl2!=null?item.course_id+formUrl2 : ""}/${item.id}`} tooltip={Lang('public.view')} />
                        <FeatherIcon name="Edit" access={access} url={`${formUrl}${formUrl2!=null?item.course_id+formUrl2 : ""}/${item.id}/edit`} tooltip={Lang('public.edit')} />
                        <FeatherIcon name="XOctagon" access={access} tooltip={Lang('public.delete')} color="darkred" onClick={() => destroy(laraPath+"/quiz/" + item.id)} />
                    </div>
                </>
            },
        ],
    }), [url, Lang, formUrl, destroy, laraPath, access, getYearSemester, getGroupCode, handleClick]);

    return (
        <Frame title={Lang(["public.quiz"])}>
            {access &&
                <Box shadow={false} minIcon={true} min={true}>
                    <YearGroupFilter isAdmin={isAdmin} needles={needles} Lang={Lang} filterList={filterList} />
                    {/* {formUrl2 != null ?<>
                        <Input defaultValue={getJalaliDate()} options={{onChange : (e) => filterList(e, "date")}} dir="ltr" className="col-span-3" placeholder="1403/01/01" label="date" />
                        <Input options={{onChange :(e) => filterList(e, "hour")}} dir="ltr" className="col-span-2" placeholder="10:00" label="start_hour" />
                    </>
                    :""} */}
                    <ButtonContainer>
                        <Button
                            label="clear_filter"
                            className="btn btn-secondary mt-2 w-20 mr-1 ml-1"
                            onClick={clearFilter}
                        />
                    </ButtonContainer>
                </Box>
            }
            <div className="intro-y col-span-12">
                <Grid {...info} key={url} />
                {formUrl2 == null ?
                <>
                    
                    <ButtonContainer>
                        {/* <Link className="btn btn-primary mr-1 ml-1" target="_blanket" href={`${mediaPath}/public/example_class_online.xlsx`}>{Lang(["public.example_excel"])}</Link>
                        <Link className="btn btn-primary mr-1 ml-1" href={`${formUrl}/excel`}>{Lang(["public.enter_excel"])}</Link> */}
                        
                        <CourseToolsBtn href={`${nextPath}/${menuPath}/${course}/tools`} />
                        <BackBtn onClick={back} />
                    </ButtonContainer>
                </>
                :""}
            </div>
        </Frame>
    );
}

const loading = '<svg id="a-loading" style="display: inline-block; margin: 0 6px" width="25" viewBox="0 0 120 30" xmlns="http://www.w3.org/2000/svg" fill="rgb(45, 55, 72)"><circle cx="15" cy="15" r="15"><animate attributeName="r" from="15" to="15" begin="0s" dur="0.8s" values="15;9;15" calcMode="linear" repeatCount="indefinite"></animate><animate attributeName="fill-opacity" from="1" to="1" begin="0s" dur="0.8s" values="1;.5;1" calcMode="linear" repeatCount="indefinite"></animate></circle><circle cx="60" cy="15" r="9" fill-opacity="0.3"><animate attributeName="r" from="9" to="9" begin="0s" dur="0.8s" values="9;15;9" calcMode="linear" repeatCount="indefinite"></animate><animate attributeName="fill-opacity" from="0.5" to="0.5" begin="0s" dur="0.8s" values=".5;1;.5" calcMode="linear" repeatCount="indefinite"></animate></circle><circle cx="105" cy="15" r="15"><animate attributeName="r" from="15" to="15" begin="0s" dur="0.8s" values="15;9;15" calcMode="linear" repeatCount="indefinite"></animate><animate attributeName="fill-opacity" from="1" to="1" begin="0s" dur="0.8s" values="1;.5;1" calcMode="linear" repeatCount="indefinite"></animate></circle></svg>';
