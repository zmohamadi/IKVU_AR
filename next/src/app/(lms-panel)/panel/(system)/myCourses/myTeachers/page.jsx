"use client";
import List from '@/app/(lms-panel)/panel/(system)/(Users)/users/page';
import { usePathname } from 'next/navigation';

export default function Teachers(){
    const menuPath = usePathname().split('/').includes('myCourses') ? 'myCourses' : 'users';
    return(
        <div>
            <List menuPath={menuPath} title="teachers" link="/myTeachers" displayRole={false} view={true} resume={true}></List>
        </div>
    );
}