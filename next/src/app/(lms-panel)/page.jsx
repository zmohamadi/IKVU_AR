"use client";

import { useConfig } from "@/lib/config";
import { Tools, useFormRefs } from "@/Theme/Midone";
import { useData } from "@/Theme/Midone/Utils/Data";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import Slider from "react-slick";
import "slick-carousel/slick/slick.css";
import "slick-carousel/slick/slick-theme.css";

export default function Dashboard() {
    const { Lang } = useLang();
    let { get } = useData();
    let component = useFormRefs();
    const { laraAdmin, mediaPath, nextAdmin } = useConfig();

    useEffect(() => {
        get(`${laraAdmin}/baseTools/list`, component, "info");
    }, []);
    
    let tools = component?.state?.info;
    
    // Slider settings
    const sliderSettings = {
        dots: true,
        infinite: true,
        speed: 500,
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 3000,
        arrows: false,
        adaptiveHeight: true, // Automatically adjust slider height based on content
        minHeight: 400, // Minimum height for the slider
    };

    return(
        <div class="min-h-screen bg-gray-900 flex flex-col items-center justify-center">
            <h1 class="text-5xl text-white font-bold mb-8 animate-pulse">
                Coming Soon
            </h1>
            <p class="text-white text-lg mb-8">
                We're working hard to bring you something amazing. Stay tuned!
            </p>
        </div>
    );

    return (
        <div className="container mx-auto m-8 bg-white p-4">
            {/* Header */}
            <div className="flex justify-between items-center mb-4">
                <h1 className="text-3xl font-bold text-gray-800">آموزش مجازی (IKVU)</h1>
                <button
                    className="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition duration-300"
                    onClick={() => window.location.href = '/panel'}
                >
                    ورود به پنل کاربری
                </button>
            </div>
            
            {/* Slider */}
            <Slider {...sliderSettings}>
                {/* You can map through info.slides or use static content */}
                <div>
                    <img
                        src={`${mediaPath}/1.jpg`}
                        alt="Slide 1"
                        className="w-full h-auto object-cover"
                    />
                </div>
                {/* <div>
                    <img
                        src={`${mediaPath}/2.jpg`}
                        alt="Slide 2"
                        className="w-full h-auto object-cover"
                    />
                </div> */}
                {/* Add more slides as needed */}
            </Slider>
            {/* Tools */}
            <div className="grid grid-cols-12 md:grid-cols-4 gap-4 mt-8">
                {Tools.getArray(tools).map((tool) => (
                <div key={tool.id} className="col-span-12 sm:col-span-6 md:col-span-4 items-center p-4 rounded-lg shadow-lg bg-white">
                    <img
                    src={`${mediaPath}/baseTools/${tool.img}`}
                    alt={tool.title_en}
                    className="w-24 h-24 object-contain mb-2 rounded-lg"
                    />
                    <a
                    href={`/panel`}
                    className="text-center text-sm text-gray-700 hover:text-gray-900 font-semibold"
                    >
                    {Lang([tool.title_fa])}
                    </a>
                    <p className="text-xs text-justify text-gray-600 mt-2">{Lang([tool.description])}</p>
                </div>
                ))}
            </div>
            {/* Footer */}
            <footer className="bg-gray-800 text-white text-center py-4 mt-8">
                <p className="text-sm">© 2024 آموزش مجازی (IKVU). تمام حقوق محفوظ است.</p>
                <p className="text-sm">طراحی شده توسط تیم توسعه IKVU</p>
            </footer>
        </div>
    );
}
