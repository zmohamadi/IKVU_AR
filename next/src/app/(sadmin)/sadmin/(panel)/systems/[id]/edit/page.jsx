"use client"

import {SystemForm} from "../../new/Form";

const EditSystemPage = ({params})=>{
    return <>
        <SystemForm id={params.id} />
    </>
}

export default EditSystemPage;