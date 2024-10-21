'use client'

export const menu = [
    { title: "dashboard", icon: "Home", href: "/dashboard", access:"2" },
    { title: "myCourses", icon: "Book", href: "/myCourses", access:"2" },
    { title: "myCalendar", icon: "Calendar", href: "/myCalendar" , access:"2" },

    {
        title: "base_management", icon: "Server", open: false, 
        childs: [
            { title: "year_semester", icon: "Aperture", href: "/yearSemesters", access:"1" },
            { title: "guest_systems", icon: "Feather", href: "/systems", access:"1" },
            // { title: "tools", icon: "Tag", href: "/baseTools", access:"1" },
        ]
    },
    {
        title: "courses", icon: "Pocket", open: false, 
        childs: [
            { title: "courses", icon: "Book", href: "/courses", access:"1" },
            { title: "classes", icon: "BookOpen", href: "/classes", access:"1" },
            { title: "lesson_groups", icon: "Package", href: "/categories", access:"1" },
        ]
    },
    {
        title: "quizs", icon: "PenTool", open: false, 
        childs: [
            { title: "quizs", icon: "BookOpen", href: "/quizs", access:"1" },
        ]
    },
    {
        title: "onlineClasses", icon: "Clock", open: false, 
        childs: [
            { title: "onlineClasses", icon: "Book", href: "/onlineClasses", access:"1" },
        ]
    },
    {
        title: "users", icon: "Shield", open: false, 
        childs: [
            { title: "users", icon: "Users", href: "/users", access:"1" },
            { title: "teachers", icon: "Users", href: "/teachers", access:"1" },
            { title: "assistants", icon: "Users", href: "/assistants", access:"1" },
            { title: "students", icon: "Users", href: "/students", access:"1" },
            { title: "personnels", icon: "Users", href: "/personnels", access:"1" },
            { title: "roles", icon: "Framer", href: "/roles", access:"1" },
            // { title: "access", icon: "Settings", href: "/access", access:"1" },
        ]
    },
    // { title: "edit_profile", icon: "User", href: "/editProfile", access:"2" },
    { title: "profile", icon: "User", href: "/viewProfile", access:"2" },
    { title: "change_password", icon: "Lock", href: "/changePassword", access:"2" },
];
