'use client';

import React from 'react';
import {Element, Tools} from './../index';

class Select2 extends Element{
  constructor(props){
      super(props);
      this.state.dataType = 'select2';
      this.createSelect2 = this.createSelect2.bind(this);
  }

  createSelect2(){
      let {options} = this.props;
      let id = this.getId(),
          self = this,
          placeholder = this.getPlaceHolder(),
          defaultValue = this.getDefaultValue();

      if(Tools.isArray(defaultValue)){
          let temp = [];
          defaultValue.map((item)=>{
              temp.push(item.id);
          });
          defaultValue = temp;
      }

      window.$(document).ready(function() {
          window.$(`#${id}`).select2({
              width: '100%',
              theme: 'bootstrap',
              // rtl: true,
              allowClear: true,
              placeholder: placeholder,
              maximumSelectionSize: 6
          }).on('select2:select',(e)=>{
              if (options!=undefined) {
                  options.onChange(e)
              }
          }).on('select2:opening', function (evt) {
              self.removeError();
          });

          if(defaultValue != undefined)
            window.$(`#${id}`).val(defaultValue).trigger('change');
      })
  }

  componentDidMount(){
    this.createSelect2();
  }

  componentDidUpdate(){
    this.createSelect2();
  }

  render(){
        let {multiple, className, disabled, data, valueKey, titleKey, children} = this.props, {dataType} = this.state;

        let helpDiv = this.getHelp(),
            requiredDiv = this.getRequired(),
            divError = this.checkError(),
            label = this.getLabel(),
            id = this.getId();
        if(!titleKey) titleKey = 'title';
        if(!valueKey) valueKey = 'id';

        return(
            <div className={className}>
                <label className={'form-group has-float-label'}>
                    <select
                        id = {id}
                        ref='item'
                        className='form-control select2-single'
                        tabIndex='-1'
                        aria-hidden='true'
                        multiple={Boolean(multiple)}
                        disabled={(disabled == undefined)?false:true}
                    >
                        <option></option>
                        {
                            children
                        }
                        {
                            dataType=='select2'? Tools.getArray(data).map((item, key)=><option key={key} value={item[valueKey]}>{item[titleKey]}</option>) : ''
                        }
                    </select>
                    <span>
                        {requiredDiv}
                        {label}
                        {helpDiv}
                    </span>
                    {divError}
                </label>
            </div>
        );
  }
}

export {Select2};
