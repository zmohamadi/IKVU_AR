"use client"

import Link from 'next/link'
import Panel from "./(lms-panel)/layout";
import "./404.css";
import { useEffect, useMemo } from 'react';
 
function NotFound() {
    useEffect(()=>{
        show404();
    });

    return (<>
        <div className="error">
            <div className="container-floud">
                <div className="col-xs-12 ground-color text-center">
                    <div className="container-error-404">
                        <div className="clip"><div className="shadow"><span className="digit thirdDigit"></span></div></div>
                        <div className="clip"><div className="shadow"><span className="digit secondDigit"></span></div></div>
                        <div className="clip"><div className="shadow"><span className="digit firstDigit"></span></div></div>
                        <div className="msg">OH!<span className="triangle"></span></div>
                    </div>
                    <h2 className="h1" style={{direction: "rtl"}}>متاسفانه صفحه مورد نظر یافت نشد!!</h2>
                </div>
            </div>
        </div>
    </>)
  return (<>
        <Panel>
            <div className="container">
                <div className="error-page flex flex-col lg:flex-row items-center justify-center h-screen text-right lg:text-right">
                    <div className="-intro-x lg:mr-20">
                        <img alt="Icewall Tailwind HTML Admin Template" className="h-48 lg:h-auto" src="dist/images/error-illustration.svg" />
                    </div>
                    <div className="text-white mt-10 lg:mt-0">
                        <div className="intro-x text-8xl font-medium">404</div>
                        <div className="intro-x text-xl lg:text-3xl font-medium mt-5">صفحه مورد نظر یافت نشد</div>
                        <div className="intro-x text-lg mt-3">ممکنه آدرس را اشتباه وارد کرده باشید یا این صفحه جا به جا شده باشد</div>
                        <button className="intro-x btn py-3 px-4 text-white border-white dark:border-dark-5 dark:text-gray-300 mt-10">برگشت به خانه</button>
                    </div>
                </div>
            </div>
        </Panel>
    </>
  )
}

const show404 = () => {
    function randomNum()
    {
        "use strict";
        return Math.floor(Math.random() * 9)+1;
    }
    var loop1,loop2,loop3,time=30, i=0, number, selector3 = window.document.querySelector('.thirdDigit'), selector2 = window.document.querySelector('.secondDigit'),
        selector1 = window.document.querySelector('.firstDigit');
    loop3 = setInterval(function()
    {
        "use strict";
        if(i > 40)
        {
            clearInterval(loop3);
            selector3.textContent = 4;
        }else
        {
            selector3.textContent = randomNum();
            i++;
        }
    }, time);
    loop2 = setInterval(function()
    {
        "use strict";
        if(i > 80)
        {
            clearInterval(loop2);
            selector2.textContent = 0;
        }else
        {
            selector2.textContent = randomNum();
            i++;
        }
    }, time);
    loop1 = setInterval(function()
    {
        "use strict";
        if(i > 100)
        {
            clearInterval(loop1);
            selector1.textContent = 4;
        }else
        {
            selector1.textContent = randomNum();
            i++;
        }
    }, time);
}
export default NotFound;