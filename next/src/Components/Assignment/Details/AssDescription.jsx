"use client";

import { useLang } from "@/lib/lang";
import { FeatherIcon } from "@/Theme/Midone";
import { Files } from "@/Components/Assignment/Details";

export function AssDescription({ description,files,detail,correct="",options }) {
    const { Lang } = useLang();
    let attachments = (files)? files?.split("###") : [];

    return (
        <div className="post intro-y p-3 box">
            <p className="mb-5">
                <span className="font-bold">{description}</span>
            </p>
            {(options)?.map((option, index) => {
                let assignmentCalss = "col-span-12 pl-5";
                let color = "blue";
                if(correct)
                {
                    color = (detail[0]?.answer_option_id == correct)? "green" : "red";
                    assignmentCalss = (correct == option?.id)? "col-span-5 pl-5 bg-green-200" : "col-span-12 pl-5";
                }
                let displayIcon = (detail[0]?.answer_option_id == option?.id)? <FeatherIcon spanWrapperClass="display-inline pl-1" size="16" name="CheckCircle" color={color} /> : "";     
                
                return(
                    <p key={index} className={"mt-1 "+assignmentCalss} >
                        <strong>{index + 1+" ) "}</strong>{option?.title}
                        {displayIcon}
                    </p>
                );
            })}
            <div className="mt-3">
                <Files data={attachments} Lang={Lang} path="/assignment/" colorIcon="facebook" />
            </div>
        </div>
    );
}
