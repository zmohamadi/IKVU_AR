"use client";

import { useConfig } from '@/lib/config';

export const LikedUsers = ({ likeUsers }) => {
    const {mediaPath} = useConfig();

    return(
        likeUsers?.map((users, i)=>{
            let classBg = (users?.like_type_id)? "bg-green-200" : "bg-red-200";
            return(
                <a className={"w-full sm:w-20 mb-2 pr-1 pl-1 sm:mb-0 py-2 rounded-md box dark:bg-dark-5 text-center sm:mx-2 text-white "+classBg}>
                    {users?.user?.firstname+" "+users?.user?.lastname}
                </a>                          
            );
        })
    );
}