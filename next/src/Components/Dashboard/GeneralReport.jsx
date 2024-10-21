"use client";
import { FeatherIcon } from "@/Theme/Midone";
// import { useEffect, useState } from "react";
import { useLang } from "@/lib/lang";


export function GeneralReport({data}){

    const {Lang,local} = useLang();
    console.log(data);

    return<>
            <div className="col-span-12 mt-8">
                
                <div className="grid grid-cols-12 gap-6 mt-5">
                    <div className="col-span-12 sm:col-span-6 xl:col-span-2 intro-y">
                        <div className="report-box zoom-in">
                            <div className="box text-center p-5">
                                <FeatherIcon color="green"  className="report-box__icon" name="Book"/>
                                <div className="text-3xl font-bold leading-8 mt-6">{data?.[0]?.count}</div>
                                <div className="text-base text-gray-600 mt-1">{Lang('public.courses')}</div>
                            </div>
                        </div>
                    </div>
                    
                    <div className="col-span-12 sm:col-span-6 xl:col-span-2 intro-y">
                        <div className="report-box zoom-in">
                            <div className="box text-center p-5">
                                <FeatherIcon color="orange"  className="report-box__icon" name="Star"/>
                                <div className="text-3xl font-bold leading-8 mt-6">{data?.[2]?.count}</div>
                                <div className="text-base text-gray-600 mt-1"> {Lang('public.teachers')}</div>
                            </div>
                        </div>
                    </div>
                   
                    <div className="col-span-12 sm:col-span-6 xl:col-span-2 intro-y">
                        <div className="report-box zoom-in">
                            <div className="box text-center p-5">
                                <FeatherIcon color="blue"  className="report-box__icon" name="Slack"/>
                                <div className="text-3xl font-bold leading-8 mt-6">{data?.[3]?.count}</div>
                                <div className="text-base text-gray-600 mt-1"> {Lang('public.students')}</div>
                            </div>
                        </div>
                    </div>
                    <div className="col-span-12 sm:col-span-6 xl:col-span-2 intro-y">
                        <div className="report-box zoom-in">
                            <div className="box text-center p-5">
                                <FeatherIcon color="brown"  className="report-box__icon" name="Package"/>
                                <div className="text-3xl font-bold leading-8 mt-6">{data?.[7]?.count}</div>
                                <div className="text-base text-gray-600 mt-1"> {Lang('public.learnpath')}</div>
                            </div>
                        </div>
                    </div>
                    
                    <div className="col-span-12 sm:col-span-6 xl:col-span-2 intro-y">
                        <div className="report-box zoom-in">
                        <div className="box text-center p-5">
                                <FeatherIcon color="red"  className="report-box__icon" name="BookOpen"/>
                                <div className="text-3xl font-bold leading-8 mt-6">{data?.[5]?.count}</div>
                                <div className="text-base text-gray-600 mt-1">{Lang('public.onlineClasses')}</div>
                            </div>
                        </div>
                    </div>
                    <div className="col-span-12 sm:col-span-6 xl:col-span-2 intro-y">
                        <div className="report-box zoom-in">
                            <div className="box text-center p-5">
                                <FeatherIcon color="aqua"  className="report-box__icon" name="Monitor"/>
                                <div className="text-3xl font-bold leading-8 mt-6">{data?.[4]?.count}</div>
                                <div className="text-base text-gray-600 mt-1"> {Lang('public.quizs')}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </>;
}