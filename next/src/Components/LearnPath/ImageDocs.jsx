import { FeatherIcon } from "@/Theme/Midone";
import { useEffect, useState } from "react"

export default function ImageDocs({ images = [], mediaPath, fileUrl }) {
    const [rotate, setRotate] = useState(0);
    // const [scale, setScale] = useState(1);
    const [width, setWidth] = useState(100);
    const numPages = images?.length
    const [pageNumber, setPageNumber] = useState(1)
    const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);

    // zoomIn zoomOut
    function changeScale(type = 'in') {
        if (type == 'in') {
            if (width < 100) {
                setWidth(width + 20)
            }
        } else {
            if (width >= 40) {
                setWidth(width - 20)
            }
        }
    }

    //rotating
    function rotatePage(type = 'positive') {
        if (type == 'positive') {
            setRotate(rotate + 90)
        }
        else {
            setRotate(rotate - 90)
        }
    }


    // Go to next page
    function goToNextPage() {
        scrollToImg(pageNumber + 1)
    }

    // Go to previous page
    function goToPreviousPage() {
        scrollToImg(pageNumber - 1)
    }


    function Nav() {
        function changePage(event) {
            let page = parseInt(event.target.value)

            if (event.keyCode != 13) {
                return
            }

            if (page >= 1 && page <= numPages) {
                scrollToImg(page)
            }
            else {
                event.target.value = pageNumber
            }
        }
        return (
            <nav>
                <div className="bg-gray-900 text-gray-400 rounded-md px-3 py-2 text-sm font-medium">
                    <span>{numPages}</span>
                    <span className=""> /
                        <input className='border-0 text-center text-white bg-transparent w-[25px]' onKeyUp={(event) => changePage(event)}
                            defaultValue={pageNumber}
                        />
                    </span>

                </div>
            </nav>
        );
    }

    function scrollToImg(id) {
        const list = document.querySelector('.main-panel .v-layer.img-player');
        const target = document.getElementById('img-' + id)

        setPageNumber(id)
        activeImgThumb(id)
        list.scrollTo({ top: target.offsetTop - list.offsetTop, behavior: 'smooth' });
    }

    function activeImgThumb (id) {
        $('[id *="thumb-img-"]').removeClass('active');
        document.getElementById('thumb-img-' + id).classList.add('active');
    }

    function handleScroll() {
        // const tags = document.querySelectorAll('[id ^= "img-"]')

        // Array.from(tags).map((tag) => {
        //     console.log(tag.offsetTop , document.querySelector(('.main-panel .v-layer.img-player')).scrollTop);
            
        //     if (tag.offsetTop < document.querySelector(('.main-panel .v-layer.img-player')).scrollTop) {
             
        //         setPageNumber(parseInt(tag.id.replace('img-', '')))
        //     }
        // }
        // );


    }

    return images.length > 0 && <div className="intro-y">
        <div className="intro-y box px-2 md:px-5 mt-5" style={{ background: '#1e2434' }} id="imageReader">
            <div className="image-present flex px-0 md:px-5 relative items-center justify-center">
                <div className="w-full col-span-full overflow-auto">
                    <div className="sticky top-0 z-10 text-white">
                        <div className="flex justify-between items-center">
                            {/* <h2>
                                فایل / تصویر
                            </h2> */}
                            <div className='flex'>

                                <button
                                    onClick={goToPreviousPage}
                                    disabled={pageNumber <= 1}
                                    className="relative md:inline ps-2 py-1 text-gray-400 hover:text-gray-50 focus:z-20"
                                    style={{ outline: 'none' }}
                                >
                                    <span className="sr-only">Previous</span>
                                    <FeatherIcon iconClassName="mobile-resize-icon" name="ChevronRight" access={'access'} />
                                </button>

                                <Nav pageNumber={pageNumber} numPages={numPages} setPageNumber={setPageNumber} />
                                <button
                                    onClick={goToNextPage}
                                    disabled={pageNumber >= numPages}
                                    className="relative md:inline pe-2 py-1 text-gray-400 hover:text-gray-50 focus:z-20"
                                    style={{ outline: 'none' }}
                                >
                                    <span className="sr-only">Next</span>
                                    <FeatherIcon iconClassName="mobile-resize-icon" name="ChevronLeft" access={'access'} />
                                </button>
                            </div>
                            <div className={isMobile ? 'flex justify-between w-[100px]' : 'flex justify-between w-[125px]'}>
                                <FeatherIcon iconClassName="mobile-resize-icon" name="RotateCw" access={'access'} onClick={() => rotatePage('positive')} />
                                <FeatherIcon iconClassName="mobile-resize-icon" name="RotateCcw" access={'access'} onClick={() => rotatePage('negative')} />
                                <FeatherIcon iconClassName="mobile-resize-icon" name="ZoomIn" access={'access'} onClick={() => changeScale('in')} />
                                <FeatherIcon iconClassName="mobile-resize-icon" name="ZoomOut" access={'access'} onClick={() => changeScale('out')} />
                                <FeatherIcon name="Monitor" access={'access'} onClick={() => openFullscreen('#imageReader')} />
                            </div>
                        </div>
                        <hr className="mb-8 w-full" />
                    </div>

                    <div class="container-fluid p-0">
                        <section class="hero--area">
                            <div class={isMobile ? "mt-5 flex flex-wrap content-start rounded overflow-hidden" : "mt-5 flex flex-wrap content-start rounded overflow-hidden h-[90vh]"}>
                                {
                                    !isMobile && <div class="right-panel w-[250px] relative">
                                        <span className="toggle-icon text-white absolute z-10 left-0" onClick={() => toggleMenu()}>
                                            <FeatherIcon name="ArrowRightCircle" access={'access'} />
                                        </span>
                                        <ul class="nav vizew-nav-tab flex content-center max-h-fit]" style={{ height: '90vh' }} role="tablist" tabindex="1">
                                            {
                                                images?.map((item, index) => {
                                                    return <>
                                                        <li onClick={() => scrollToImg(index + 1)} id={'thumb-img-' + (index + 1)}  className={index == 0 ? "flex justify-center w-full nav-item nav-link h-[120px] cursor-pointer active" : "flex justify-center w-full nav-item nav-link h-[120px] cursor-pointer"}>
                                                            <img className="mb-6" src={`${mediaPath + fileUrl + '/pdf'}/${item}`} style={{ transform: `rotate(${rotate}deg)` }} height='100%' />
                                                        </li>
                                                    </>
                                                })
                                            }
                                        </ul>
                                    </div>
                                }
                                <div class="main-panel mobile-screen" style={isMobile ? { width: '100%' } : { width: 'calc(100% - 250px)' }}>
                                    <span className="toggle-icon text-white absolute z-10 left-0 opacity-0 hidden transition right-0" onClick={() => toggleMenu('open')}>
                                        <FeatherIcon name="ArrowLeftCircle" access={'access'} />
                                    </span>
                                    <div class="tab-content w-full h-full ">
                                        <div class="tab-pane fade active show h-full">
                                            <div class="single-feature-post video-post bg-img h-full relative">
                                                <div class="v-layer img-player h-full overflow-auto" style={{ backgroundColor: 'rgb(30, 36, 52)', padding: '0 1rem' }} onScroll={handleScroll}>
                                                    <ul className="flex justify-center content-start flex-wrap">
                                                        {
                                                            images?.map((item, index) => {
                                                                $('.image-present').addClass('py-5')
                                                                return <>
                                                                    <li id={'img-' + (index + 1)} className="w-full mb-2 flex justify-center">
                                                                        <img className="mb-6" src={`${mediaPath + fileUrl + '/pdf'}/${item}`} style={{ transform: `rotate(${rotate}deg)` }} width={width + '%'} />
                                                                    </li>
                                                                </>
                                                            })
                                                        }
                                                    </ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                {
                                    isMobile &&
                                    <div className="w-full overflow-x-auto mt-3">
                                        <ul tabindex="1" class="w-max min-w-full flex justify-start items-center mobile-vizew-nav-tab" style={{ height: '50px' }}>
                                            {
                                                images?.map((item, index) => {
                                                    return <li onClick={() => scrollToImg(index + 1)} className={index == 0 ? "flex justify-center nav-link h-full w-auto cursor-pointer active" : "flex justify-center nav-item nav-link h-full w-auto cursor-pointer"}>
                                                        <img src={`${mediaPath + fileUrl + '/pdf'}/${item}`} className="h-full w-auto" />
                                                    </li>
                                                })
                                            }
                                        </ul>
                                    </div>
                                }
                            </div>
                        </section>
                    </div>
                </div >
            </div >
        </div >
    </div>
}

function toggleMenu(type = 'close') {

    if (type == 'close') {
        $('.right-panel').css({ 'transform': 'translate(500px)', 'transition': '500ms', 'width': 0 })
        $('.main-panel').css('width', '100%').find('.toggle-icon').removeClass('opacity-0 hidden')

    } else {
        $('.right-panel').css({ 'transform': 'translate(0px)', 'transition': '500ms', 'width': '250px' })
        $('.main-panel').css({ 'width': 'calc(100% - 250px)', transition: '500ms' }).find('.toggle-icon').addClass('opacity-0 hidden')
    }

}

function openFullscreen(elem) {
    var elem = document.querySelector(elem)

    /* If fullscreen mode is available, show the element in fullscreen */
    if (
        document.fullscreenEnabled || /* Standard syntax */
        document.webkitFullscreenEnabled || /* Safari */
        document.msFullscreenEnabled /* IE11 */
    ) {

        /* Show the element in fullscreen */
        if (elem.requestFullscreen) {
            elem.requestFullscreen(); /* Standard syntax */
        } else if (elem.webkitRequestFullscreen) { /* Safari */
            elem.webkitRequestFullscreen();
        } else if (elem.msRequestFullscreen) { /* IE11 */
            elem.msRequestFullscreen();
        }
    }
}