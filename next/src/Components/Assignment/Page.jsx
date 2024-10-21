"use client";
import { useLang } from "@/lib/lang";
import { BackBtn, Box, Button, ButtonContainer, CourseToolsBtn, useFormRefs } from "@/Theme/Midone/Forms";
import { Select } from "@/Theme/Midone/Forms/Select";
import { Grid, Frame, useData, FeatherIcon, Tools } from "@/Theme/Midone/Utils";
import { useEffect, useRef, useState, useCallback, useMemo } from "react";
import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { useUtility } from "@/lib";
import { YearGroupFilter } from "@/Components/Public/YearGroupFilter";

export function Page({laraPath,nextPath,course,access,isAdmin}) {
    
    
    const { Lang, local } = useLang();
    const { destroy, getNeedles } = useData();
    const router = useRouter();
    const back = ()=>router.back();
    const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'courses';
    const formUrl =  nextPath+ "/"+menuPath+"/" +course+"/tools/assignment";
    const component = useFormRefs();
    const [params, setParams] = useState({ semester: "", group: "",correcting:"",type:"",menuPath:menuPath });
    let [url, setUrl] = useState(laraPath+"/assignment-list/"+course);
    const [needles, setNeedles] = useState();
    const effectRan = useRef(false);

    
    useEffect(() => {
        if (!effectRan.current) {
            getNeedles(`${laraPath}/assignments/get-needles?course=${course}`, setNeedles);
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
        setUrl(`${laraPath}/assignment-list/${course}?${urlItems}`);
    }, [urlItems, laraPath]);
   
    const filterList = useCallback((e, filter) => {
        setParams((prevParams) => ({ ...prevParams, [filter]: e.target.value }));
    }, []);

    const clearFilter = useCallback(() => {
        setParams({ semester: "", group: "",correcting:"",type:"",menuPath });
    }, []);
    const { getYearSemester, getGroupCode } = useUtility();

    const badge = [
        'bg-blue-100 w-14 text-blue-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded dark:bg-blue-900 dark:text-blue-300',
        'bg-green-100 w-17 text-green-800 text-xs font-medium me-2 px-2.5 py-0.5 rounded dark:bg-green-900 dark:text-green-300',
    ]


    const info = useMemo(() => ({
        // ...(menuPath === "courses" || access ? { insertLink: formUrl + "/new" } : {}),
        ...(menuPath === "courses" || menuPath === "myCourses") && access ? { insertLink: formUrl + "/new" } : {},

        perPage:20,
        url: url,
        columns: [
            {label: "title", minWidth:"150px",  jsx: (item)=><span>{<Link href={formUrl + "/" + item.id+ "/reply"}>{item.title}</Link> } <div className={(item.question_type.id == "1"? badge[0]:badge[1])}>{item.question_type?.["title_"+local]} </div> </span>},
            // {label: "questionType",  jsx: (item)=><span>{item.question_type?.["title_"+local]}</span>},
            {label: "year_semester", jsx: (item) => getYearSemester(item.group, Lang)},
            {label: "group",  jsx: (item)=>getGroupCode(item.group, Lang)},
            {label: "start_date", field: "start_date"},
            {label: "response_deadline", field: "expire_date"},
            access&&{ label: "correcting_report", jsx: (item) => <span className="ltr">{item?.corrected_count+"/"+item?.answer_count}</span>  },
            access&&{ label: "created_at", jsx: (item) => <span className="ltr">{Tools.toJalaliDateString(item?.created_at)}</span>  },
            //access ?{label: "creator", jsx: (item)=><span>{item.creator?.firstname+" "+item.creator?.lastname}</span>}:"",
            // access ?{label: "editor", jsx: (item)=><span>{item.editor?.firstname+" "+item.editor?.lastname}</span>}:"",
            access&&{label: "status",  jsx: (item)=><span className={item.active_status?.color}>{item.active_status?.["title_"+local]}</span>},
            {
                label: "",
                sort: false,
                width: "110px",
                jsx: (item) => <>
                    <div className='flex justify-center '>
                        {/* {item?.question_type_id==1 && */}
                        <FeatherIcon name="Users" access={access} url={formUrl+"/"+item.id+"/correcting"} tooltip={Lang('public.correcting')} />
                        <FeatherIcon name="ThumbsUp" url={formUrl + "/" + item.id+ "/reply"} tooltip={Lang(['public.view',' & ','public.reply'])} />
                        <FeatherIcon name="Edit" access={access} url={formUrl + "/" + item.id + "/edit"} tooltip={Lang('public.edit')} />
                        {/* <FeatherIcon name="Eye" url={formUrl + "/" + item.id} tooltip={Lang('public.view')} /> */}
                        <FeatherIcon name="XOctagon" access={access} tooltip={Lang('public.delete')} color="darkred" onClick={() => destroy(laraPath+"/assignments/" + item.id)} />
                    </div>
                </>
            },
        ],
    }), [url, Lang, formUrl, destroy, laraPath]);

   
    return (
        <Frame title={Lang(["public.assignment"])}>
            {access&&
                <Box shadow={false} minIcon={true} min={true}>
                    <YearGroupFilter isAdmin={isAdmin} needles={needles} Lang={Lang} filterList={filterList} />
                    <Select
                    className="col-span-2"
                        onChange={(e) => filterList(e, "correcting")}
                        value={params.correcting}
                        label="correcting"
                        refItem={[component, "correcting"]}
                        key={`correcting`}
                        required={true}
                    >
                        <option key={"corrected"} value={`corrected`}>{Lang("public.corrected")}</option>
                        <option key={"uncorrected"} value={`uncorrected`}>{Lang("public.uncorrected")}</option>
                    </Select>
                
                    <Select
                        className="col-span-2"
                        onChange={(e) => filterList(e, "type")}
                        value={params.type}
                        label="type"
                        refItem={[component, "type"]}
                        key={`type`}
                        required={true}
                        titleKey={'title_'+local}
                        data={needles?.questiontype}
                    />
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
                <Grid {...info} key={url} />
                <ButtonContainer>
                    <CourseToolsBtn href={`${nextPath}/${menuPath}/${course}/tools`} />
                    <BackBtn onClick={back} />
                </ButtonContainer>
            </div>
        </Frame>
    );
}