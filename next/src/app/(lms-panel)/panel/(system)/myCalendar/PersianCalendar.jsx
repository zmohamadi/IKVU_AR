import { Calendar } from '@ijavad805/react-datepicker';
import Link from 'next/link';
import { useEffect } from 'react';

export default function PersianCalendar({ getEvents, events }) {

  const isMobile = /iPhone|iPad|iPod|Android/i.test(navigator.userAgent);

  useEffect(() => {
    if (isMobile) {
      removeDayName()
      $('th').each(function () {
        switch ($(this).text()) {
          case 'شنبه':
            $(this).text('ش')
            break;
          case 'یک‌شنبه':
            $(this).text('ی')
            break;
          case 'دوشنبه':
            $(this).text('دو')
            break;
          case 'سه‌شنبه':
            $(this).text('س')
            break;
          case 'چهارشنبه':
            $(this).text('چ')
            break;
          case 'پنج‌شنبه':
            $(this).text('پ')
            break;
          case 'جمعه':
            $(this).text('ج')
            break;
          default:
            break;
        }
      })
    }

  }, [])

  const monthHandler = month => {
    getEvents(month)
    isMobile && removeDayName(true);
  }

  return <>
    <div className='w-full'
      style={{
        direction: 'rtl',
      }}
    >
      <Calendar
        events={events}
        lang="fa"
        onClickEvent={function noRefCheck(event) { modalEvent(event) }}
        onMonthChange={function noRefCheck(month) { monthHandler(month) }}
        onDateClick={function noRefCheck() { }}
        onDay={function noRefCheck() { }}
        onDropEvent={function noRefCheck() { }}
      />
    </div>
  </>
}

function modalEvent(event) {
  let formatter = new Intl.DateTimeFormat('fa-IR', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: 'numeric'
    // timeZoneName: 'UTC'
  });

  $('body').append(`<div class="event-modal fixed flex justify-center items-center top-0 left-0 bottom-0 right-0">
      <div class="event-modal-card">
        <div class="relative flex justify-between pb-1 event-modal-header">
          ${ event.status == 'expire' ? `<span class="absolute -top-8 bg-red-500 text-white rounded py-1 px-3"
            style='box-shadow: 0 4px 11px -3px black; right: calc(50% - 75px)'
          >این رویداد پایان یافته است</span>` : ''}
          <h3>مشاهده رویداد</h3>
          <span class="cursor-pointer hover:font-extrabold hover:text-red-600" onclick="$('.event-modal').remove()">x</span>
        </div>
        <div class="mt-4">
          <ul>
            <li>
              <h3 class="font-semibold">
                ${event?.title}
              </h3>
            </li>
            <li class="mt-1">
              ${event?.date?.start == event?.date?.end ? `<p>
                <span>${formatter.format(new Date(event?.date?.start + ' ' + event.start))}</span>
              </p>` : `<p>
                <span>از </span>
                <span>${formatter.format(new Date(event?.date?.start + ' ' + event.start))}</span>
                <span> تا </span>
                <span>${formatter.format(new Date(event?.date?.end))}</span>
              </p>`
    }
              
            </li>
            ${event.url && event.status == 'not-expire' ? `<a class="btn btn-info mt-3" href="${event.url}">
      مشاهده
    </a>`
      : ''

    }
          </ul>
        </div>
      </div>
    </div>`)
}

function removeDayName(sleep) {
  if (sleep) {
    setTimeout(() => {
      $('.__calendar-table-td-body-date').each(function () {
        var text = $(this).text(); // دریافت متن درون تگ <td>
        var numericText = text.replace(/\D/g, ''); // حذف تمام کاراکترهای غیرعددی
        $(this).text(numericText); // اعمال متن عددی بر روی تگ <td>
      })
    }, 5);
  } else {
    $('.__calendar-table-td-body-date').each(function () {
      var text = $(this).text(); // دریافت متن درون تگ <td>
      var numericText = text.replace(/\D/g, ''); // حذف تمام کاراکترهای غیرعددی
      $(this).text(numericText); // اعمال متن عددی بر روی تگ <td>
    })
  }
}