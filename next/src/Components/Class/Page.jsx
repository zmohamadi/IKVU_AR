"use client";
import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { useConfig } from "@/lib/config";
import { useLang } from "@/lib/lang";
import { useData } from "@/Theme/Midone/Utils";
import { Box, Button, ButtonContainer, Input } from "@/Theme/Midone/Forms";
import { Select } from "@/Theme/Midone/Forms/Select";
import { Grid, Frame } from "@/Theme/Midone/Utils";
import { FeatherIcon } from "@/Theme/Midone/Utils/FeatherIcon";
import { useUtility } from "@/lib";
import { YearGroupFilter } from "../Public/YearGroupFilter";

const CourseFilters = ({ params, setParams, needles, local, Lang }) => {
  const urlItems = useMemo(() => {
    return Object.keys(params)
        .filter(key => params[key])
        .map(key => `${key}=${params[key]}`)
        .join("&");
}, [params]);
const handleFilterChange = (e, filter) => {
  setParams(prev => ({ ...prev, [filter]: e.target.value }));
};


const clearFilter = useCallback(() => {
  setParams({ semester: "", group: "" ,code:"" });
}, []);

  return (
    <Box shadow={false} minIcon={true} min={true}>
        <YearGroupFilter needles={needles} Lang={Lang} filterList={handleFilterChange} />
        <Input
            options={{ onChange: (e) => handleFilterChange(e, "code") }}
            dir="ltr"
            className="col-span-3"
            label="course_code"
          />
       
      <ButtonContainer className="mt-5">
        <Button label="clear_filter" className="btn btn-secondary w-20 mt-2" onClick={clearFilter} />
      </ButtonContainer>
    </Box>
  );
};

const CourseGrid = ({ info }) => {
  return (
    <div className="intro-y col-span-12">
      <Grid {...info} key={info.url} />
    </div>
  );
};

const Actions = ({ item, access, Lang, laraAdmin, formUrl,course, nextAdmin, destroy }) => (
  <div className="flex justify-center">
    <FeatherIcon name="Users" access={access} url={`${nextAdmin}/courses/${course==0?item?.code:course}/present/${item.id}/students`} tooltip={Lang('public.students')} />
    <FeatherIcon name="Edit" access={access} url={`${nextAdmin}/courses/${course==0?item?.code:course}/present/${item.id}/edit`} tooltip={Lang('public.edit')} />
    <FeatherIcon name="Eye" url={`${nextAdmin}/courses/${course==0?item?.code:course}/present/${item.id}`} tooltip={Lang('public.view')} />
    <FeatherIcon displayIf={item?.count_students==0} name="XOctagon" access={access} tooltip={Lang('public.delete')} color="darkred" onClick={() => destroy(`${laraAdmin + formUrl}/${item.id}`)} />
  </div>
);

export function Page({ course = 0, access, isAdmin }) {
  const { mediaPath, laraAdmin, nextAdmin } = useConfig();
  const { Lang, local } = useLang();
  const { destroy, getNeedles } = useData();
  const { getYearSemester, getGroupCode } = useUtility();

  const [needles, setNeedles] = useState();

  const [params, setParams] = useState({ semester: "", group: "",code:"", course });
  const [url, setUrl] = useState(`${laraAdmin}/classes${course ? `?course=${course}` : ""}`);
  const effectRan = useRef(false);

  const formUrl = "/classes";

  useEffect(() => {
    if (!effectRan.current) {
      getNeedles(`${laraAdmin}${formUrl}/get-needles`, setNeedles);
      effectRan.current = true;
    }
  }, [getNeedles, laraAdmin, formUrl]);

  useEffect(() => {
    const queryString = Object.entries(params)
      .filter(([, value]) => value)
      .map(([key, value]) => `${key}=${value}`)
      .join("&");
    setUrl(`${laraAdmin}/classes?${course ? `course=${course}&` : ""}${queryString}`);
  }, [params, course, laraAdmin]);

  const info = {
    insertLink: access && course ? `${nextAdmin}/courses/${course}/present/new` : "",
    perPage:20,
    url,
    columns: [
      // { label: "class", field: "course.title" },
      { label: "class", jsx: (item) =><span>{item?.course?.title} {Lang('public.group')}{getGroupCode(item.group, Lang)}</span>  },
      { label: "course_code", field: "course.code" },
      { label: "year_semester", jsx: (item) => getYearSemester(item.group, Lang) },
      // { label: "group", jsx: (item) =>getGroupCode(item.group, Lang) },
      { label: "teacher", jsx: (item) => <span>{item?.teacher?.firstname} {item?.teacher?.lastname}</span> },
      { label: "system", field: "course.system.title" },
      { label: "lesson_group", jsx: (item) => <span>{item?.course?.category?.[`title_${local}`]} </span> },
      //access ?{label: "creator", jsx: (item)=><span>{item.creator?.firstname+" "+item.creator?.lastname}</span>}:"",
      // access ?{label: "editor", jsx: (item)=><span>{item.editor?.firstname+" "+item.editor?.lastname}</span>}:"",
      access ? { label: "count_students", field: "count_students" } : null,
      { label: "", sort: false, width: "110px", jsx: (item) => (
        <Actions 
          item={item} 
          course={course} 
          access={access} 
          Lang={Lang} 
          laraAdmin={laraAdmin} 
          formUrl={formUrl} 
          nextAdmin={nextAdmin} 
          destroy={destroy} 
        />
      ) },
    ].filter(Boolean),
  };

  return (
    <Frame title={Lang(["public.classes"])}>
      <CourseFilters params={params} setParams={setParams} needles={needles} local={local} Lang={Lang} />
      <CourseGrid info={info} />
    </Frame>
  );
}
