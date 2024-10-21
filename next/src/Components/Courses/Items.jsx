"use client"

import { useLang } from "@/lib/lang";
import {useConfig} from "@/lib/config";
import Link from "next/link";
import { FeatherIcon } from "@/Theme/Midone/Utils/FeatherIcon";
import React from "react";
import { useAuth, useUtility } from "@/lib";
import { Pic } from "@/Theme/Midone";

export const Items = ({item}) => {
    const {mediaPath,nextAdmin} = useConfig();
    const {Lang,local} = useLang();
    const { getYearSemester, getGroupCode } = useUtility();
    const { user } = useAuth({ guard: "admin" });
    const isStudent = user?.role_id == 2;

   
    const group = item?.presenteds?.[0]?.group;
    const teacherInfo = item?.presenteds?.[0]?.teacher;
    // console.log(teacherInfo);

    return <React.Fragment>
       <div className="intro-y col-span-12 md:col-span-6 xl:col-span-4 box">
            <div className="flex items-center border-b border-gray-200 dark:border-dark-5 px-5 py-4">
                <div className="w-10 h-10 flex-none image-fit">
                    <Pic src={`${mediaPath}/users/${teacherInfo?.photo}`} defaultImg={`${mediaPath}/public/default/avatar.png`} classImg="rounded-full" />
                </div> 
                <div className="mr-3 ml-auto">
                    {/* <Link href={!isStudent ?`${nextAdmin}/teachers/${teacherInfo?.id}` : "#"} className="font-medium"> */}
                    <Link href={`${nextAdmin}/myCourses/myTeachers/${teacherInfo?.id}`} className="font-medium">
                        {Lang('public.teacher')} {teacherInfo?.firstname} {teacherInfo?.lastname}
                    </Link>
                    <div className="flex text-gray-600 truncate text-xs mt-0.5"> <a className="text-theme-17 dark:text-gray-500 inline-block truncate" href="">
                    {getYearSemester(group, Lang)}</a> <span className="mx-1">•</span>{getGroupCode(group, Lang)}</div>
                </div>
                <div className="dropdown mr-3">
                    <FeatherIcon spanWrapperClass="dropdown-toggle w-5 h-5 text-gray-600 dark:text-gray-300" aria-expanded="false" name="MoreVertical" iconClassName="w-4 h-4" />
                    <div className="dropdown-menu w-40">
                        <div className="dropdown-menu__content box dark:bg-dark-1 p-2">
                            <Link href={`${nextAdmin}/myCourses/myTeachers/${teacherInfo?.id}`} className="flex items-center  p-2 transition duration-300 ease-in-out bg-white dark:bg-dark-1 hover:bg-gray-200 dark:hover:bg-dark-2 rounded-md">
                                {Lang('public.about')} {Lang('public.teacher')}
                            </Link>
                            <Link href={`${nextAdmin}/myCourses/${item?.code}`} className="flex items-center  p-2 transition duration-300 ease-in-out bg-white dark:bg-dark-1 hover:bg-gray-200 dark:hover:bg-dark-2 rounded-md">
                                {Lang('public.about')} {Lang('public.lesson')}
                            </Link>
                            <Link href={`${nextAdmin}/myCourses/${item?.code}/tools`} className="flex items-center  p-2 transition duration-300 ease-in-out bg-white dark:bg-dark-1 hover:bg-gray-200 dark:hover:bg-dark-2 rounded-md">
                                {Lang('public.view')} {Lang('public.lesson')}
                            </Link>
                        </div>
                    </div>
                </div>
            </div>
            <div className="p-5">
                    <Link href={`${nextAdmin}/myCourses/${item?.code}/tools`}>
                        <div className="h-40 xxl:h-56 image-fit">
                            <Pic src={`${mediaPath}/courses/${item?.thumbnail}`} defaultImg={`${mediaPath}/public/default/course.jpg`} key={"img"+item?.thumbnail} />
                        </div>
                    </Link>
                <Link href={`${nextAdmin}/myCourses/${item?.code}/tools`} className="block font-medium text-base mt-5">
                    {item?.title}
                </Link>
                <div className="text-gray-700 dark:text-gray-600 mt-2 text-justify" dangerouslySetInnerHTML={{ __html: item.description.substring(0, 250) + "..." }}></div>            </div>
            <div className="flex items-center px-5 py-3 border-t border-gray-200 dark:border-dark-5">
                <FeatherIcon
                    url={`${nextAdmin}/myCourses/${item?.code}/tools`}
                 iconClassName={"w-3 h-3"} spanWrapperClass="intro-x w-8 h-8 flex items-center justify-center rounded-full border border-gray-400 dark:border-dark-5 dark:bg-dark-5 dark:text-gray-300 text-gray-600 mr-2 tooltip" name="BookOpen" />
                <div className="intro-x flex mr-2">
                    {Lang('public.lesson_group')}: {item?.category?.title_fa}
                </div>
                <div className="flex mr-auto">
                    <FeatherIcon 
                        url={`${nextAdmin}/myCourses/myTeachers/${teacherInfo?.id}`} 
                        tooltip={Lang(['public.about','public.teacher'])} iconClassName={"w-3 h-3"} spanWrapperClass="intro-x w-8 h-8 flex items-center justify-center rounded-full bg-theme-31 dark:bg-dark-5 dark:text-gray-300 text-theme-26 mr-auto tooltip" name="User" />
                    <FeatherIcon 
                        url={`${nextAdmin}/myCourses/${item?.code}/tools`} 
                        tooltip={Lang(['public.view','public.lesson'])} iconClassName={"w-3 h-3"} spanWrapperClass="intro-x w-8 h-8 flex items-center justify-center rounded-full bg-theme-17 text-white mr-2 tooltip" name="Eye" />
                </div>
            </div>
           
        </div>
    </React.Fragment>
}