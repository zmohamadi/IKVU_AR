"use client";
import { useEffect, useState } from "react";
import { useLang } from "@/lib/lang";
import { Frame, Box, ButtonContainer, Button, useFormRefs, CourseToolsBtn, BackBtn } from "@/Theme/Midone/Forms";
import { usePathname, useRouter } from 'next/navigation';
import Link from "next/link";
import { useData } from "@/lib/data";
import { Tools } from "@/Theme/Midone";
import { Select } from "@/Theme/Midone/Forms/Select";

export function Page({ laraPath, course, nextPath = "",access }) {
    const { Lang } = useLang();
    const router = useRouter();
    let component = useFormRefs();
    const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'courses';
    let { get,getNeedles} = useData();
    const [ group, setGroup] = useState(0);
    const [ loading, setLoading] = useState(true);
    const [ archives, setArchives] = useState([]);
    const [needles, setNeedles] = useState();

    const handleFilterChange = (e) => {
        setGroup(e.target.value);
    };

    useEffect(() => {
        // Fetch the user group first
        !access&& get(`${laraPath}/getUserGroup/${course}`, component, "info", (data) => {
            setGroup(data);
        });
    }, []);
    useEffect(() => {
        access&& getNeedles(`${laraPath}/getCurrentSemester`, setNeedles);
    }, []);

    useEffect(() => {
        // Fetch archives if group is set and greater than 0
        if (group > 0) {
            setLoading(true); // Start loading
            get(`${laraPath}/onlineClassroomArchives/${course}/${group}`, component, "info", (data) => {
                setArchives(data); // Set fetched data to state
                setLoading(false); // End loading
            });
        } else {
            setArchives([]); // Reset archives if no group is selected
            setLoading(false);
        }
    }, [group]);

    const back = () => router.back();
    const yearsemester = needles?.year+needles?.semester;
    // console.log(yearsemester);

    return (
        <>
            <Frame title={Lang(["public.online_archives"])}>
                <Box>
                    {access&&
                        <Select placeholder="یک گروه را انتخاب کنید" label="group" name="group" value={group} onChange={handleFilterChange}>
                            <option value={yearsemester+"01"}>1</option>
                            <option value={yearsemester+"02"}>2</option>
                            <option value={yearsemester+"03"}>3</option>
                            <option value={yearsemester+"04"}>4</option>
                        </Select>
                    }
                    <div className="table-responsive table-strips overflow-x-auto col-span-12">
                        {loading ? (
                            <div className="text-center">در حال بارگذاری داده‌ها...</div>
                        ) : (
                            <table className="table" role="grid" id="grid">
                                <thead>
                                    <tr className="bg-gray-200 dark:bg-dark-2 text-neutral-800 font-extrabold border-b-4">
                                        <th className="border-b-2 dark:border-dark-5 whitespace-nowrap font-bold w-10">#</th>
                                        <th className="border-b-2 dark:border-dark-5 whitespace-nowrap">تاریخ</th>
                                        <th className="border-b-2 dark:border-dark-5 whitespace-nowrap text-right w-32">دانلود</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {Tools.getArray(archives).map((item, index) => (
                                        <tr key={item.id} className={`bg-white dark:bg-dark-1 intro-x ${index % 2 === 0 ? "odd:bg-white" : "even:bg-gray-200"}`}>
                                            <td className="border-b dark:border-dark-5">{index + 1}</td>
                                            <td className="border-b dark:border-dark-5">{item.date}</td>
                                            <td className="border-b dark:border-dark-5 text-right">
                                                <a href={item?.url[0]} className="text-blue-500 hover:text-blue-700">
                                                   مشاهده
                                                </a>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        )}
                    </div>
                </Box>
            </Frame>
            <ButtonContainer>
                <CourseToolsBtn href={`${nextPath}/${menuPath}/${course}/tools`} />
                <BackBtn onClick={back} />
            </ButtonContainer>
           
        </>
    );
}
