"use client";

import { useRouter } from 'next/navigation';
import { useData,Input,Button,ButtonContainer } from "@/Theme/Midone/Forms";

export const FormScore = ({ toolsId,course,answerId,assignmentScore,answerScore,url,Lang,parent,nextPath }) => {
    const router = useRouter();
    const { save } = useData();

    // Save item and navigate to the next path
    const saveItem = () => save(url+`/num?reply=${answerId}&max=${assignmentScore}`, parent, "edit", `${nextPath}/courses/${course}/tools/assignment/${toolsId}/correcting?${Math.random()}`);

    // Navigate back to the previous page
    const back = () => router.back();

    return(
        <>
            {/* <Input label={Lang(['public.score',' ( ','public.max','public.score'])+" : "+assignmentScore+" ) "} */}
            <Input label="score" defaultValue={answerScore? answerScore : assignmentScore} refItem={[parent, "score"]} required="true" />
            <p><span className="font-bold">{Lang('public.max')} {Lang('public.score')}:</span> {assignmentScore}</p>
            <ButtonContainer>
                <Button label="correcting" onClick={saveItem} />
                <Button label="back" onClick={back} />
            </ButtonContainer>
        </>
    );
}