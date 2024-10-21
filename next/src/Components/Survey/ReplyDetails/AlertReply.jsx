"use client";

import { useLang } from "@/lib/lang";
import { useRouter } from 'next/navigation';
import { useAuth } from "@/lib/auth";
import { ButtonContainer,Button } from "@/Theme/Midone/Forms";
import { FeatherIcon } from "@/Theme/Midone/Utils";
import { FormReply } from '@/Components/Survey/ReplyDetails/FormReply';

export function AlertReply({ data, result, id=0, course=0, laraPath="", nextPath="", questions=[] }){
        const {Lang} = useLang();
        const router = useRouter();
        const back = ()=>router.back();
        const { user } = useAuth({ guard: "admin" });
        const access = user?.role_id > 2;

        return <>
                <div className="alert alert-outline-warning alert-dismissible show items-center mb-2" role="alert">
                        <div className="flex">
                                <FeatherIcon name="AlertTriangle" className="w-4" />
                                <strong className="pt-1 pb-3 pr-3">{Lang("public."+result?.status)}</strong>
                        </div>
                        {Lang("public.replay_alert_title")+" از "}
                        <strong className="pl-2 pr-2" dir="ltr">{data?.start_date}</strong>{" تا "}
                        <strong className="pl-2 pr-2" dir="ltr">{data?.expire_date}</strong>{" می باشد."}
                </div>
                {(access)?
                        <FormReply id={id} course={course} laraPath={laraPath} nextPath={nextPath} questions={questions} /> 
                :
                        <ButtonContainer>
                                <Button label="back" onClick={back} />
                        </ButtonContainer>
                }
        </>;
}