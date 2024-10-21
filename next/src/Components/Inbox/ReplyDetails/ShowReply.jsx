"use client";

import { useRouter } from 'next/navigation';
import { useFormRefs, ButtonContainer, Button, Box } from "@/Theme/Midone/Forms";
import { useLang } from '@/lib';

export function ShowReply({data }) {
    const { Lang } = useLang();

    const router = useRouter();

    const back = () => router.back();

    return (
        <>
            <Box cols="grid-cols-1">
                <li><strong>{Lang("public.message")} :</strong>{data?.text}</li>
                <li><strong>{Lang("public.reply")} :</strong>{data?.reply}</li>
            </Box>
            <ButtonContainer>
                <Button label="back" onClick={back} />
            </ButtonContainer>
        </>
    );
}
