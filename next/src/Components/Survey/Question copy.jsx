"use client";
import { useEffect, useState } from "react";
import { useLang } from "@/lib";
import { Input, Textarea, Box } from "@/Theme/Midone/Forms";

const OptionInput = ({ index, optionIndex, option, parent, questionIndex }) => (
    <div className="col-span-12 grid grid-cols-12">
        <Input
            label={`option_${optionIndex + 1}`}
            refItem={[parent, `qOption_${questionIndex}#${optionIndex}`]}
            defaultValue={option?.title}
            className="col-span-10"
        />
        <Input
            label={`order`}
            refItem={[parent, `orderOption_${questionIndex}#${optionIndex}`]}
            defaultValue={(option?.order)? option?.order : optionIndex +1}
            className="col-span-2 mr-3"
        />
    </div>
);

export function Question({ index, parent, addIcon, closeIcon }) {
    const { Lang } = useLang();
    const question = parent?.state?.info?.questions?.[index];
    const [answerType, setAnswerType] = useState(question?.question_type_id === 2 ? 2 : 1);

    useEffect(() => {
        setAnswerType(question?.question_type_id === 2 ? 2 : 1);
    }, [question]);

    const options = Array.from({ length: 4 }, (_, i) => ({
        id: question?.question_options?.[i]?.id || i + 1,
        ...question?.question_options?.[i],
    }));

    return (
        <Box shadow={false}>
            <div className="col-span-12 flex justify-end items-end">
                {closeIcon}
            </div>
            
            <Textarea
                className="col-span-9"
                label={`${Lang("public.question")} ${index + 1}`}
                required="true"
                refItem={[parent, `question_${index}`]}
                defaultValue={question?.title}
            />
            <div className="col-span-3">
                <div className="grid p-1 gap-4 grid-cols-1">
                    {question?.id && (
                        <Input
                            type="hidden"
                            refItem={[parent, `id_${index}`]}
                            defaultValue={question?.id}
                        />
                    )}
                    <Input
                        className="col-span-12"
                        label={Lang("public.order")}
                        required="true"
                        refItem={[parent, `order_${index}`]}
                        defaultValue={(question?.order)? question?.order : index +1}
                        // defaultValue={question?.order}
                    />
                </div>
            </div>
            {options.map((option, optionIndex) => (
                <OptionInput
                    key={optionIndex}
                    index={index}
                    optionIndex={optionIndex}
                    option={option}
                    parent={parent}
                    questionIndex={index}
                />
            ))}
            <div className="col-span-12 flex justify-start items-start">
                {addIcon}
            </div>
        </Box>
    );
}
