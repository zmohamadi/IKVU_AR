"use client";
import { useEffect,useState } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import Link from "next/link";
import { Button,ButtonContainer,FeatherIcon,useData,useFormRefs,Input,Pic } from "@/Theme/Midone";
import { useAuth } from "@/lib/auth";

export default function ViewProfile(){
    const { laraAdmin,nextAdmin,mediaPath } = useConfig();
    const { Lang,local } = useLang();
    let { save,get } = useData();
    let component = useFormRefs();
    const { user } = useAuth({guard: "admin"});
    const id = user?.id;
    let url = `${laraAdmin}/users/show-info/${id}`;

    const getItem = ()=>{ get(url, component, "info"); }
    const saveItem = ()=>{
        save(`${laraAdmin}/users/edit-email/${id}`, component, 'edit', "", ()=>{
            changeDisplayForm(false);
            getItem();
        });
    }
    
    useEffect(() => { getItem(); }, [] );

    let [displayForm, setDisplayForm] = useState(false);
    const changeDisplayForm = (flag=true)=>{ setDisplayForm(flag); }

    const data = component?.state?.info?.item;
    const gender = data?.gender?.["title_" + local] + (data?.gender_id == 1 ? Lang(["public.y"]) + " " : "");
    let borderL = "";
    let borderT = "";
    let displayResume = "";
    if(data?.resume)
    {
        borderL = "border-l";
        borderT = "border-t";
        displayResume = <>
                <h4 className="text-xl font-medium leading-none mt-3">{Lang("public.resume")}</h4>
                <div className="truncate sm:whitespace-normal flex items-center mt-3"> {data?.resume?? "---"} </div>;
            </>
    }
    
    return(
        <>
            <div class="intro-y flex items-center mt-8">
                <h2 class="text-lg font-medium ml-auto">{Lang("public.profile")}</h2>
            </div>
            {(data == undefined)?
                <div className="col-span-12 md:col-span-12 xxl:col-span-12 mt-3 xxl:mt-6">
                    <span className="alert alert-success-soft show flex items-center mb-2 mt-5">{Lang("public.grid_loading")+"....."}</span>
                </div>
            :
                <div className="intro-y box px-5 pt-5 mt-5">
                    <div className="flex flex-col lg:flex-row border-b border-gray-200 dark:border-dark-5 pb-5 -mx-5">
                        <div className="flex flex-1 px-5 items-center lg:justify-start">
                            <div className="w-20 h-20 sm:w-40 sm:h-24 flex-none lg:w-32 lg:h-32 image-fit relative">
                                <Pic src={`${mediaPath}/users/${data?.photo}`} defaultImg={`${mediaPath}/public/default/avatar.png`} classImg="rounded-full" key={"img"+data?.photo} />
                            </div>
                            <div className="mr-5">
                                <div className="w-full sm:w-40 truncate sm:whitespace-normal font-medium text-lg">{gender+" "+data?.firstname+" "+data?.lastname}</div>
                                <div className="text-gray-600">{data?.role?.["title_" + local]}</div>
                            </div>
                        </div>
                        <div className={"mt-6 lg:mt-0 flex-1 dark:text-gray-300 px-5 border-r border-gray-200 dark:border-dark-5 border-t lg:border-t-0 pt-5 lg:pt-0 "+borderL}>
                            <h4 className="text-xl font-medium leading-none mt-3">{Lang("public.detail")}</h4>
                            {/* <div className="font-medium text-center0 lg:text-right lg:mt-3">{Lang("public.detail")}</div> */}
                            <div className="flex flex-col items-center0 lg:items-start mt-4">
                                <div className="sm:whitespace-normal flex items-center mt-3">
                                    <FeatherIcon iconClassName="ml-2 btn-cursor-default" size="18" name="UserCheck" tooltip={Lang('public.studentID')} />{data?.studentID?? "---"}
                                </div>
                                <div className="sm:whitespace-normal flex items-center mt-3">
                                    <FeatherIcon iconClassName="ml-2 btn-cursor-default" size="18" name="User" tooltip={Lang('public.username')} />{data?.username?? "---"}
                                </div>
                                <div className="sm:whitespace-normal flex items-center mt-3">
                                    <FeatherIcon iconClassName="ml-2 btn-cursor-default" size="18" name="Tag" tooltip={Lang('public.codemeli')} />{data?.codemeli?? "---"}
                                </div>
                                <div className="sm:whitespace-normal flex items-center mt-3">
                                    <FeatherIcon iconClassName="ml-2 btn-cursor-default" size="18" name="PhoneCall" tooltip={Lang('public.mobile')} />{data?.mobile?? "---"}
                                </div>
                                <div className="sm:whitespace-normal flex items-center mt-3" key={Math.random()*10}>
                                    <FeatherIcon iconClassName="ml-2 btn-cursor-default" size="18" name="Mail" tooltip={Lang('public.email')} />{data?.email?? "---"}
                                </div>
                            </div>
                        </div>
                        <div className={"mt-6 lg:mt-0 flex-1 flex0 items-center justify-center px-5 lg:border-0 border-gray-200 dark:border-dark-5 pt-5 lg:pt-0 "+borderT}>
                            {displayResume}
                        </div>
                    </div>
                    <div className="nav nav-tabs flex-col justify-center0 lg:justify-start lg:m-3 grid grid-cols-12" role="tablist">
                        {displayForm?
                            <>
                                <Input dir="ltr" label="email" refItem={[component, "email"]} defaultValue={data?.email} />
                                <ButtonContainer>
                                    <Button className="btn btn-primary w-20 lg:mr-5 lg:mt-1" label="save" onClick={saveItem} />
                                </ButtonContainer>
                            </>
                        : 
                            <>
                                {/* <div className="sm:whitespace-normal flex items-center my-4"> */}
                                <div className="col-span-4">
                                    <Link href={nextAdmin+"/changePassword"}>
                                        <FeatherIcon iconClassName="ml-2" size="18" name="Lock" tooltip={Lang('public.change_password')} />
                                        <div className="w-full">
                                        {[Lang('public.edit')," ",Lang('public.password')]}
                                        </div> 
                                    </Link>
                                </div>
                                <div className="col-span-4">
                                    <Link href="javascript:void(0)" onClick={changeDisplayForm}>
                                        <FeatherIcon iconClassName="ml-2" size="18" name="Edit2" tooltip={Lang('public.edit')} />
                                        <div className="w-full">
                                            {[Lang('public.edit')," ",Lang('public.email')]}
                                        </div> 
                                    </Link>
                                </div>
                            </>
                        }
                    </div>
                </div>
            }
        </>
    );
}