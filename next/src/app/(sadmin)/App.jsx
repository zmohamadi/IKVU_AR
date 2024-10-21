"use client";

import {config} from "@/lib/config";
import {useDispatch} from "react-redux";
import {setLangs} from "@/redux/features/langSlice";
import axios from "@/lib/axios";
import React, { useEffect, useState } from "react";
import {Loading} from './Loading';
import { Next13ProgressBar } from 'next13-progressbar';

export function App({children}){
    const dispatch = useDispatch();
    const [loading, setLoading] = useState(true);

    const fetchLangs = async()=>{
        // let langResponse = await axios.get(config.host()+"/mastership/langs");
        // await dispatch(setLangs(langResponse.data));
        let response = await fetch(config.host()+"/mastership/langs", {mode: "cors"});
        const langResponse = await response.json();
        await dispatch(setLangs(langResponse));
        setLoading(false);
    }

    useEffect(()=>{
        fetchLangs();
        // $('body').css('padding', "15px 28px");
    }, []);
    
    if(loading){
        return <><Loading key={"App_loading"} /></>;
    }else{    
        return <React.Fragment key="app_children">
            {children}
            {/* <Next13ProgressBar height="4px" color="#0A2FFF" options={{ showSpinner: true }} showOnShallow /> */}
            <Next13ProgressBar height="4px" color="#EC6D45" options={{ showSpinner: true }} showOnShallow />
        </React.Fragment>
    }
}

