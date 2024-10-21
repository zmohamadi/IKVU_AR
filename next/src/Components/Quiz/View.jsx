"use client";
import { useEffect } from "react";
import { useLang } from "@/lib/lang";
import { FeatherIcon, Tools, useData, useFormRefs } from "@/Theme/Midone/Utils";
import { Box, Button, ButtonContainer, Frame } from "@/Theme/Midone/Forms";
import { useRouter } from 'next/navigation';
import Link from "next/link";
import { useConfig } from "@/lib";

export function View({ laraPath, id, access }) {
    const { laraAdmin, nextAdmin } = useConfig();
    const router = useRouter();
    const { Lang, local } = useLang();
    const component = useFormRefs();
    const { get } = useData();
    const formUrl = "/quiz";
    const url = `${laraPath}${formUrl}/${id}`;

    useEffect(() => {
        get(url, component, "info");
    }, []);

    const data = component?.state?.info;
    const groupDetails = getGroupDetails(data?.group, Lang);

    return (
        <>
            <Frame title={Lang(["public.quiz"])}>
                <QuizDetails data={data} groupDetails={groupDetails} Lang={Lang} local={local} access={access} />
                <QuestionsList questions={data?.questions} Lang={Lang} />
                {access && <Reports data={data} Lang={Lang} nextAdmin={nextAdmin} />}
            </Frame>
            <ButtonContainer>
                <Button label="back" onClick={() => router.back()} />
            </ButtonContainer>
        </>
    );
}

function getGroupDetails(group, Lang) {
    if (group > 0) {
        const year = group.substr(0, 4);
        const semester = group.substr(4, 1);
        const groupCode = group.substr(5, 2);

        let groupDetails = `${Lang("public.year")} : ${year} , ${Lang("public.semester")} : ${semester} , `;
        groupDetails += groupCode > 0 ? `${Lang("public.group")} : ${groupCode}` : Lang("public.all_groups");
        return groupDetails;
    }
    return Lang("public.all_time");
}

function QuizDetails({ data, groupDetails, Lang, access, local }) {
    return (
        <Box title={Lang("public.detail")}>
            <div className="col-span-12">
                <div className="grid grid-cols-12 gap-4">
                    <QuizBasicInfo data={data} groupDetails={groupDetails} Lang={Lang} />
                    {access && <QuizAdditionalInfo data={data} Lang={Lang} local={local} />}
                </div>
            </div>
        </Box>
    );
}

function QuizBasicInfo({ data, groupDetails, Lang }) {
    return (
        <>
            <div className="col-span-12 text-sm md:text-base lg:text-lg">{groupDetails}</div>
            <div className="col-span-12 mb-3 text-sm md:text-base lg:text-lg">
                <span className="font-bold">{Lang("public.title")} :</span> {data?.title}
            </div>
            <div className="col-span-12 mb-3 text-sm md:text-base lg:text-lg">
                <span className="font-bold">{Lang("public.description")} :</span>
                <div dangerouslySetInnerHTML={{ __html: data?.description }}></div>
            </div>
            <div className="col-span-12 md:col-span-4">
                <span className="font-bold">{Lang("public.start_date")} :</span>
                <span className="ltr">{`${data?.start_date} - ${data?.start_time}`}</span>
            </div>
            <div className="col-span-12 md:col-span-4">
                <span className="font-bold">{Lang("public.end_date")} :</span>
                <span className="ltr">{`${data?.end_date} - ${data?.end_time}`}</span>
            </div>
            <div className="col-span-12 md:col-span-4">
                <span className="font-bold">{Lang("public.limit_time")} :</span> {data?.limit_time}
            </div>
            <div className="col-span-12 md:col-span-4">
                <span className="font-bold">{Lang("public.question_count")} :</span> {data?.question_count}
            </div>
            <div className="col-span-12 md:col-span-4">
                <span className="font-bold">{Lang("public.total_score")} :</span> {data?.total_score}
            </div>
        </>
    );
}

function QuizAdditionalInfo({ data, Lang, local }) {
    return (
        <>
            <div className="col-span-12 md:col-span-4">
                <span className="font-bold">{Lang("public.one_page")} :</span>
                {data?.one_page == 1 ? Lang("public.yes") : Lang("public.no")}
            </div>
            <div className="col-span-12 md:col-span-4">
                <span className="font-bold">{Lang("public.creator")} :</span>
                {`${data?.creator?.firstname} ${data?.creator?.lastname}`}
            </div>
            <div className="col-span-12 md:col-span-4">
                <span className="font-bold">{Lang("public.created_at")} :</span>
                <span className="ltr">{Tools.toJalaliDateString(data?.created_at)}</span>
            </div>
            <div className="col-span-12 md:col-span-4">
                <span className="font-bold">{Lang("public.status")} :</span>
                {data?.active_status?.[`title_${local}`]}
            </div>
        </>
    );
}

function QuestionsList({ questions, Lang }) {
    return (
        <Box title={Lang("public.questions")}>
            {Tools.getArray(questions).map((question, index) => (
                <QuestionBox key={index} question={question} index={index} Lang={Lang} />
            ))}
        </Box>
    );
}

function QuestionBox({ question, index, Lang }) {
    const questionTitle = `${Lang("public.question")} ${index + 1} ) ${question?.title}`;
    return (
        <>
            <p className="col-span-12 text-sm md:text-base lg:text-lg">
                <b>{questionTitle}</b> ({Lang("public.score_bar")}: {question?.score})
            </p>
            {question?.question?.question_type_id !== 1 && <MultipleChoiceQuestion question={question} Lang={Lang} />}
        </>
    );
}

function MultipleChoiceQuestion({ question, Lang }) {
    return (
        <>
            {Tools.getArray(question?.question_options).map((option, index) => (
                <p key={index} className="col-span-12 pl-5 text-sm md:text-base lg:text-lg">
                    {`${index + 1}) ${option?.title}`}
                </p>
            ))}
        </>
    );
}

function Reports({ data, Lang, nextAdmin }) {
    return (
        <>
            <Box title={Lang("public.reports")}>
                <div className="col-span-12">
                    <div className="grid grid-cols-12 gap-4">
                        <ReportInfo data={data} Lang={Lang} />
                    </div>
                </div>
            </Box>
            <Box title={Lang("public.participants")}>
                <div className="col-span-12 text-center btn btn-outline-primary">
                    <Link href={`${nextAdmin}/courses/${data?.course_id}/tools/quiz/${data.id}/correcting`}>
                        {Lang("public.click_here_for_users")}
                    </Link>
                </div>
            </Box>
        </>
    );
}

function ReportInfo({ data, Lang }) {
    return (
        <>
            <div className="col-span-12 md:col-span-4">
                <span className="font-bold">{Lang("public.response_count")} :</span> {data?.answer_count}
            </div>
            <div className="col-span-12 md:col-span-4">
                <span className="font-bold">{Lang("public.corrected_count")} :</span> {data?.corrected_count}
            </div>
            <div className="col-span-12 md:col-span-4">
                <span className="font-bold">{Lang("public.min")} {Lang("public.score")} :</span> {data?.min}
            </div>
            <div className="col-span-12 md:col-span-4">
                <span className="font-bold">{Lang("public.max")} {Lang("public.score")} :</span> {data?.max}
            </div>
            <div className="col-span-12 md:col-span-4">
                <span className="font-bold">{Lang("public.avg")} {Lang("public.score")} :</span> {data?.avg}
            </div>
        </>
    );
}
