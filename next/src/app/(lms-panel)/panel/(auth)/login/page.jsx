"use client"
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useAuth } from "@/lib/auth";
import { useState } from "react";
import { loginPic } from "./loginSvg";

export default function Main(){
    const {Lang, local} = useLang();
    const {nextDomain, nextAdmin, laraDomain} = useConfig();
    const redirectIfAuthenticated = nextDomain + nextAdmin +"/dashboard";
    const {login} = useAuth({middleware: "guest", guard: "admin", redirectIfAuthenticated: redirectIfAuthenticated});
    let [user, setUser] = useState();
    let [pass, setPass] = useState();
    const [errors, setErrors] = useState([])
    const [status, setStatus] = useState(null)

    return <>
        <div className="container sm:px-10">
            <div className="block xl:grid grid-cols-2 gap-4">
                <div className="hidden xl:flex flex-col min-h-screen">
                    <a href="" className="-intro-x flex items-center pt-5">
                        <img alt="Icewall Tailwind HTML Admin Template" className="w-6" src={laraDomain+"/admin/Midone-v3/Icewall_v1.0.9/dist/images/logo.svg"} />
                        <span className="text-white text-lg ml-3 adjust "> {Lang('public.title_main')}<span className="font-medium">{Lang('public.title_sub')}</span> </span>
                    </a>
                    <div className="my-auto">
                        {/* <img alt="Icewall Tailwind HTML Admin Template" className="-intro-x w-1/2 -mt-16" src={laraDomain+"/admin/Midone-v3/Icewall_v1.0.9/dist/images/illustration.svg"} /> */}
                        {/* <img alt="Icewall Tailwind HTML Admin Template" className="-intro-x w-1/2 -mt-16" src={laraDomain+"/media/AnimationLogin.gif"} /> */}
                        {loginPic}
                        <div className="-intro-x text-white font-medium text-4xl leading-tight mt-10">
                            {Lang('public.text_main1')}
                            <br /> {Lang('public.text_main2')}
                        </div>
                        {/* <div className="-intro-x mt-5 text-lg text-white text-opacity-70 dark:text-gray-500">{Lang('public.text_sub')}</div> */}
                    </div>
                </div>
                <div className="h-screen xl:h-auto flex py-5 xl:py-0 my-10 xl:my-0" style={{"direction":"ltr"}}>
                    <div className="my-auto mx-auto xl:mr-20 bg-white dark:bg-dark-1 xl:bg-transparent px-5 sm:px-8 py-8 xl:p-0 rounded-md shadow-md xl:shadow-none w-full sm:w-3/4 lg:w-2/4 xl:w-auto">
                        {/* <h2 className="intro-x font-bold text-2xl xl:text-3xl text-right xl:text-right "> */}
                        <h2 className="intro-x font-bold text-2xl xl:text-3xl text-right xl:text-right ">
                            {Lang('public.login')}
                        </h2>
                        <div className="intro-x mt-2 text-gray-500 xl:hidden text-center ">{Lang('public.text_main_sm')}</div>
                        <div className="intro-x mt-8 ">
                            <input type="text" onChange={(e)=>setUser(e.target.value)} className="intro-x login__input form-control py-3 px-4 border-gray-300 block " placeholder={Lang('public.username')} />
                                {errors?.username? <div className="pristine-error text-theme-24 mt-2">{errors?.username}</div>: ""}
                            <input type="password" onChange={(e)=>setPass(e.target.value)} className="intro-x login__input form-control py-3 px-4 border-gray-300 block mt-4 " placeholder={Lang('public.password')} />
                                {errors?.password? <div className="pristine-error text-theme-24 mt-2">{errors?.password}</div>: ""}
                        </div>
                        <div className="intro-x flex text-gray-700 dark:text-gray-600 text-xs sm:text-sm mt-4 ">
                            {/* <a href=" ">{Lang('public.forget_password')}</a> */}
                            <div className="flex items-center ml-auto ">
                                <label className="cursor-pointer select-none " htmlFor="remember-me ">{Lang('public.remember_me')}</label>
                                <input id="remember-me" type="checkbox" className="form-check-input border ml-2" />
                            </div>
                        </div>
                        {/* <div className="intro-x mt-5 xl:mt-8 text-right xl:text-right"> */}
                        <div className="intro-x mt-5 xl:mt-8 text-left xl:text-left">
                            <button onClick={()=>login({username: user, password: pass, setErrors, setStatus})} className="btn btn-primary py-3 px-4 w-full xl:w-32 align-top ">{Lang('public.login')}</button>
                            {/* <button className="btn btn-outline-secondary py-3 px-4 w-full xl:w-32 mt-3 xl:mt-0 align-top ">{Lang('public.register')}</button> */}
                        </div>
                        {/* <div className="intro-x mt-10 xl:mt-24 text-gray-700 dark:text-gray-600 text-right xl:text-right"> */}
                        {/* <div className="intro-x mt-10 xl:mt-24 text-gray-700 dark:text-gray-600 text-left xl:text-left">
                            {Lang('public.acceptance_conditions')}
                            <br />
                            <a className="text-theme-17 dark:text-gray-300 " href=" ">{Lang('public.terms_and_conditions')}</a> {Lang('public.and')} <a className="text-theme-17 dark:text-gray-300 " href=" ">{Lang('public.privacy')}</a>
                        </div> */}
                    </div>
                </div>            
            </div>
        </div>
    </>
}