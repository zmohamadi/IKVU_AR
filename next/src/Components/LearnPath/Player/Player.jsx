'use client'
import PlayList from "./PlayList";
import PlayScreen from "./PlayScreen";

export function Player({ videos, basePath }) {

    const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);

    return <>
        <div className="container-fluid p-0">
            <section className="hero--area">
                <div className="grid grid-cols-12 mt-5 rounded overflow-hidden">
                    {
                        isMobile ? <>
                            <PlayScreen videos={videos} basePath={basePath} />
                            <PlayList videos={videos} basePath={basePath} />
                        </> :
                            <>
                                <PlayList videos={videos} basePath={basePath} />
                                <PlayScreen videos={videos} basePath={basePath} />
                            </>
                    }
                </div>
            </section>
        </div>
    </>
}