'use client';

import {useFormElement} from './Element';
import {useState, useEffect} from 'react';

export function Switch(props){
    let {name, value, className, onChange, refItem} = props;
    if(value == undefined) value = 1;
    let Element = useFormElement(props);
    let {id, rand, label, defaultValue, helpDiv, divError, requiredDiv} = Element.init();

    let [state, setState] = useState({
        value: defaultValue,
    });
    
    useEffect(()=>{
        setState({...state, value: defaultValue});
    }, [refItem[0].state.info])
    

    return (<div className={className?className:' mt-3 col-span-12 md:col-span-6'}> <label>{label}</label>
        <div className='mt-2'>
            <div className='form-check'> 
                <input id={id} 
                    className='form-check-switch' 
                    type='checkbox'
                    defaultChecked={state.value==1?true:false}
                    key={'checkbox-'+rand}
                    value={value}
                    onChange={function(e){
                        state.value = e.target.checked?value:0;
                        onChange && onChange(state.value);
                    }}
                /> 
                <label className='form-check-label' htmlFor={id} >
                    {name}
                    {requiredDiv}
                </label>
                {divError}
                {helpDiv}
            </div>
        </div>
    </div>
    );
}
