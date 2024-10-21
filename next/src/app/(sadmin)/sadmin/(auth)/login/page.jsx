"use client"
// import useAuth from "@/lib/auth";
import { config } from "@/lib/config";

export default function Main(){    

    return <>
        <div className="container sm:px-10">
            <div className="block xl:grid grid-cols-2 gap-4">
                <div className="hidden xl:flex flex-col min-h-screen">
                    <a href="" className="-intro-x flex items-center pt-5">
                        <img alt="Icewall Tailwind HTML Admin Template" className="w-6" src={config.host()+"/admin/Midone-v3/Icewall_v1.0.9/dist/images/logo.svg"} />
                        <span className="text-white text-lg mr-3 adjust "> ایس<span className="font-medium">وال</span> </span>
                    </a>
                    <div className="my-auto">
                        <img alt="Icewall Tailwind HTML Admin Template" className="-intro-x w-1/2 -mt-16" src={config.host()+"/admin/Midone-v3/Icewall_v1.0.9/dist/images/illustration.svg"} />
                        <div className="-intro-x text-white font-medium text-4xl leading-tight mt-10">
                            تنها چند کلیک
                            <br /> مانده تا ساخت اکانتتان
                        </div>
                        <div className="-intro-x mt-5 text-lg text-white text-opacity-70 dark:text-gray-500">تمامی اکانت های خود را در یک مکان مدیریت کنید</div>
                    </div>
                </div>
                <div className="h-screen xl:h-auto flex py-5 xl:py-0 my-10 xl:my-0">
                    <div className="my-auto mx-auto xl:ml-20 bg-white dark:bg-dark-1 xl:bg-transparent px-5 sm:px-8 py-8 xl:p-0 rounded-md shadow-md xl:shadow-none w-full sm:w-3/4 lg:w-2/4 xl:w-auto">
                        <h2 className="intro-x font-bold text-2xl xl:text-3xl text-right xl:text-right ">
                            ورود
                        </h2>
                        <div className="intro-x mt-2 text-gray-500 xl:hidden text-center ">چند کلیک دیگر برای ورود به اکانت خود دارید . همه حساب های تجارت الکترونیکی خود را در یک مکان مدیریت کنید</div>
                        <div className="intro-x mt-8 ">
                            <input type="text " className="intro-x login__input form-control py-3 px-4 border-gray-300 block " placeholder="ایمیل " />
                            <input type="password " className="intro-x login__input form-control py-3 px-4 border-gray-300 block mt-4 " placeholder="رمزعبور " />
                        </div>
                        <div className="intro-x flex text-gray-700 dark:text-gray-600 text-xs sm:text-sm mt-4 ">
                            <div className="flex items-center ml-auto ">
                                <input id="remember-me" type="checkbox" className="form-check-input border ml-2" />
                                <label className="cursor-pointer select-none " htmlFor="remember-me ">مرا به خاطر داشته باش</label>
                            </div>
                            <a href=" ">فراموشی رمز عبور؟</a>
                        </div>
                        <div className="intro-x mt-5 xl:mt-8 text-right xl:text-right">
                            <button className="btn btn-primary py-3 px-4 w-full xl:w-32 xl:mr-3 align-top ">ورود</button>
                            <button className="btn btn-outline-secondary py-3 px-4 w-full xl:w-32 mt-3 xl:mt-0 align-top ">ثبت نام</button>
                        </div>
                        <div className="intro-x mt-10 xl:mt-24 text-gray-700 dark:text-gray-600 text-right xl:text-right">
                            با ورود شما تمامی شرایط زیر را میپذیرید
                            <br />
                            <a className="text-theme-17 dark:text-gray-300 " href=" ">قوانین و مقررات</a> و <a className="text-theme-17 dark:text-gray-300 " href=" ">حریم شخصی</a>
                        </div>
                    </div>
                </div>            
            </div>
        </div>
    </>
}