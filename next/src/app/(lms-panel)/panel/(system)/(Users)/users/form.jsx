"use client";
import { useEffect, useState } from "react";
import { useLang } from "@/lib/lang";
import { useConfig } from "@/lib/config";
import { useRouter } from 'next/navigation';
import { useAuth } from "@/lib/auth";
import { useData,useFormRefs,Input,Button,ButtonContainer,Box,CheckBox,Textarea,Frame,Radio } from "@/Theme/Midone/Forms";
import { SelectTail } from "@/Theme/Midone/Forms/SelectTail";
import { Dropzone } from "@/Theme/Midone/Forms/Dropzone";

export default function Form({id,link="/users",roleFilter="",titleFrame=""}){
    const {Lang, local} = useLang();
    const {laraAdmin} = useConfig();
    const router = useRouter();
    let component = useFormRefs();
    let {save, get, getNeedles} = useData();
    let [needles, setNeedles] = useState();
    let [roleId, setRoleId] = useState(roleFilter);
    const {user} = useAuth({guard: "admin"});
    const userId = user?.id;
    const userRoleId = user?.role_id;

    let uploadUrl = laraAdmin+"/upload/.-media-users";
    let deleteUrl = laraAdmin+"/deleteFile/.-media-users";
    let uploadDir = 'media/users/';
    
    let url = laraAdmin+link, method = "new";
    if(id != 0 && id != undefined) url = laraAdmin+link+"/"+id, method = "edit";

    useEffect(() => {
        getNeedles(laraAdmin+'/users/get-needles', setNeedles);
        get(url, component, "info");
    }, []);

    const saveItem = ()=>save(url, component, method, link);
    const back = ()=>router.back();
    let userPersonnel = [1,2,3].includes(roleFilter) ? false : true;
    
    let roles = needles?.role;
    if(roleFilter != "") roles = needles?.role?.filter((role, i)=>role.id == roleFilter)
    if(roleFilter == "0") roles = needles?.role?.filter((role, i)=>role.id > 3)
    
    const getRole = ()=>{
        if(roleFilter == "") setRoleId(component?.state?.refs?.current?.role_id?.value);
    };
    let displayInfo = <>
            <Input dir="ltr" label="codemeli" refItem={[component, "codemeli"]} />
            <Input dir="ltr" label="username" refItem={[component, "username"]} required="true" />
            <Input dir="ltr" label="mobile" refItem={[component, "mobile"]} required="true" />
            <Input dir="ltr" label="email" refItem={[component, "email"]} />
            <Input dir="ltr" label="studentID" refItem={[component, "studentID"]} required={roleId==2? true : false}/>
            <CheckBox className="col-span-6" label="status" name={Lang('public.active')} refItem={[component, "status_id"]} />
        </>

     if(method =='edit' || userId == id)
    {
        if(roleFilter == "")
        {
            let infoRoleId = component?.state?.info?.role_id;
            roles = ([1,2,3].includes(infoRoleId))?
                needles?.role?.filter((role, i)=>role.id == infoRoleId) : needles?.role?.filter((role, i)=>role.id > 3);
        }    
        if(userId == id && (roleFilter == "" || roleFilter == "0")) roles = needles?.role?.filter((role, i)=>role.id == userRoleId)

        if(userId == id)
        displayInfo = <>
            <div className="col-span-6">
                <div className="alert alert-secondary show mb-2 mt-5">{Lang("public.codemeli")+" : "}<strong>{component?.state?.info?.codemeli?? "---"}</strong></div>
            </div>
            <div className="col-span-6">
                <div className="alert alert-secondary show mb-2 mt-5">{Lang("public.username")+" : "}<strong>{component?.state?.info?.username?? "---"}</strong></div>
            </div>
            <div className="col-span-6">
                <div className="alert alert-secondary show mb-2 mt-5">{Lang("public.mobile")+" : "}<strong>{component?.state?.info?.mobile}</strong></div>
            </div>
            <div className="col-span-6">
                <div className="alert alert-secondary show mb-2 mt-5">{Lang("public.email")+" : "}<strong>{component?.state?.info?.email}</strong></div>
            </div>
            <div className="col-span-6">
                <div className="alert alert-secondary show mb-2 mt-5">{Lang("public.studentID")+" : "}<strong>{component?.state?.info?.studentID?? "---"}</strong></div>
            </div>
            <span className={"text-"+component?.state?.info?.active_status?.color}>{component?.state?.info?.active_status?.["title_"+local]}</span>
        </>
    }
    
    return(
        (roles?.length == 0 || roles == undefined)?
            <Frame title={Lang(["public."+titleFrame])}>
                <div className="col-span-12 md:col-span-12 xxl:col-span-12 mt-3 xxl:mt-6">
                    <span className="alert alert-secondary-soft show flex items-center mb-2 mt-5">{Lang("public.grid_loading")+"....."}</span>
                </div>
            </Frame>
        :
            <>
                <Frame title={Lang(["public."+titleFrame])}>
                    <Box>
                        <Input label="name" refItem={[component, "firstname"]} required="true" />
                        <Input label="family" refItem={[component, "lastname"]} required="true" />
                        {userPersonnel?
                            <>
                                <SelectTail className="col-span-6 sm:col-span-12" label="role" refItem={[component, "role_id"]} data={roles} titleKey={"title_"+local} required="true" onChange={getRole} />
                                {/* <Input label="personID" refItem={[component, "person_id"]} /> */}
                            </>
                        :
                            <SelectTail label="role" refItem={[component, "role_id"]} data={roles} titleKey={"title_"+local} required="true"
                                // defaultValue={roleFilter}
                            />
                        }
                        <Radio type="col" label="gender" id="gender_id" refItem={[component, `gender_id`]}
                            data={needles?.gender} titleKey={"title_"+local} required="true" key={"gender_id"+component?.state?.info?.gender_id}
                        />
                        {displayInfo}
                        <Dropzone refItem={[component, "photo"]} uploadUrl={uploadUrl} deleteUrl={deleteUrl+"/"} uploadDir={uploadDir} required="true" />
                        {(roleId == 1)?
                            <Textarea refItem={[component, "resume"]} />
                            :''
                        }
                    </Box>
                </Frame>
                <ButtonContainer>
                    <Button label="save" onClick={saveItem} />
                    <Button label="back" onClick={back} />
                </ButtonContainer>
            </>
    );
}