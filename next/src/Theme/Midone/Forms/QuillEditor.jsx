'use client';

import React from 'react';
import {Element} from '../index';

export class QuillEditor extends Element {
    constructor(props){
        super(props);
        this.state = {id: this.getId()};
        this.componentDidMount = this.componentDidMount.bind(this);
    }

    componentDidMount()
    {
        let {id} = this.state;
        let defaultValue = this.getDefaultValue();
        window.ClassicEditor.create(document.querySelector('#'+id))
            .then((editor)=>{
                this.refs.item.editor = editor;
                let val = defaultValue;
                if(val != undefined && val != '' && val != null && val != 'undefined')
                {
                    editor.setData( val );
                }
            })
            .catch(e => {});
    }

    componentWillReceiveProps(props){
        let val = props.defaultValue;
        if(val != undefined && val != '' && val != null)
        {
            this.refs.item.editor.setData(val);
        }
    }

    render(){
        let {onChange, className, options} = this.props;
        let {id} = this.state;

        let label = this.getLabel(),
            helpDiv = this.getHelp(),
            divError = this.checkError(),
            requiredDiv = this.getRequired(),
            defaultValue = this.getDefaultValue();


        return(
            <div className={'card mb-4 editor-card '+className}>
                <label className='form-group has-float-label'>
                    <div className='card-body'>
                        <textarea data-type='editor' id={id} ref='item' defaultValue={defaultValue} {...options}></textarea>
                    </div>
                    <span>
                        {label}
                        {helpDiv}
                        {requiredDiv}
                    </span>
                </label>
                {divError}
            </div>
        );

    }
}
