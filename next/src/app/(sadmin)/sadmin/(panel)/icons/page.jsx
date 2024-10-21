"use client"

import { useState } from 'react';
import * as Icon from 'react-feather';

const IconsList = () => {
    let [search, setSearch] = useState();

    return <>
        <div className="grid grid-cols-12 gap-6 mt-8 px-5 mb-9">
            <div className="col-span-12">
                این آیکون های با استفاده از پکیج Featther ساخته شده اند.
                شیوه استفاده از آن های به این صورت می باشد. 
            </div>
            <div className="col-span-12">
                <input type="text" className="form-control" onChange={(e)=>setSearch(e.target.value)} placeholder="جستجوی آیکون" />
            </div>
            {
                Object.keys(Icon).filter((key)=>(search != "") ? key.search(search) > -1 : true).map((key, index) => { 
                    let ICN = Icon[key];
                    return <div className="col-span-2 p-5 text-center" key={index}>
                            <ICN className="px-auto inline" />
                            <div className="pt-4 block">{key}</div>
                        </div>
                })
            }
        </div>
    </>
}

export default IconsList;