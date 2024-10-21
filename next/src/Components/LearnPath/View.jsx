"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { Box, Button, ButtonContainer, FeatherIcon, Frame, useData, useFormRefs } from "@/Theme/Midone";
import { useRouter } from 'next/navigation';
import Pdf from "./Pdf";
import { Player } from "./Player/Player";
import ImageDocs from "./ImageDocs";
import Script from "next/script";

export function View({ laraPath, id, course, mediaPath }) {
    const router = useRouter();
    const back = () => router.back();
    const { Lang, local } = useLang();
    const formUrl = "/contents";
    // const fileUrl = "/courses/" + course + "/learnpath";
    const fileUrl = "/courses/" + course;
    const title = "learnpath";
    let url = laraPath + formUrl + "/" + id;
    let component = useFormRefs();
    let { get } = useData();
    useEffect(() => { get(url, component, "info"); }, []);
    let data = component?.state?.info;

    const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);

    useEffect(() => {
        $('[role="tab"]').on('click', (event) => {
            $(`[tab-group="${$(event.target).data('tab-group')}"]`).addClass('hidden')
            $($(event.target).data('tabs-target')).removeClass('hidden')
            $('[role="tab"]').removeClass('active')
            $(event.target).addClass('active')

            switch ($(event.target).attr('data-tabs-target')) {
                case '#video':
                    const audioes = document.querySelectorAll('audio'); // get the audioes element
                    audioes.forEach(audio => {
                        audio.pause(); // pause the audio
                    })
                    break;
                case '#audio':
                    const videos = document.querySelectorAll('video'); // get the videos element
                    videos.forEach(video => {
                        video.pause(); // pause the video
                    })
                    break;

                default:
                    break;
            }

        });
    }, [])

    let images = [];

    return (<Frame title={Lang('public.learnpath')}>
        <div className="col-span-12 intro-y">
            <div className="mx-auto">
                <div className="bg-white rounded border-b border-gray-200 dark:border-gray-700 mt-5">
                    <ul className="flex flex-wrap -mb-px">
                        <li>
                            <button role='tab' data-tab-group="tabpanel" className="inline-block text-gray-500 hover:text-gray-600 hover:border-gray-300 rounded-t-lg py-4 px-4 text-sm font-medium text-center border-transparent border-b-2 dark:text-gray-400 dark:hover:text-gray-300" data-tabs-target="#detail" type="button" >مشخصات</button>
                        </li>
                        <li>
                            <button role='tab' data-tab-group="tabpanel" className="inline-block text-gray-500 hover:text-gray-600 hover:border-gray-300 rounded-t-lg py-4 px-4 text-sm font-medium text-center border-transparent border-b-2 dark:text-gray-400 dark:hover:text-gray-300 active" data-tabs-target="#image_pdf" type="button">متن درس (pdf)</button>
                        </li>
                        <li>
                            <button role='tab' data-tab-group="tabpanel" className="inline-block text-gray-500 hover:text-gray-600 hover:border-gray-300 rounded-t-lg py-4 px-4 text-sm font-medium text-center border-transparent border-b-2 dark:text-gray-400 dark:hover:text-gray-300" data-tabs-target="#mobile_pdf" type="button">{Lang('public.mobile_pdf')}</button>
                        </li>
                        <li>
                            <button role='tab' data-tab-group="tabpanel" className="inline-block text-gray-500 hover:text-gray-600 hover:border-gray-300 rounded-t-lg py-4 px-4 text-sm font-medium text-center border-transparent border-b-2 dark:text-gray-400 dark:hover:text-gray-300" data-tabs-target="#video" type="button">ویدیو</button>
                        </li>
                        <li>
                            <button role='tab' data-tab-group="tabpanel" className="inline-block text-gray-500 hover:text-gray-600 hover:border-gray-300 rounded-t-lg py-4 px-4 text-sm font-medium text-center border-transparent border-b-2 dark:text-gray-400 dark:hover:text-gray-300" data-tabs-target="#audio" type="button">صوت</button>
                        </li>
                    </ul>
                </div>
                <div>
                    <div className="rounded-lg dark:bg-gray-800 overflow-auto max-h-screen hidden" id="detail" tab-group="tabpanel">
                        <Box cols="grid-cols-1" title={Lang(["public.view", "public." + title])} >
                            <h2 className="intro-y font-medium text-xl sm:text-2xl">
                                {data.title}
                            </h2>
                            <ul>
                                <li>
                                    <h4 className="font-bold">{Lang(["public.description"])} :</h4>
                                    <div className="pr-2" dangerouslySetInnerHTML={{ __html: data.description?.replace(/\n/g, "<br />") }}></div>
                                </li>

                                <li>
                                    <h4 className="font-bold">{Lang(["public.duration"])} : </h4> {data.duration}
                                </li>

                                <li>
                                    <h4 className="font-bold">{Lang(["public.status"])} :</h4>  {data?.active_status?.["title_" + local]}
                                </li>

                            </ul>

                        </Box>
                    </div>
                    <div className="rounded-lg dark:bg-gray-800" id="image_pdf" tab-group="tabpanel">
                        {
                            data.image_pdf?.map((item, index) => {
                                let ext = item?.substr(item?.length - 4);

                                if (ext == '.bcr') {
                                    return <div className="intro-y box px-2 md:px-5 mt-5" style={{ background: '#1e2434' }} id={`reader-desktop-${index}`}>
                                        <div className={isMobile ? "px-0 md:px-5 py-5 flex min-h-[80vh] relative items-start justify-center pdf-reader" : "px-0 md:px-5 py-5 flex h-[100vh] relative items-start justify-center pdf-reader"}>
                                            <Pdf fileUrl={fileUrl} file={item} parent={`reader-desktop-${index}`} />
                                        </div>
                                    </div>
                                } else {
                                    images.push(item);
                                }
                            })
                        }

                        {
                            images.length > 0 && <ImageDocs images={images} mediaPath={mediaPath} fileUrl={fileUrl} />
                        }

                    </div>
                    <div className="rounded-lg dark:bg-gray-800 hidden" id="mobile_pdf" tab-group="tabpanel">
                        {
                            data.mobile_pdf?.length > 0 ? data.mobile_pdf?.map((item, index) => {
                                let ext = item?.substr(item?.length - 4);

                                if (ext == '.bcr') {
                                    return <div className="intro-y box px-2 md:px-5 mt-5" style={{ background: '#1e2434' }} id={`reader-mobile-${index}`}>
                                        <div className={isMobile ? "px-0 md:px-5 py-5 flex min-h-[80vh] relative items-start justify-center pdf-reader" : "px-0 md:px-5 py-5 flex h-[100vh] relative items-start justify-center pdf-reader"}>
                                            <Pdf fileUrl={fileUrl} file={item} parent={`reader-mobile-${index}`}/>
                                        </div>
                                    </div>
                                }
                            })
                                :
                                <Box className="text-center">
                                    <div className="w-full col-span-full">
                                        <h3>
                                            {Lang('public.no_finding_data')}
                                        </h3>
                                    </div>
                                </Box>
                        }
                    </div>
                    <div className="rounded-lg dark:bg-gray-800 overflow-auto max-h-screen hidden" id="video" tab-group="tabpanel">
                        {
                            data?.video?.length > 0 ? <div className="intro-y">
                                <Player videos={data.video} basePath={mediaPath + fileUrl + '/video'} />
                            </div>
                                :
                                <Box className="text-center">
                                    <div className="w-full col-span-full">
                                        <h3>
                                            {Lang('public.no_finding_data')}
                                        </h3>
                                    </div>
                                </Box>
                        }

                    </div>

                    <div className="rounded-lg dark:bg-gray-800 overflow-auto max-h-screen hidden" id="audio" tab-group="tabpanel">
                        {
                            data.audio?.length > 0 ? <Box className="text-center">
                                <div className="w-full col-span-full">
                                    <div className="sticky top-0 text-right">
                                        <h2>
                                            فایل صوتی
                                        </h2>
                                        <hr className="mb-8 w-full" />
                                    </div>
                                    <div>
                                        {
                                            data.audio?.map((item) => {
                                                let ext = item?.substr(item?.length - 4);

                                                return <div className="sm:mx-auto md:mx-2 mb-4 inline">
                                                    <audio className="w-full" controls onPlay={(event) => Play(event)}>
                                                        {
                                                            (ext == '.ogg') ? <source src={`${mediaPath + fileUrl + '/audio'}/${item}`} type="audio/ogg" /> : <source src={`${mediaPath + fileUrl + '/audio'}/${item}`} type="audio/mpeg" />
                                                        }
                                                        Your browser does not support the audio element.
                                                    </audio>
                                                </div>
                                            })
                                        }

                                    </div>
                                </div>
                            </Box>
                                :
                                <Box className="text-center">
                                    <div className="w-full col-span-full">
                                        <h3>
                                            {Lang('public.no_finding_data')}
                                        </h3>
                                    </div>
                                </Box>
                        }
                    </div>
                </div>
            </div>

            <ButtonContainer>
                <Button label="back" onClick={back} />
            </ButtonContainer>

        </div>
    </Frame>
    );
}

function Play(e) {

    const nowPlay = $(e.target).find('source').attr('src');
    const audioes = document.querySelectorAll('audio'); // get the audio element

    audioes.forEach(audio => {
        if ($(audio).find('source').attr('src').includes(nowPlay)) { // check if the audio src includes the nowPlay
            audio.play(); // play the audio
        } else {
            audio.pause(); // pause the audio
        }
    })
}