"use client";
import { useLang } from "@/lib/lang";
import { formatDate } from '@fullcalendar/core'
import Link from "next/link";

export default function SideCalendar({ events }) {
    const { Lang } = useLang();
    
    events = events.sort((a, b) => b.status.localeCompare(a.status));
    
    return <>
        <div className="col-span-12 xl:col-span-4 xxl:col-span-3">
            <div className="box p-5 intro-y">
                <button type="button" className="btn btn-primary w-full mt-2"> <i className="w-4 h-4 ml-2" data-feather="edit-3"></i>برنامه</button>
                <div className="border-t border-b border-gray-200 dark:border-dark-5 mt-6 mb-5 py-3" id="calendar-events">
                    {
                        events?.length > 0 ? events.map((ev) => {
    
                            return <div className="relative">
                                <div className="event p-3 -mx-3 cursor-pointer transition duration-300 ease-in-out hover:bg-gray-200 dark:hover:bg-dark-1 rounded-md flex items-center"  style={ev.status == 'expire' ? {cursor: 'not-allowed'} : {}}>
                                    <div className="w-2 h-2 bg-theme-22 rounded-full ml-3" style={ev.status == 'expire' ? {backgroundColor: '#f70a0a'} : { backgroundColor: ev?.style?.backgroundColor }}></div>
                                    <div className="pl-10">
                                        <div className="event__title">
                                            {
                                                ev.url && ev.status == 'not-expire' ? <Link href={ev.url} >
                                                    {ev.title}
                                                </Link>
                                                    : <span style={ev.status == 'expire' ? {color: ev.style.color} : {}}>
                                                        {ev.title}
                                                    </span>
                                            }

                                        </div>
                                        <b style={ev.status == 'expire' ? {color: ev.style.color} : {}}>{formatDate(ev.date?.start, { year: 'numeric', month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric', locale: 'fa' })}</b>
                                        {/* <div className="text-gray-600 text-xs mt-0.5"> <span className="event__days">2</span> روز <span className="mx-1">•</span> 10:00 عصر </div> */}
                                    </div>
                                </div>
                                {/* <a className="flex items-center absolute top-0 bottom-0 my-auto left-0" href=""> <i data-feather="edit" className="w-4 h-4 text-gray-600"></i> </a> */}
                            </div>
                        }) :
                            <div className="text-gray-600 p-3 text-center" id="calendar-no-events"> بدون رویداد </div>
                    }
                </div>
            </div>
        </div>
    </>
}