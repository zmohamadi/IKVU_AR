"use client";
import { useLang } from "@/lib/lang";
import { useEffect, useState } from "react";
import SideCalendar from "./SideCalendar";
import MyCalendar from "./MyCalendar";
import { useConfig } from "@/lib";
import axios from "@/lib/axios";


export default function Page() {
    const { Lang } = useLang();
    const [events, setEvents] = useState([])
    const { laraAdmin, laraDomain } = useConfig();

    useEffect(() => {
        getEvents()
    }, [])

    
    // const now = new Date();
    const now = new Date(+new Date() + 86400000);

    const getEvents = (startDate = null) => {
        let url = startDate == null ? laraDomain + laraAdmin + '/get-all-events'  : laraDomain + laraAdmin + '/get-all-events?startDate=' + startDate
        var colors = [{ backgroundColor: 'rgb(153, 255, 132)', color: 'rgb(16, 86, 6)' }, { backgroundColor: 'rgb(125, 195, 255)', color: 'rgb(13, 64, 118)' }, { backgroundColor: 'rgb(255, 184, 73)', color: 'rgb(80, 37, 4)' }, { backgroundColor: 'rgb(220, 38, 166)', color: 'rgb(255, 255, 255)' },
        { backgroundColor: '#fee2e7', color: '#c22440' }]
        
        const options = {
            url: url,
            method: 'GET',
            header: {
                'content-type': 'application/json',
            }
        }

        axios(options).then(res => {
            var data = []
            var codes = res?.data?.codes

            res?.data?.events?.map(($item, index) => {
                // var color = colors[index % colors.length] || colors[0]
                var x = { date: {}, id: index, style: '' };

                Object.keys($item).map((key) => {
                    if (key === 'title' || key === 'url' || key === 'code') {
                        if (key == 'code') {
                            let codeIndex = codes.findIndex(x => x == $item[key])
                            x.style = colors[codeIndex]
                        }else{
                            x[key] = $item[key];
                        }
                    } else {
                        var y = '';
                        
                        $item[key]?.map((keyDate, index) => {
                            switch (index) {
                                case 0:
                                    y += keyDate;
                                    break;
                                case 1:
                                case 2:
                                    if (keyDate.toString().length == 1) {
                                        y += '-' + '0' + keyDate;
                                    } else {
                                        y += '-' + keyDate
                                    }
                                    break;
                                case 3:
                                    y += ' ' + keyDate;

                                    break;
                                case 4:
                                    y += ':' + keyDate;

                                    break;

                                default:
                                    break;
                            }
                        })
                        x.date[key] = y;

                        if (key == 'start') {
                            x['start'] = y.split(' ')[1]
                        }

                        if (key == 'end') {
                            let endDate = new Date(y)
                            if (endDate > now) {
                                // x.style = colors[index < 5 ? index : Math.floor(Math.random() * 5)]
                                x.status = 'not-expire';
                            }else{
                                x.style = {backgroundColor: 'rgb(180, 180, 180)',color: 'rgb(214, 214, 214)'}
                                x.status = 'expire';
                            }
                        }
                    }
                })
                data.push(x);
            })

            setEvents(data)
        })
    }

    // function printCalendar() {
    //     var divContents = document.getElementById("customCalendar").innerHTML;
    //     var a = window.open('', '', 'height=500, width=500');
    //     a.document.write('<html>');
    //     a.document.write('<body > <h1>IKiu <br>');
    //     a.document.write(divContents);
    //     a.document.write('</body></html>');
    //     a.document.close();
    //     a.print();
    // }

    return <>
        <div className="content">
            <div className="intro-y flex flex-col sm:flex-row items-center mt-8">
                <h2 className="text-lg font-medium ml-auto">
                    {Lang('public.calendar')}
                </h2>
                {/* <div className="w-full sm:w-auto flex mt-4 sm:mt-0">
                    <button className="btn btn-primary shadow-md ml-2" onClick={() => printCalendar()}>پرینت برنامه</button>
                </div> */}
            </div>
            <div className="grid grid-cols-12 gap-5 mt-5">
                <SideCalendar events={events} key={Math.random()} />
                <MyCalendar getEvents={getEvents} events={events} />
            </div>
        </div>

    </>
}