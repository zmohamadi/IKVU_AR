"use client";
import { Select } from "@/Theme/Midone/Forms/Select";
import { useMemo } from "react";

export function YearGroupFilter({ needles, Lang, className = "col-span-3", filterList, isAdmin = true }) {
  // گروه‌ها را تنها یکبار محاسبه می‌کنیم
  const groups = useMemo(() => (
    Array.from({ length: 11 }, (_, i) => ({
      num: i < 10 ? `0${i}` : i.toString(),
      id: i === 0 ? Lang("public.all_groups") : (i < 10 ? `0${i}` : i.toString()),
    }))
  ), [Lang]);

  if (typeof needles?.group == "string"){
    let gr = needles.group;
    needles.group = []
    needles.group.push(gr);
  }
  console.log("group", typeof needles?.group)

  return (
    <>
      {/* در صورت ادمین بودن، لیست مربوط به yearsemester نمایش داده می‌شود */}
      {isAdmin && (
        <Select
          className={className}
          onChange={(e) => filterList(e, "semester")}
          label="semester"
        >
          {needles?.yearsemester?.map((item, index) => (
            <option key={index} value={`${item.year}${item.semester}`}>
              {`${item.year} (${Lang("public.semester")} ${item.semester})`}
            </option>
          ))}
        </Select>
      )}

      {/* لیست مربوط به group */}
      <Select
        className={className}
        onChange={(e) => filterList(e, "group")}
        label="group"
      >
        {/* گزینه همه گروه‌ها */}
        {/* <option value={`00`}>{Lang("public.all_groups")}</option> */}

        {/* در صورت ادمین بودن از داده groups استفاده می‌شود، در غیر این صورت از needles.group */}
        {isAdmin
          ? groups.map((group, index) => (
            <option key={index} value={group.num}>
              {group.id}
            </option>
          ))
          : needles?.group?.map((item, index) => (
            <option key={index} value={`${item.group}`}>
              {item.slice(-2)} {/* فقط دو رقم آخر نمایش داده می‌شود */}
            </option>
          ))}
      </Select>
    </>
  );
}
