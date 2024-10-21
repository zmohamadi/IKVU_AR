"use client";

import { useEffect, useState } from "react";
import { useLang } from "@/lib/lang";
import { SelectTail } from "@/Theme/Midone/Forms/SelectTail";
import { Input } from "@/Theme/Midone/Forms/Input";
import { DatePicker } from "@/Theme/Midone";

export function YearGroup({ component, needles, groupCount = 10 , showSemester = false, onGroupChange = null })
{
        const { Lang } = useLang();
        let [semester, setSemester] = useState();
        let [groupCode, setGroupCode] = useState();
        let [disabledGroup, setDisabledGroup] = useState(true);        
        let [selectedYear, setSelectedYear] = useState(true);        
        const [showSemesterInputs, setShowSemesterInputs] = useState(false);

        useEffect(() => {
                let group = component?.state?.info?.group || ""; // مطمئن شو که group رشته خالی نیست
                let semester = 0;
                let groupCode = "00";
                    
                funcDisabled("", group); // تابع برای تنظیم وضعیت فیلدهای غیرفعال
        
                if (group.length >= 5 && group > 0) { // اطمینان از اینکه رشته group حداقل 5 کاراکتر است
                        semester = group.substr(0, 5); // دریافت مقدار semester از اولین 5 کاراکتر
                        if (group.length >= 7 && parseInt(group.substr(5, 2)) > 0) { // بررسی طول رشته و معتبر بودن مقدار عددی
                                groupCode = group.substr(5, 2); // دریافت مقدار groupCode
                        }
                }
        
                setSemester(semester);
                setGroupCode(groupCode);
                setShowSemesterInputs(showSemester); // کنترل نمایش ورودی‌های semester
            }, [component?.state?.info]);
            
        const funcDisabled = (e="", group="")=>{
                let value = (group == "")? e.value : group;
                if(value != ""){
                        needles?.yearsemester.map(item=>{
                                if(value == item.year+item.semester){
                                        setSelectedYear(item);
                                }
                        })
                }else{
                        setSelectedYear({start_date:"", end_date:""});
                }
                if(value == "0")
                        setDisabledGroup(true);
                else
                        setDisabledGroup(false);
        };        
        
        let groups = [];
        for(let i=0; i <= groupCount; i++)
        {
            let valueId,valueNum = i;
            if(i<10) valueId="0"+i;
            if(i==0) valueNum=Lang("public.all_groups");
            groups.push({num:valueNum, id:valueId});
        }
        
        return <>
                <SelectTail className="col-span-6" label="semester" refItem={[component, "semester"]} defaultValue={semester}
                        key={"semester_"+needles?.yearsemester?.length} required="true" 
                        onChange={(e)=>{
                                onGroupChange && onGroupChange(e);
                                funcDisabled(e)
                        }} >
                        <>
                                <option key={1} value={0}>{Lang("public.all_time")}</option>
                                {
                                        (needles?.yearsemester)?.map((item, index)=>{
                                                return <option key={index} value={item?.year+item?.semester}>{item?.["year"]+" ("+Lang("public.semester")+" "+item?.semester+")"}</option>
                                        })
                                }
                        </>
                </SelectTail>
                <SelectTail className="col-span-6" id="group_code" label="group" refItem={[component, "group_code"]} defaultValue={groupCode}
                        data={groups} titleKey="num" titleValue="id" disabled={disabledGroup}
                        onChange = {(e)=>onGroupChange && onGroupChange(e)} />
                {showSemesterInputs && (
                <>
                    <DatePicker dir="ltr" label="start_date" refItem={[component, "start_date"]} defaultValue={selectedYear.start_date} />
                    <DatePicker dir="ltr" label="end_date" refItem={[component, "end_date"]} defaultValue={selectedYear.end_date} />
                </>
            )}
        </>;
}