'use client'
import { config } from '@/lib';
import axios from '@/lib/axios';
import { FeatherIcon, Toast } from '@/Theme/Midone';

import { useEffect, useState } from 'react';
import { Document, Page } from 'react-pdf';
import { pdfjs } from 'react-pdf';
import Loading from './Loading';
// import Modal from './Modal';
// pdfjs.GlobalWorkerOptions.workerSrc = `//unpkg.com/pdfjs-dist@${pdfjs.version}/legacy/build/pdf.worker.min.mjs`;


// @ts-expect-error This does not exist outside of polyfill which this is doing
if (typeof Promise.withResolvers === 'undefined') {
    if (window)
        // @ts-expect-error This does not exist outside of polyfill which this is doing
        window.Promise.withResolvers = function () {
            let resolve, reject;
            const promise = new Promise((res, rej) => {
                resolve = res;
                reject = rej;
            });
            return { promise, resolve, reject };
        };
}

pdfjs.GlobalWorkerOptions.workerSrc = '/learnpath/worker.min.mjs';

export default function Pdf({ fileUrl, file, parent }) {
    const [numPages, setNumPages] = useState();
    const [pageNumber, setPageNumber] = useState(1);
    const [loading, setLoading] = useState(true);
    const [fileData, setFileData] = useState()
    const [pageWidth, setPageWidth] = useState(0);
    const [scale, setScale] = useState(1);
    const [rotate, setRotate] = useState(0);
    // const options = {
    //     cMapUrl: "cmaps/",
    //     cMapPacked: true,
    //     standardFontDataUrl: "standard_fonts/",
    // };
    const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);

    useEffect(() => {
        getData();

        const handleContextmenu = e => {
            e.preventDefault()
        }
        
        document.addEventListener('contextmenu', handleContextmenu)
        
        
        // swipe()
        return function cleanup() {
            document.removeEventListener('contextmenu', handleContextmenu)
        }
    }, [])


    const getData = async () => {
        await axios.post(config.host() + '/mastership/get-file', { url: fileUrl + '/pdf/', file: file }, { responseType: 'blob' }).then(response => {
            let blob = new Blob([response?.data], { type: 'application/pdf' })
            let url = window.URL.createObjectURL(blob)
            setFileData(url);
        }).catch((error) => {
            console.log(error);

            Toast.error('pdf is not valid', 'message');
            // $('.pdf-reader').html(`<div class="text-center"><h3 class="text-white">${error?.response?.statusText} </h3><p class='text-white'>file is not valid!</p></div>`)
        })
            ;
    }


    function onDocumentLoadSuccess({ numPages }) {
        setNumPages(numPages);
    }

    function onPageLoadSuccess() {
        setPageWidth(window.innerWidth);
        setLoading(false);
    }

    useEffect(() => {
        document.addEventListener('touchstart', handleTouchStart, false);
        document.addEventListener('touchmove', handleTouchMove, false);
        
        // swipe()
        return function cleanup() {
            document.removeEventListener('touchstart', handleTouchStart)
            document.removeEventListener('touchmove', handleTouchMove)
        }
    },[pageNumber, numPages])

    var xDown = null;
    var yDown = null;

    function getTouches(evt) {
        return evt.touches ||             // browser API
            evt.originalEvent.touches; // jQuery
    }

    function handleTouchStart(evt) {
        const firstTouch = getTouches(evt)[0];
        xDown = firstTouch.clientX;
        yDown = firstTouch.clientY;
    };

    function handleTouchMove(evt) {
        if (!xDown || !yDown) {
            return;
        }

        var xUp = evt.touches[0].clientX;
        var yUp = evt.touches[0].clientY;

        var xDiff = xDown - xUp;
        var yDiff = yDown - yUp;

        var pdfContainer = $('.pdf-reader').width();
        var page = $('.react-pdf__Document').width();

        console.log(pdfContainer, page);
        

        if (pdfContainer >= page) {
            if (Math.abs(xDiff) > Math.abs(yDiff)) {/*most significant*/
                if (xDiff > 0) {
                    /* right swipe */                    
                    if(pageNumber < numPages){
                        console.log(5613);
                        
                        goToNextPage()
                    }
                    console.log('right swipe');
                } else {
                    /* left swipe */
                    if(pageNumber > 1){
                        goToPreviousPage()
                    }
                    console.log('left swipe');
                }
            }
        }

        /* reset values */
        xDown = null;
    };


    // Go to next page
    function goToNextPage() {
        setPageNumber((prevPageNumber) => prevPageNumber + 1);
    }

    // Go to previous page
    function goToPreviousPage() {
        setPageNumber((prevPageNumber) => prevPageNumber - 1);
    }

    // zoomIn zoomOut
    function changeScale(type = 'in') {
        if (type == 'in') {
            if (scale < 2) {
                setScale(scale + 0.25)
            }
        } else {
            if (scale >= 0.5) {
                setScale(scale - 0.25)
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

    function Nav() {
        function changePage(event) {
            let page = parseInt(event.target.value)

            if (event.keyCode != 13) {
                return
            }

            if (page >= 1 && page <= numPages) {
                setPageNumber(page)
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

    return (
        <>
            {
                fileData ? <>
                    <div className="w-full col-span-full  overflow-auto mt-[-0.75rem]">
                        <div className="sticky top-0 z-10 text-white" style={{ backgroundColor: 'rgb(30, 36, 52)' }}>
                            <div className="flex justify-between items-center">
                                {/* <h2 className='hidden md:block'>
                                    فایل / تصویر
                                </h2> */}
                                <div className='flex'>

                                    <button
                                        onClick={goToNextPage}
                                        disabled={pageNumber >= numPages}
                                        className="relative md:inline ps-2 py-1 text-gray-400 hover:text-gray-50 focus:z-20"
                                        style={{ outline: 'none' }}
                                    >
                                        <span className="sr-only">Previous</span>
                                        <FeatherIcon iconClassName="mobile-resize-icon" name="ChevronRight" access={'access'} />
                                    </button>
                                    <Nav pageNumber={pageNumber} numPages={numPages} setPageNumber={setPageNumber} />
                                    <button
                                        onClick={goToPreviousPage}
                                        disabled={pageNumber <= 1}
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
                                    <FeatherIcon iconClassName="mobile-resize-icon" name="Monitor" access={'access'} onClick={() => openFullscreen(`#${parent}`)} />
                                    {/* <span data-toggle="modal-audio">

                                <FeatherIcon name="Monitor" access={'access'} />
                            </span>
                            <FeatherIcon name="Monitor" access={'access'}
                                data-toggle="modal-video" /> */}
                                </div>
                            </div>
                            <hr className="mb-8 w-full mt-2" />
                        </div>
                        <div className="flex items-center relative overflow-auto" >
                            {/* <div className='flex items-center justify-between w-11/12 absolute z-10 px-2' >
                                <button
                                    onClick={goToPreviousPage}
                                    disabled={pageNumber <= 1}
                                    className="relative h-[calc(100vh - 64px)] px-2 py-24 text-gray-400 hover:text-gray-50 focus:z-20"
                                    style={{ outline: 'none' }}
                                >
                                    <span className="sr-only">Previous</span>
                                    <FeatherIcon name="ArrowRight" access={'access'} />
                                </button>
                                <button
                                    onClick={goToNextPage}
                                    disabled={pageNumber >= numPages}
                                    className="relative h-[calc(100vh - 64px)] px-2 py-24 text-gray-400 hover:text-gray-50 focus:z-20"
                                    style={{ outline: 'none' }}
                                >
                                    <span className="sr-only">Next</span>
                                    <FeatherIcon name="ArrowLeft" access={'access'} />
                                </button>
                            </div> */}
                            {
                                (isMobile) ? <div className="flex justify-center mx-auto">
                                    <Document
                                        file={fileData}
                                        onLoadSuccess={onDocumentLoadSuccess}
                                        // options={options}
                                        // renderMode="canvas"
                                        className=""
                                    >
                                        <Page
                                            className=""
                                            key={pageNumber}
                                            pageNumber={pageNumber}
                                            renderAnnotationLayer={false}
                                            renderTextLayer={false}
                                            onLoadSuccess={onPageLoadSuccess}
                                            onRenderError={() => setLoading(false)}
                                            width={Math.max(pageWidth * 0.8, 200)}
                                            scale={scale}
                                            rotate={rotate}
                                            loading={<Loading />}
                                        />
                                    </Document>
                                </div>
                                    :
                                    <div className="flex justify-center mx-auto h-[90vh]">
                                        <Document
                                            file={fileData}
                                            onLoadSuccess={onDocumentLoadSuccess}
                                            // options={options}
                                            renderMode="canvas"
                                            className=""
                                        >
                                            <Page
                                                className=""
                                                key={pageNumber}
                                                pageNumber={pageNumber}
                                                renderAnnotationLayer={false}
                                                renderTextLayer={false}
                                                onLoadSuccess={onPageLoadSuccess}
                                                onRenderError={() => setLoading(false)}
                                                scale={scale}
                                                rotate={rotate}
                                                loading={<Loading />}
                                            />
                                        </Document>
                                    </div>

                            }
                        </div>
                    </div>
                    {/* <Modal targetclassName='te' title={'test'}></Modal> */}
                </>
                    :
                    <Loading />

            }
        </>
    );
}

// function openFullscreen(elem) {
//     var elem = document.querySelector(elem)

//     /* If fullscreen mode is available, show the element in fullscreen */
//     if (
//         document.fullscreenEnabled || /* Standard syntax */
//         document.webkitFullscreenEnabled || /* Safari */
//         document.msFullscreenEnabled /* IE11 */
//     ) {

//         /* Show the element in fullscreen */
//         if (elem.requestFullscreen) {
//             elem.requestFullscreen(); /* Standard syntax */
//         } else if (elem.webkitRequestFullscreen) { /* Safari */
//             elem.webkitRequestFullscreen();
//         } else if (elem.msRequestFullscreen) { /* IE11 */
//             elem.msRequestFullscreen();
//         }
//     }
// }

function openFullscreen(elem) {
    var isInFullScreen = (document.fullscreenElement && document.fullscreenElement !== null) ||
        (document.webkitFullscreenElement && document.webkitFullscreenElement !== null) ||
        (document.mozFullScreenElement && document.mozFullScreenElement !== null) ||
        (document.msFullscreenElement && document.msFullscreenElement !== null);

    var docElm = document.querySelector(elem);
    if (!isInFullScreen) {
        if (docElm.requestFullscreen) {
            docElm.requestFullscreen();
        } else if (docElm.mozRequestFullScreen) {
            docElm.mozRequestFullScreen();
        } else if (docElm.webkitRequestFullScreen) {
            docElm.webkitRequestFullScreen();
        } else if (docElm.msRequestFullscreen) {
            docElm.msRequestFullscreen();
        }
    } else {
        if (document.exitFullscreen) {
            document.exitFullscreen();
        } else if (document.webkitExitFullscreen) {
            document.webkitExitFullscreen();
        } else if (document.mozCancelFullScreen) {
            document.mozCancelFullScreen();
        } else if (document.msExitFullscreen) {
            document.msExitFullscreen();
        }
    }
}