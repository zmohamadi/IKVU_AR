"use client"

import {Input, TinyMCE, Textarea, Frame, Box, Button, ButtonContainer, Radio, CheckBox, SelectTail} from "@/Theme/Midone/Forms";
import {Dropzone} from "@/Theme/Midone/Forms/Dropzone";
import {useFormRefs, useData} from "@/Theme/Midone/Utils";
import { useConfig } from "@/lib/config";
import { useLang } from "@/lib/lang";
import { useEffect } from "react";

export const SystemForm = ({id = 0})=>{
    const {Lang} = useLang();
    let {laraSAdmin} = useConfig()

    let url = laraSAdmin+'/systems', method = "new";
    if(id != 0) url = laraSAdmin+'/systems/'+id, method = "edit";

    let component = useFormRefs();
    let {save, get} = useData();

    useEffect(()=>{
        if(id > 0) get(url, component);
    }, [id]);
    
    // console.log("url: ", url);
    const saveItem = ()=>save(url, component, method, "/systems?"+Math.random());
    // const saveItem = ()=>save(url, component, method);
    let uploadUrl=laraSAdmin+"/upload/.-media-systems?uploadVar=sliders";
    let deleteUrl=laraSAdmin+"/deleteFile/.-media-systems/";
    let uploadDir='/media/systems/';

    return <>
            <Frame title={Lang(["public.newSystem"])}>
                <Box className={"col-span-12 lg:col-span-8"}>
                    <Input refItem={[component, "name"]} className={"col-span-12 lg:col-span-6"} help="حتما به زبان انگلیسی وارد گردد" />
                    <Input refItem={[component, "title_fa"]} className={"col-span-12 lg:col-span-6"} />
                    <Textarea refItem={[component, "comments"]} className={"col-span-12"} help="توضیحاتی درباره سیستم" />
                    {/* <TinyMCE refItem={[component, "comments"]} className={"col-span-12"} help="توضیحاتی درباره سیستم" /> */}
                    <Radio refItem={[component, "type"]} data={[{id:1, name:"male"}, {id:2, name:"female"}]} titleKey="name" help="یکی از انواع بالا را نتخاب نمائید" defaultValue="1" />
                    <Radio refItem={[component, "type2"]} data={[{id:1, name:"male"}, {id:2, name:"female"}]} titleKey="name" type="col" help="یکی از انواع بالا را نتخاب نمائید" />
                    <SelectTail refItem={[component, "type3"]} data={[{id:1, name:"male"}, {id:2, name:"female"}]} titleKey="name" type="col" help="یکی از انواع بالا را نتخاب نمائید" defaultValue = "1" />
                    <Dropzone refItem={[component, "photo"]} 
                            className={"col-span-12"} 
                            uploadUrl={uploadUrl}
                            deleteUrl={deleteUrl}
                            uploadDir={uploadDir}
                            help="پسوندهای مجاز عبارتند از: jpg، png، gif"
                        />
                    <ButtonContainer>
                        <Button label="save" onClick={saveItem} />
                    </ButtonContainer>
                </Box>
                <Box className={"col-span-12 lg:col-span-4 bg-theme-17 text-white"} title={"درباره فرم"}>
                    <div className="col-span-12 text-justify">
                        سیستم ها، بخش هایی از برنامه می باشند که با prefix خاصی مشخص می گردند. <br/>                
                        لطفا اطلاعات را با دقت کامل وارد نمائید. <br/>
                        از قسمت منوها می توانید برای سیستم درج شده، منوها و پرمیژن های دلخواه را ثبت نمائید. <br/><br/>
                        موفق باشید.
                    </div>
                </Box>
            </Frame>
        </>
}