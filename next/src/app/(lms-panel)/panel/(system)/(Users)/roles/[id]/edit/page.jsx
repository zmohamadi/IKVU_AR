"use client";
import Form from '../../form';

export default function Edit({params}){
    return(
        <div>
            <Form id={params.id}></Form>
        </div>
    );
}