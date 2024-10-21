"use client";

import {config} from "@/lib/config";
import {useDispatch} from "react-redux";
import {setLangs} from "@/redux/features/langSlice";
import axios from "@/lib/axios";
import React, { useEffect, useState } from "react";
import {Loading} from './Loading';
import { Next13ProgressBar } from 'next13-progressbar';

export function App({children, load}){
    const dispatch = useDispatch();
    const [loading, setLoading] = useState(true);

    const fetchLangs = async()=>{
        // let langResponse = await axios.get("/mastership/langs");
        // fetch(`https://...`, { cache: 'force-cache' | 'no-store' })
        let response = await fetch(config.host()+"/mastership/langs", {mode: "cors"});
        const langResponse = await response.json();
        await dispatch(setLangs(langResponse));
        setLoading(false);
    }

    useEffect(()=>{
        fetchLangs();
    }, []);
    
    if(loading){
        const LoadingComponent = load? load : Loading;
        return <><LoadingComponent key={"App_loading"} /></>;
    }else{    
        return <React.Fragment key="app_children">
            {children}
            <Next13ProgressBar height="4px" color="#EE870E" options={{ showSpinner: true }} showOnShallow />
        </React.Fragment>
    }
}

