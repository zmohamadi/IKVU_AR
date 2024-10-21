"use client"

import {useConfig} from "@/lib/config";

const MenuItem = (item) => {
    const {laraDomain} = useConfig();
    return <>
        <div className="intro-y col-span-12 md:col-span-6 lg:col-span-4">
            <div className="box">
                <div className="flex items-start px-5 pt-5">
                    <div className="w-full flex flex-col lg:flex-row items-center">
                        <div className="w-16 h-16 image-fit">
                            <img alt="Icewall Tailwind HTML Admin Template" className="rounded-full" src={laraDomain+"/admin/Midone-v3/Icewall_v1.0.9/dist/images/profile-10.jpg"} />
                        </div>
                        <div className="lg:mr-4 text-right lg:text-right mt-3 lg:mt-0">
                            <a href="" className="font-medium">تام کروز</a> 
                            <div className="text-gray-600 text-xs mt-0.5">مهندس نرم افزار</div>
                        </div>
                    </div>
                    <div className="absolute left-0 top-0 ml-5 mt-3 dropdown" data-placement="bottom-start">
                        <a className="dropdown-toggle w-5 h-5 block" href="#" aria-expanded="false"> <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" className="feather feather-more-horizontal w-5 h-5 text-gray-600 dark:text-gray-300"><circle cx="12" cy="12" r="1"></circle><circle cx="19" cy="12" r="1"></circle><circle cx="5" cy="12" r="1"></circle></svg> </a>
                        <div className="dropdown-menu w-40">
                            <div className="dropdown-menu__content box dark:bg-dark-1 p-2">
                                <a href="" className="flex items-center block p-2 transition duration-300 ease-in-out bg-white dark:bg-dark-1 hover:bg-gray-200 dark:hover:bg-dark-2 rounded-md"> <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" className="feather feather-edit-2 w-4 h-4 ml-2"><path d="M17 3a2.828 2.828 0 1 1 4 4L7.5 20.5 2 22l1.5-5.5L17 3z"></path></svg> ویرایش</a>
                                <a href="" className="flex items-center block p-2 transition duration-300 ease-in-out bg-white dark:bg-dark-1 hover:bg-gray-200 dark:hover:bg-dark-2 rounded-md"> <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" className="feather feather-trash w-4 h-4 ml-2"><polyline points="3 6 5 6 21 6"></polyline><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg> حذف </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div className="text-center lg:text-right p-5">
                    <div> در این صورت می توان امید داشت که تمام و
                        دشواری موجود در ارائه راهکارها و شرایط سخت تایپ به پایان رسد وزمان مورد نیاز
                        شامل حروفچینی دستاوردهای ا </div>
                    <div className="flex items-center justify-center lg:justify-start text-gray-600 mt-5"> <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" className="feather feather-mail w-3 h-3 ml-2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg> tomcruise@left4code.com </div>
                    <div className="flex items-center justify-center lg:justify-start text-gray-600 mt-1"> <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" className="feather feather-instagram w-3 h-3 ml-2"><rect x="2" y="2" width="20" height="20" rx="5" ry="5"></rect><path d="M16 11.37A4 4 0 1 1 12.63 8 4 4 0 0 1 16 11.37z"></path><line x1="17.5" y1="6.5" x2="17.51" y2="6.5"></line></svg> تام کروز </div>
                </div>
                <div className="text-center lg:text-left p-5 border-t border-gray-200 dark:border-dark-5">
                    <button className="btn btn-primary py-1 px-2 ml-2">پیام</button>
                    <button className="btn btn-outline-secondary py-1 px-2">پروفایل</button>
                </div>
            </div>
        </div>
    </>
}

export { MenuItem };