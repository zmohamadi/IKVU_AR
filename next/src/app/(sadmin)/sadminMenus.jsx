// data-feather
export const menus = [
    // {name:"", title:"", icon:"", href:"", childs:[]},
    {
        name:"dashboard", title:"پیشخوان", icon:"box", href:"/dashboard"
    },
    {
        name:"base_info", title:"اطلاعات پایه", icon:"grid", open:false, 
        childs:[
            {name:"keyword", title:"زیر سیستم ها", icon:"users", href:"/systems",},
            {name:"country", title:"منوها", icon:"users", href:"/menus",},
        ]
    },
    {
        name:"users", title:"کاربران", icon:"grid", open:false, 
        childs:[
            {name:"user", title:"نقش ها", icon:"users", href:"/roles",},
            {name:"personnel", title:"دسترسی ها", icon:"users", href:"/accesses",},
        ]
    },
    {
        name:"users", title:"راهنما", icon:"grid", open:false, 
        childs:[
            {name:"icons", title:"آیکون ها", icon:"users", href:"/icons",},
        ]
    },
    {name:"pass", title:"تغییر رمز عبور", icon:"lock", href:"/build"},
];