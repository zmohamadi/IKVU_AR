"use client";
import { useLang } from "@/lib/lang";

export default function page() {
    const { Lang } = useLang();

    return <>
        <div className="grid grid-cols-12 gap-6">
            <div className="col-span-12 xxl:col-span-9">
                <div className="grid grid-cols-12 gap-6">
                    <div className="col-span-12 mt-6 -mb-6 intro-y">
                        <div className="alert alert-dismissible show box bg-theme-26 text-white flex items-center mb-6" role="alert">
                            در حال آماده سازی ... 
                        </div>
                    </div>
                      
                </div>
            </div>
        </div>
    </>
}