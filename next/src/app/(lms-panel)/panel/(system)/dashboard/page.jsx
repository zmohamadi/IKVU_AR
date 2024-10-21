"use client";

import { useAuth } from "@/lib/auth";
import Student from "./Student";
import Manager from "./Manager";

export default function Dashboard() {
    const { user } = useAuth({ guard: "admin" });
   
    return user?.role_id==2 ? <Student/> : <Manager/> 
    
}