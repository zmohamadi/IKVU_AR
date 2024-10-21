
// import FullCalendar from '@fullcalendar/react'
// import dayGridPlugin from '@fullcalendar/daygrid'
// import timeGridPlugin from '@fullcalendar/timegrid'
// import interactionPlugin from '@fullcalendar/interaction'
import PersianCalendar from './PersianCalendar';

export default function MyCalendar({ getEvents, events }) {

    // const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);

    return <div className="col-span-12 xl:col-span-8 xxl:col-span-9" id='customCalendar'>

        <div className="box p-5">
            <PersianCalendar getEvents={getEvents} events={events} />
            {/* <div className="w-full">
                {
                    isMobile ? <FullCalendar
                        plugins={[dayGridPlugin, timeGridPlugin, interactionPlugin]}
                        headerToolbar = {
                            {
                                left: '',
                                right: '',
                                center: 'title'
                            }
                        }
                        // titleFormat={{ year: 'numeric', month: 'short', day: 'numeric' }}
                        footerToolbar={
                            {center: 'prev next'}
                        }
                        dayHeaderFormat={{
                            day: '2-digit'
                        }}

                        // slotLabelFormat={{
                        //     hour: "numeric",
                        //     // hour12: true,
                        // }}
                        slotLabelClassNames={'w-100 text-center'}
                        slotMinTime={"6:00AM"}
                        slotMaxTime={"22:00PM"}

                        initialView='timeGridWeek'
                        weekends={true}
                        locale={'fa'}
                        height={400}
                        firstDay={6}
                        direction="rtl"
                        selectable={false}
                        selectMirror={false}
                        dayMaxEvents={true}
                        events={events}
                    />
                        :
                        <FullCalendar
                            plugins={[dayGridPlugin, timeGridPlugin, interactionPlugin]}
                            headerToolbar={{
                                left: 'prev,next today',
                                center: 'title',
                                right: 'dayGridMonth,timeGridWeek,timeGridDay'
                            }}

                            initialView='dayGridMonth'
                            weekends={true}
                            locale={'fa'}
                            firstDay={6}
                            direction="rtl"
                            selectable={true}
                            selectMirror={true}
                            dayMaxEvents={true}
                            //   events={eventFormat}
                            events={events}
                        />
                }
            </div> */}
        </div>
    </div>
}