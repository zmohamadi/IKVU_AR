export default function PlayList({ videos, basePath }) {

    const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);

    const player = function (event, index) {
        var target = $('.v-layer.video-player');

        $('.video-nav').removeClass('active');


        var tagName = $(event.target).prop("tagName").toLowerCase()

        switch (tagName) {
            case 'li':
                $(event.target).addClass('active')
                break;
            case 'div':
                $(event.target).parent().addClass('active')
                break;
            case 'video':
                $(event.target).parent().parent().addClass('active')
                break;

            default:
                $(event.target).addClass('active')
                break;
        }


        target.find('video').each(function () {
            $(this).get(0).pause();
            $(this).css({ 'opcity': 0, 'z-index': '-1' })
        });

        // $(event.target).parent().parent().addClass('active')

        var video = $(event.target).find('video').get(0);

        if (target.find(`#video-${index}`).length > 0) {
            $(`#video-${index}`).get(0).play();
            $(`#video-${index}`).css({ 'z-index': 1, 'opacity': 1 });

        } else {
            $('.v-layer.video-player').append(` <video class="absolute" id="video-${index}" height='100%' controls>
                <source src=${$(event.target).find('source').attr('src')} type="video/mp4" />
                Your browser does not support the video tag.
                </video>`)
            $(`#video-${index}`).get(0).play();

        }
        // target.find('video').get(0).pause();

        // target.find('video').get(0).play();

    }

    if (isMobile) {
        return <>
            <div className="col-span-12 overflow-x-auto mt-3">
                <ul tabindex="1" class="w-max min-w-full video-tab flex justify-start items-center mobile-vizew-nav-tab">
                    {
                        videos?.map((item, index) => {
                            return <li class={index == 0 ? "nav-link video-nav active h-[90px]" : "nav-link h-[90px] video-nav"} onClick={(event) => player(event, index)}>
                                <div class="h-full flex items-center">
                                    <video className="h-full cursor-pointer">
                                        <source src={`${basePath}/${item}`} type="video/mp4" />
                                        Your browser does not support the video tag.
                                    </video>
                                </div>
                            </li>
                        })
                    }
                </ul>
            </div>
        </>
    } else {
        return <>
            <div className="col-span-12 xl:col-span-4 xxl:col-span-3">
                <ul className="nav video-tab vizew-nav-tab flex content-center max-h-fit min-h-96" role="tablist" tabindex="1">
                    {
                        videos?.map((item, index) => {
                            return <li onClick={(event) => player(event, index)} className={index == 0 ? "w-full nav-item nav-link active h-[120px] video-nav" : "w-full nav-item  nav-link h-[120px] video-nav"}>
                                <div className="xs:w-[200px] sm:w-80 sm:mx-auto md:mx-2 mb-4 h-full flex items-center">
                                    <span className="text-white ml-4" style={{ fontSize: '13pt' }}>{index + 1}</span>
                                    <video className="h-full cursor-pointer">
                                        <source src={`${basePath}/${item}`} type="video/mp4" />
                                        Your browser does not support the video tag.
                                    </video>
                                </div>
                            </li>
                        })
                    }
                </ul>
            </div>
        </>
    }
}