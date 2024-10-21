"use client"

// import {useAuth} from "@/lib/auth";
import {config} from "@/lib/config";
import { useRouter } from 'next/navigation'

export default function Main(){
    // let {user} = useAuth({guard: "admin"});
    // const {user} = useAuth({guard: "admin"});
    const router = useRouter()
    // console.log("user is:", user);
    // if(!user) {
    //     router.push(config.mastership()+"/login");
    // }else{
    router.push(config.mastership()+"/dashboard");
    // }
}