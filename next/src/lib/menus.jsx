'use client'
// import { useAuth } from "@/lib/auth";
// const { user } = useAuth({ guard: "admin" });

export const getMenus = (user) => {
    // نقش های استاد دانشجو و استادیار منوی محدود دارند
    const access = ![1, 2, 3].includes(user?.role_id); 

    const commonMenus = [
        { title: "dashboard", icon: "Home", href: "/dashboard" },
        { title: "myCourses", icon: "Book", href: "/myCourses" },
        { title: "myCalendar", icon: "Calendar", href: "/myCalendar" }
    ];

    const adminMenus = [
        // {
        //     title: "base_management", icon: "Server", open: false, 
        //     childs: [
        //         { title: "year_semester", icon: "Aperture", href: "/yearSemesters" },
        //         { title: "guest_systems", icon: "Feather", href: "/systems" },
        //         // { title: "tools", icon: "Tag", href: "/baseTools" },
        //     ]
        // },
        {
            title: "courses", icon: "Pocket", open: false, 
            childs: [
                { title: "courses", icon: "Book", href: "/courses" },
                { title: "classes", icon: "BookOpen", href: "/classes" },
                { title: "lesson_groups", icon: "Package", href: "/categories" },
                { title: "year_semester", icon: "Aperture", href: "/yearSemesters" },
                { title: "guest_systems", icon: "Feather", href: "/systems" },
            ]
        },
        {
            title: "tools", icon: "PenTool", open: false, 
            childs: [
                { title: "onlineClasse_today", icon: "Book", href: "/onlineClasses" },
                { title: "quizs", icon: "BookOpen", href: "/quizs" },
            ]
        },
        {
            title: "users", icon: "Shield", open: false, 
            childs: [
                { title: "users", icon: "List", href: "/users" },
                { title: "teachers", icon: "PenTool", href: "/teachers" },
                { title: "assistants", icon: "Feather", href: "/assistants" },
                { title: "students", icon: "Users", href: "/students" },
                { title: "personnels", icon: "Aperture", href: "/personnels" },
                { title: "roles", icon: "Framer", href: "/roles" },
                // { title: "access", icon: "Settings", href: "/access" },
            ]
        },
        // {
        //     title: "reports", icon: "Monitor", open: false, 
        //     childs: [
        //         { title: "reports", icon: "Monitor", href: "/reports" },
        //     ]
        // }
    ];
    const commonMenus2 = [
        // { title: "edit_profile", icon: "User", href: "/editProfile" },
        { title: "profile", icon: "User", href: "/viewProfile" },
        { title: "change_password", icon: "Lock", href: "/changePassword" },
    ];

    return access ? [...commonMenus, ...adminMenus,...commonMenus2] :  [...commonMenus,...commonMenus2];
};
