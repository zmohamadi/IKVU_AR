"use client";

import {useFormElement} from './Element';
import {useEffect, useState} from 'react';
import moment from 'moment-jalaali'
import {DateInput} from 'react-hichestan-datetimepicker';

export function DatePicker(props){
    let {refItem, className, options, name, disabled} = props;

    let Element = useFormElement(props);
    let {id, label, helpDiv, divError, requiredDiv, defaultValue, rand} = Element.init();
    let [state, setState] = useState({
        value: defaultValue? defaultValue: new Date(),
        jvalue: defaultValue
    });
    

    useEffect(()=>{
        setState({...state, value: defaultValue, jvalue: defaultValue});
    }, [refItem[0].state.info]);

    return (
        <div className={className?className:" mb-3 col-span-12 md:col-span-6 "} >
            <label htmlFor={id} className="form-label font-bold">{label} {requiredDiv}</label>
            <DateInput
                    value={state.value}
                    name = {"value"}
                    autoOk={true}
                    // autoPop={true}
                    className="form-control"
                    onChange={function(e){                        
                        setState({
                            value: e.target.value,
                            jvalue: moment(e.target.value, 'YYYY-MM-DD HH:mm:ss').format('jYYYY/jMM/jDD')
                        });
                    }}
                />
            <input
                id = {id}
                name = {name}
                ref={Element.createRef(refItem)}
                key = {'input-'+rand}
                type = {"hidden"}
                defaultValue = {state.jvalue}
               />
            {helpDiv}
            {divError}
        </div>
    );
}
