"use client";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { Grid, Frame, FeatherIcon, Tools, useData, useFormRefs} from "@/Theme/Midone/Utils";
import { useEffect, useState } from "react";
import { Box, Button, ButtonContainer } from "@/Theme/Midone/Forms";
import { useRouter } from "next/navigation";
import { Select } from "@/Theme/Midone/Forms/Select";

export function StudentStatus({laraPath,nextPath,course}){
    const router = useRouter();
    const back = ()=>router.back();
    const {Lang, local} = useLang();
    const {mediaPath } = useConfig();
    let component = useFormRefs();
    let {postData, get} = useData();
    useEffect(() => {
        get(laraPath+"/courses/change-status/get-needles", component, "info");
    }, []);

    const changeStatus = (e, id)=>{
        postData(laraPath+"/courses/change-status/"+course+"/"+id, {status_id: e.target.value})
    }
    let [params, setParams] = useState([]);
    let [url, setUrl] = useState(laraPath+"/courses/"+course+"/students");

    let info = {
        url: url,
        columns: [
            {label: "", jsx:(item)=><img className="rounded-full" src={mediaPath+"/users/"+item.pic} width={50} height={50} alt="student" />},
            {label: "name", field: "name"},
            {label: "lname", field: "lname"},
            {label: "email", field: "email"},
            {label: "mobile", field: "mobile"},
            {label: "request",  jsx: (item)=><span className={item?.enroll[0]?.req_status?.color}>{item?.enroll[0]?.req_status?.["title_"+local]}</span>},
            {label: "change_request",  
            jsx: (item)=><Select
                            onChange={(e)=>changeStatus(e, item.id)}
                            defaultValue={item?.enroll[0]?.status_id} >
                                {Tools.getArray(component?.state?.info).map((s, index)=>
                                    <option key={index} value={s.code}> {s["title_"+local]} </option>
                                )}
                        </Select>
            },
            
            {label: "",
                sort:false, 
                jsx:(item)=><>
                    <div className='flex justify-center '>
                        <FeatherIcon name="Droplet" url={nextPath+"/courses/"+course+"/student/"+item.id+"/reports"} tooltip={Lang('public.reports')} />
                        <FeatherIcon name="Gift" url={nextPath+"/courses/"+course+"/student/"+item.id+"/report-card"} tooltip={Lang('public.report_card')} />
                    </div>
                </>
            },
        ],
    }
    useEffect(() => {
        let items = params.join(",");
        setUrl(laraPath+"/courses/"+course+"/students?status="+items);
    }, [params]);

    const filterList = (filter)=>{
        let key = params.indexOf(filter);
        if(key == -1){
            params.push(filter);
        }else{
            params.splice(key, 1);
        }
        setParams([...params]);
    }

    const setClass = (item, btnClass) => {
        return "col-span-2 btn "+ btnClass+ (params.indexOf(item) == -1? " btn-secondary-soft": "")
    }

    const getLabel = (label, item) => {
        return <>
                    { (params.indexOf(item) == -1) ? 
                        <FeatherIcon name="Square" spanWrapperClass="mx-2" />
                        : <FeatherIcon name="Check" spanWrapperClass="mx-2" />
                    }
                    {Lang('public.'+label)}
                </>
    }


    return(
        <Frame title={Lang(["public.students"])}>
           <Box shadow={false}>
                    <Button label={getLabel("requested", "requested")} onClick={()=>filterList("requested")} className={setClass('requested', 'btn-primary')} />
                    <Button label={getLabel("accepted", "accepted")} onClick={()=>filterList("accepted")} className={setClass('accepted', "btn-success")} />
                    <Button label={getLabel("rejected", "rejected")} onClick={()=>filterList("rejected")} className={setClass('rejected', 'btn-warning')} />
                    <Button label={getLabel("deleted", "deleted")} onClick={()=>filterList("deleted")} className={setClass('deleted', 'btn-danger')} />
            </Box>
            <div className="intro-y col-span-12">
                <Grid {...info} key={url} />
                <ButtonContainer>
                    <Button label="back" onClick={back} />
                </ButtonContainer>
            </div>
        </Frame>
    );
}