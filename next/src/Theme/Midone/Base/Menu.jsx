'use client'

import {config, useConfig} from '@/lib/config';
// import {icons} from '@/lib/icons';
import Link from 'next/link';
import * as Icon from 'react-feather';
import { useLang } from "@/lib/lang";
import { useEffect } from 'react';
// import cash from "cash-dom";
// import Velocity from "velocity-animate";
import tippy, { roundArrow } from "tippy.js";

export function Menu({prefix, menus})
{
    const {Lang} = useLang();
    let {adminMenuType} = useConfig();
    if(adminMenuType == "" || !adminMenuType) adminMenuType = "side";

    useEffect(()=>{                
        initMenu();
    }, [])

    const initMenu = async () => {
        const cash = (await import('cash-dom')).default;
        const Velocity = (await import('velocity-animate')).default;
        // Side Menu
        if(cash(".side-menu").data('click') == "fn") 
            return;
        cash(".side-menu").data('click', 'fn');
        cash(".side-menu").on("click", function () {
            if (cash(this).parent().find("ul").length) {
                if (
                    cash(this).parent().find("ul").first()[0].offsetParent !== null
                ) {
                    cash(this)
                        .find(".side-menu__sub-icon")
                        .removeClass("transform rotate-180");
                    cash(this).removeClass("side-menu--open");
                    Velocity(cash(this).parent().find("ul").first(), "slideUp", {
                        duration: 300,
                        complete: function (el) {
                            cash(el).removeClass("side-menu__sub-open");
                        },
                    });
                } else {
                    cash(this)
                        .find(".side-menu__sub-icon")
                        .addClass("transform rotate-180");
                    cash(this).addClass("side-menu--open");
                    Velocity(cash(this).parent().find("ul").first(), "slideDown", {
                        duration: 300,
                        complete: function (el) {
                            cash(el).addClass("side-menu__sub-open");
                        },
                    });
                }
            }
        });

        // Side menu tooltips
        let initTooltips = (function tooltips() {
            cash(".side-menu").each(function () {
                if (this._tippy == undefined) {
                    let content = cash(this)
                        .find(".side-menu__title")
                        .html()
                        .replace(/<[^>]*>?/gm, "")
                        .trim();
                    tippy(this, {
                        content: content,
                        arrow: roundArrow,
                        animation: "shift-away",
                        placement: "right",
                    });
                }

                if (
                    cash(window).width() <= 1260 ||
                    cash(this).closest(".side-nav").hasClass("side-nav--simple")
                ) {
                    this._tippy.enable();
                } else {
                    this._tippy.disable();
                }
            });

            return tooltips;
        })();

        window.addEventListener("resize", () => {
            initTooltips();
        });
    }

    return(
        <nav className={adminMenuType +'-nav'} key={adminMenuType +'-nav'}>
            <ul>
                {
                    menus.map((item, index)=>{
                        let ICN = Icon[item.icon];
                        if(item.childs?.length > 0)
                            return (<li key={index}>
                                        <a href='#' className={adminMenuType+"-menu"+(item.open?adminMenuType+'-menu--open': '')}>
                                            <div className={adminMenuType+'-menu__icon'}> 
                                                <ICN className="px-auto inline" />
                                            </div>
                                            <div className={adminMenuType+'-menu__title'}>
                                                {Lang('public.'+item.title)} 
                                                <div className={adminMenuType+'-menu__sub-icon transform rotate-180'}>
                                                    {item.open?<Icon.ChevronDown width={16} height={16} />: <Icon.ChevronUp width={16} height={16} />}
                                                </div>
                                            </div> 
                                        </a>
                                        <ul className={item.open?adminMenuType+'-menu__sub-open': ''}>
                                            {item.childs.map((child, index)=>{
                                                let CICN = Icon[child.icon];
                                                // console.log(child.icon);
                                                return <li key={index}>
                                                    <Link href={config.front()+prefix+child.href} className={adminMenuType+'-menu'}>
                                                        <div className={adminMenuType+'-menu__icon'}>
                                                            <CICN className="px-auto inline" />
                                                        </div>
                                                        <div className={adminMenuType+'-menu__title'}> {Lang('public.'+child.title)} </div>
                                                    </Link>
                                                </li>
                                            })}
                                        </ul>
                                    </li>);
                        else{
                            return <li key={index}>
                                        <Link href={config.front()+prefix+item.href} className={adminMenuType+'-menu'}>
                                            <div className={adminMenuType+'-menu__icon'}>
                                                <ICN className="px-auto inline" />
                                            </div>
                                            <div className={adminMenuType+'-menu__title'}> {Lang('public.'+item.title)} </div>
                                        </Link>
                                    </li>
                        }
                    })
                }
            </ul>
        </nav>
    );
}