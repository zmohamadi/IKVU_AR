"use client";
import { useEffect, useRef, useState } from "react";
import { useConfig } from "@/lib/config";
import { useLang } from "@/lib/lang";
import { Pic, useData } from "@/Theme/Midone/Utils";
import { Box, Button, ButtonContainer } from "@/Theme/Midone/Forms";
import { Select } from "@/Theme/Midone/Forms/Select";
import { Grid, Frame } from "@/Theme/Midone/Utils";
import { FeatherIcon } from "@/Theme/Midone/Utils/FeatherIcon";
import Link from 'next/link';

const CourseFilters = ({ params, setParams, needles, local, Lang }) => {
  const handleFilterChange = (e, filter) => {
    setParams((prevParams) => ({ ...prevParams, [filter]: e.target.value }));
  };

  const clearFilter = () => {
    setParams({ category: "", status: "",system:"" });
  };

  return (
    <Box shadow={false} minIcon={true} min={true} cols={"grid-cols-10"}>
      <Select
        defaultValue={params.category}
        onChange={(e) => handleFilterChange(e, "category")}
        className="col-span-5 md:col-span-3"
        label="lesson_group"
        data={needles?.coursecategory}
        titleKey={"title_" + local}
      />
      <Select
        defaultValue={params.system}
        onChange={(e) => handleFilterChange(e, "system")}
        className="col-span-5 md:col-span-3"
        label="system"
        data={needles?.system}
      />
      <Select
        defaultValue={params.status}
        onChange={(e) => handleFilterChange(e, "status")}
        className="col-span-5 md:col-span-3"
        label="status"
      >
        <option key={1} value={1}> {Lang(["public.active"])} </option>
        <option key={0} value={0}> {Lang(["public.inactive"])} </option>
      </Select>
      <ButtonContainer className="mt-7 md:mt-6 text-right ">
        <Button label="clear_filter" className="btn btn-secondary w-20" onClick={clearFilter} />
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

const CourseActions = ({ item, access, Lang, laraPath, formUrl, nextPath, destroy }) => (
  <div className="flex justify-center">
    <FeatherIcon name="Settings" url={`${nextPath + formUrl}/${item.code}/tools`} tooltip={Lang('public.tools')} />
    <FeatherIcon name="BookOpen" url={`${nextPath + formUrl}/${item.code}/present`} tooltip={Lang('public.classes')} />
    <FeatherIcon name="Edit" access={access} url={`${nextPath + formUrl}/${item.code}/edit`} tooltip={Lang('public.edit')} />
    <FeatherIcon name="Eye" url={`${nextPath + formUrl}/${item.code}`} tooltip={Lang('public.view')} />
    <FeatherIcon displayIf={!(item?.count_presented > 0)} name="XOctagon" access={access} tooltip={Lang('public.delete')} color="darkred" onClick={() => destroy(`${laraPath + formUrl}/${item.code}`)} />
  </div>
);

export function Page({ laraPath, nextPath, access }) {
  const { mediaPath } = useConfig();
  const { Lang, local } = useLang();
  const { destroy, getNeedles } = useData();
  const [ needles, setNeedles ] = useState();
  const [ params, setParams ] = useState({ category: "", status: "",system:"" });
  const [ url, setUrl ] = useState(`${laraPath}/courses`);
  const effectRan = useRef(false);
  const formUrl = "/courses"; // تعریف formUrl

  useEffect(() => {
    if (!effectRan.current) {
      getNeedles(`${laraPath}${formUrl}/get-needles`, setNeedles);
      effectRan.current = true;
    }
  }, [getNeedles, laraPath, formUrl]);

  useEffect(() => {
    const urlItems = Object.keys(params)
      .filter(key => params[key] !== "")
      .map(key => `${key}=${params[key]}`)
      .join("&");
    setUrl(`${laraPath}/courses?${urlItems}`);
  }, [params, laraPath]);

  const info = {
    insertLink: access ? `${nextPath}${formUrl}/new` : "",
    perPage:20,
    url: url,
    columns: [
      // { label: "less_id", field: "less_id" },
      { label: "", minWidth:"70px", jsx:(item)=><Pic src={`${mediaPath}/courses/${item?.thumbnail}`} defaultImg={`${mediaPath}/public/default/course.jpg`} classImg="user-avatar" key={"img"+item?.thumbnail} />},
      { label: "course", minWidth:"180px", jsx:(item)=><Link href={`${nextPath + formUrl}/${item.code}/tools`}>{item.title}</Link> },
      { label: "course_code", field: "code" },
      { label: "system", minWidth:"110px", field: "system.title" },
      { label: "lesson_group", field: `category.title_${local}` },
      { label: "class", field: "count_presented" },
      //access ?{label: "creator", jsx: (item)=><span>{item.creator?.firstname+" "+item.creator?.lastname}</span>}:"",
      // access ?{label: "editor", jsx: (item)=><span>{item.editor?.firstname+" "+item.editor?.lastname}</span>}:"",
      { label: "status", jsx: (item) => <span className={`text-${item?.active_status?.color}`}>{item?.active_status?.[`title_${local}`]}</span> },
      { label: "", sort: false, width: "110px", jsx: (item) => <CourseActions item={item} access={access} Lang={Lang} laraPath={laraPath} formUrl={formUrl} nextPath={nextPath} destroy={destroy} /> },
    ],
  };

  return (
    <Frame title={Lang(["public.courses"])}>
      <CourseFilters key={params} params={params} setParams={setParams} needles={needles} local={local} Lang={Lang} />
      <CourseGrid info={info} />
    </Frame>
  );
}
