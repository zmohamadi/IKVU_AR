"use client";

import Form from '../../form';

export default function Edit({params}){

  //console.log("params!!", params);

    return(
        <div>
            <Form id={params.id}></Form>
        </div>
    );
}