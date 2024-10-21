import Link from "next/link";
import { Fragment } from "react";
import { useLang } from "@/lib/lang"
import { usePathname } from 'next/navigation';
import * as Icon from 'react-feather';

export const Breadcrumb = () => {
    const pathname = usePathname();
    let pathArray = pathname.split("/"), lastpath = "";
    let breadcrumbArray = [];
    let {dir, Lang} = useLang();

    pathArray.forEach(element => {
        if(element != "") {
            lastpath += "/"+element;
            breadcrumbArray.push({label: element, path: lastpath})
        }
    });
    return <div className="text-sm">
        {
            breadcrumbArray.map((item, index)=> {
                return (index < breadcrumbArray.length -1 )
                    ?<Fragment key={index}>
                        <Link href={item.path}> {Lang("public."+item.label)} </Link> 
                        {dir == "ltr"?<Icon.ChevronRight className="inline-block" size='16' />: <Icon.ChevronLeft className="inline-block" size='16' />}
                    </Fragment>
                    :<Fragment key={index}>
                        {Lang("public."+item.label)}
                    </Fragment>
            })
        }
    </div>
}