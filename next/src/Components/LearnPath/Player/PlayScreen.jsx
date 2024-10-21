export default function PlayScreen({ videos, basePath }) {
    return <>
        <div className="col-span-12 xl:col-span-8 xxl:col-span-9 mobile-screen">
            <div className="tab-content w-full h-full ">
                <div className="tab-pane fade active show h-full">
                    <div className="single-feature-post video-post bg-img h-full relative">
                        {/* <div className="single-feature-post video-post bg-img h-full relative" style={{ backgroundImage: "url(/media/mediaGallery/images/image76931695921060.jpg);" }}> */}
                        <div className="v-layer video-player">
                            <video className="absolute" height='100%' controls>
                                <source src={`${basePath}/${videos[0]}`} type="video/mp4" />
                                Your browser does not support the video tag.
                            </video>
                        </div>
                        {/* <button className="btn play-btn"><i className="fa fa-play" aria-hidden="true"></i></button> */}

                        {/* <div className="post-content">
                            <span className="post-title">Best Kid’s story The story of the strange fish</span>
                        </div>
                        <span className="video-duration">01:00:00</span> */}
                    </div>
                </div>
            </div>
        </div>
    </>
}