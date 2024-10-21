"use client";
import { useLang } from "@/lib/lang";
import { BackBtn, Box, Button, ButtonContainer, CourseToolsBtn, DatePicker, Input } from "@/Theme/Midone/Forms";
import { YearGroupFilter } from "@/Components/Public/YearGroupFilter";
import { Grid, Frame, useData, FeatherIcon } from "@/Theme/Midone/Utils";
import { useEffect, useRef, useState, useCallback, useMemo } from "react";
import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { useConfig, useUtility } from "@/lib";
import moment from 'moment-jalaali';
import { Select } from "@/Theme/Midone/Forms/Select";

export function Page({ laraPath, nextPath, formUrl , formUrl2=null, course=0, access, isAdmin }) {
    const getJalaliDate = () => {
        return moment().format('jYYYY/jMM/jDD');
    }
    const firstDate=formUrl2!= null ? getJalaliDate() : "";

    const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'courses';
    const { Lang,local } = useLang();
    const { destroy, getNeedles, get } = useData();
    const router = useRouter();
    const back = () => router.back();
    const [params, setParams] = useState({ semester: "", group: "", date:firstDate,hour:"",code:"",menuPath:menuPath });
    let [url, setUrl] = useState(laraPath + "/onlineClassroom-list/" + course);
    const [needles, setNeedles] = useState();
    const effectRan = useRef(false);
    const { mediaPath } = useConfig();

    const handleFilterChange = (e, filter) => {
      setParams(prev => ({ ...prev, [filter]: e.target.value }));
    };

    useEffect(() => {
        if (!effectRan.current) {
            getNeedles(`${laraPath}/onlineClassrooms/get-needles?course=${course}`, setNeedles);
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
        setUrl(`${laraPath}/onlineClassroom-list/${course}?${urlItems}`);
    }, [urlItems, laraPath]);

    const filterList = useCallback((e, filter) => {
        setParams((prevParams) => ({ ...prevParams, [filter]: e.target.value }));
    }, []);

    const clearFilter = useCallback(() => {
        setParams({ semester: "", group: "",date:"",hour:"",code:"",menuPath });
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
      ...(menuPath === "courses" || menuPath === "myCourses") && access && formUrl2 === null ? { insertLink: formUrl + "/new" } : {},
      perPage: 20,
      url: url,
      columns: [
          ...(formUrl2 ? [{ label: "course", jsx: (item) => <span>{item?.course?.title}-{item?.course_id}</span> }] : []),
          { label: "title", field: "title" ,minWidth: "90px", },
          {
            label: "class",
            width: "180px",
            minWidth: "180px",
            jsx: (item) => (
                <span>
                    {item?.is_cancel!=null ? <span className={`btn btn-rounded btn-danger-soft`}>کنسل</span>  :<>
                        {item?.checkDateTime?.status == "before_time" &&
                        <span className="btn btn-rounded btn-warning-soft">{Lang('public.before_time_class')}</span>}
                        {item?.checkDateTime?.status == "after_time" &&
                            <span className={`btn btn-rounded btn-${item?.userInClass === "غائب" ? "danger" : "success"}-soft`}>
                            {/* {item?.userInClass} */}
                            {item?.userInClass === "غائب" ? item?.userInClass : "زمان ورود: "+item?.userInClass?.presence_time}

                        </span>}
                        {item?.checkDateTime?.status == "on_time" &&
                            <a
                                className="btn btn-rounded btn-success-soft"
                                href="#"
                                onClick={(e) => handleClick(e, item)}
                            >
                                {Lang('public.login_to_class')}
                            </a>
                        }</>
                    }
                    
                </span>
            )
        },  
          { label: "date", jsx: (item) =><span> {item?.date}-{item?.start_hour}</span> },
          { label: "year_semester", jsx: (item) =><span> {getYearSemester(item.group, Lang)}</span> },
          { label: "group", jsx: (item) =><span>{getGroupCode(item.group, Lang)} </span> },
                    
          access ? {
              label: "report", jsx: (item) => ( item?.checkDateTime?.status == "before_time" ? "-" :
                  <Link className="btn btn-rounded btn-primary-soft" href={`${formUrl}${formUrl2!=null?item.course_id+formUrl2 : ""}/${item.id}/students`}>
                      {Lang('public.attendees')} ({item?.presence_count})
                  </Link>
              )
          } : "",
         
          {
              label: "",
              sort: false,
              width: "110px",
              jsx: (item) => (
                  <div className='flex justify-center '>
                      <FeatherIcon name="Edit" access={access}  displayIf={item?.checkDateTime?.status=="before_time"}
                          url={`${formUrl}${formUrl2!=null?item.course_id+formUrl2 : ""}/${item.id}/edit`} 
                          tooltip={Lang('public.edit')} />

                      <FeatherIcon name="Eye"
                          url={`${formUrl}${formUrl2!=null?item.course_id+formUrl2 : ""}/${item.id}`} 
                          tooltip={Lang('public.view')} />
                      <FeatherIcon name="Delete" access={access} displayIf={item?.checkDateTime?.status=="before_time"}
                          url={`${formUrl}${formUrl2 ? item.course_id + formUrl2 : ""}/${item.id}/canceledInsert`}
                          tooltip={Lang('public.canceledInsert')} />
                      <FeatherIcon displayIf={item?.is_cancel!=null} name="Delete" color="darkred" access={access}
                          onClick={() => destroy(laraPath + "/onlineClassroom/" + item.id+"/canceledRemove")}
                          
                          tooltip={Lang('public.canceledRemove')} />
                      <FeatherIcon displayIf={item?.checkDateTime?.status=="before_time"} name="XOctagon" access={access} tooltip={Lang('public.delete')} color="darkred" onClick={() => destroy(laraPath + "/onlineClassrooms/" + item.id)} />
                  </div>
              )
          },
      ],
  }), [url, Lang, formUrl, destroy, laraPath, access, getYearSemester, getGroupCode, handleClick]);
  
console.log(needles?.group);

    return (
        <Frame title={Lang(["public.onlineClassroom"])}>
             {access && (
                <Box shadow={false} minIcon={true} min={true}>
                    <YearGroupFilter isAdmin={isAdmin} needles={needles} Lang={Lang} filterList={handleFilterChange} />

                  {formUrl2 && (<>
                    <Input
                      options={{ onChange: (e) => handleFilterChange(e, "code") }}
                      dir="ltr"
                      className="col-span-2"
                      label="course_code"
                    />
                    <Input
                      defaultValue={getJalaliDate()}
                      options={{ onChange: (e) => handleFilterChange(e, "date") }}
                      dir="ltr"
                      className="col-span-2"
                      placeholder="1403/01/01"
                      label="date"
                    />
                    <Input
                      options={{ onChange: (e) => handleFilterChange(e, "hour") }}
                      dir="ltr"
                      className="col-span-2"
                      placeholder="10:00"
                      label="start_hour"
                    />
                   
                  </>
                  
              )}
                  <ButtonContainer className={formUrl2 ? "m-0" : "mt-5 pt-2"}>
                    <Button label="clear_filter" className="btn btn-secondary w-20" onClick={clearFilter} />
                  </ButtonContainer>
                </Box>
              )}
            
            <div className="intro-y col-span-12">
                <Grid {...info} key={url} />
                {formUrl2 == null ?
                <>
                    <ButtonContainer>
                        <CourseToolsBtn href={`${nextPath}/${menuPath}/${course}/tools`} />
                        <BackBtn onClick={back} />
                    </ButtonContainer>
                </>
                :<>
                    <ButtonContainer>
                        <Link className="btn btn-primary mr-1 ml-1" target="_blanket" href={`${mediaPath}/public/example_class_online.xlsx`}>{Lang(["public.example_excel"])}</Link>
                        <Link className="btn btn-success mr-1 ml-1" href={`${nextPath}/onlineClasses/excel`}>{Lang(["public.enter_excel"])}</Link>
                    </ButtonContainer>
                </>}
            </div>
        </Frame>
    );
}

const loading = '<svg id="a-loading" style="display: inline-block; margin: 0 6px" width="25" viewBox="0 0 120 30" xmlns="http://www.w3.org/2000/svg" fill="rgb(45, 55, 72)"><circle cx="15" cy="15" r="15"><animate attributeName="r" from="15" to="15" begin="0s" dur="0.8s" values="15;9;15" calcMode="linear" repeatCount="indefinite"></animate><animate attributeName="fill-opacity" from="1" to="1" begin="0s" dur="0.8s" values="1;.5;1" calcMode="linear" repeatCount="indefinite"></animate></circle><circle cx="60" cy="15" r="9" fill-opacity="0.3"><animate attributeName="r" from="9" to="9" begin="0s" dur="0.8s" values="9;15;9" calcMode="linear" repeatCount="indefinite"></animate><animate attributeName="fill-opacity" from="0.5" to="0.5" begin="0s" dur="0.8s" values=".5;1;.5" calcMode="linear" repeatCount="indefinite"></animate></circle><circle cx="105" cy="15" r="15"><animate attributeName="r" from="15" to="15" begin="0s" dur="0.8s" values="15;9;15" calcMode="linear" repeatCount="indefinite"></animate><animate attributeName="fill-opacity" from="1" to="1" begin="0s" dur="0.8s" values="1;.5;1" calcMode="linear" repeatCount="indefinite"></animate></circle></svg>';
