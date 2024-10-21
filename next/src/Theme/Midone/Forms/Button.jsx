'use client'

import {useLang} from '@/lib/lang';

export const Button = (props) => {
  let {label, onClick, className, disabled} = props;
  const {Lang} = useLang();

  className = className?className:'btn btn-primary w-20 mr-1 ml-1';
  // if(label=='back') className="btn btn-danger w-20 mr-1 ml-1";
  if(disabled) className += ' disabled';

  return(
      <button
        type='button' 
        className={className} 
        onClick={(event)=> onClick(event)}
        disabled = {disabled}
      >
        {typeof label == "string"? Lang('public.'+label): label}
      </button>
  );
}
