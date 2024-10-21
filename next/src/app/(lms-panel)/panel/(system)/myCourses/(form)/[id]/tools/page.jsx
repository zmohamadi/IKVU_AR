"use client";
import { Tools } from "@/Components/Public/Tools"

export default function page({ params }) {
    return(
        <div>
            <Tools path="myCourses" courseId={params.id} />
        </div>
    );
}