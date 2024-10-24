<?php

return [
    /*
    |--------------------------------------------------------------------------
    | Validation Language Lines
    |--------------------------------------------------------------------------
    |
    | The following language lines contain the default error messages used by
    | the validator class. Some of these rules have multiple versions such
    | as the size rules. Feel free to tweak each of these messages here.
    |
    */

    'accepted'             => ':attribute يجب أن يكون مقبولاً.',
    'active_url'           => ':attribute غيرصالحة URL.',
    'after'                => ':attribute يجب أن يكون تاريخاً بعد :date.',
    'after_or_equal'       => ':attribute يجب أن يكون تاريخاً بعد أو يساوي :date.',
    'alpha'                => ':attribute يجب أن يحتوي فقط على حروف.',
    'alpha_dash'           => ':attribute يجب أن يحتوي فقط على حروف، أرقام، شرطات وخطوط سفلية.',
    'alpha_num'            => ':attribute يجب أن يحتوي فقط على حروف وأرقام.',
    'array'                => ':attribute يجب أن يكون مصفوفة.',
    'before'               => ':attribute يجب أن يكون تاريخاً قبل :date.',
    'before_or_equal'      => ':attribute يجب أن يكون تاريخاً قبل أو يساوي :date.',
    'between'              => [
        'numeric' => ':attribute يجب أن يكون بين :min إلی :max.',
        'file'    => ':attribute يجب أن يكون بين :min إلی :max كيلوبايت.',
        'string'  => ':attribute يجب أن يكون بين :min إلی :max حرفاً.',
        'array'   => ':attribute يجب أن يحتوي على عناصر بين :min إلی :max.',
    ],
    'boolean'              => 'حقل :attribute يجب أن يكون صحيحاً أو خاطئاً.',
    'confirmed'            => ':attribute لا يتطابق مع الحقل المكرر.',
    'date'                 => ':attribute ليس تاريخاً صالحاً.',
    'date_equals'          => ':attribute يجب أن يكون تاريخاً يساوي :date.',
    'date_format'          => ':attribute لا يتطابق مع التنسيق :format.',
    'different'            => ':attribute و :other يجب أن يكونا مختلفين.',
    'digits'               => ':attribute يجب أن يكون :digits رقماً.',
    'digits_between'       => ':attribute يجب أن يكون بين :min إلی :max رقماً.',
    'dimensions'           => 'أبعاد الصورة :attribute غير صالحة.',
    'distinct'             => 'حقل :attribute يحتوي على قيمة مكررة.',
    'email'                => ':attribute يجب أن يكون عنوان بريد إلكتروني صالحاً.',
    'ends_with'            => 'يجب أن ينتهي :attribute بأحد القيم التالية: :values',
    'exists'               => 'القيمة المختارة :attribute غير صالحة.',
    'file'                 => ':attribute يجب أن يكون ملفاً صالحاً.',
    'filled'               => 'حقل :attribute يجب أن يحتوي على قيمة.',
    'gt'                   => [
        'numeric' => ':attribute يجب أن يكون أكبر من :value.',
        'file'    => ':attribute يجب أن يكون أكبر من :value كيلوبايت.',
        'string'  => ':attribute يجب أن يحتوي على أكثر من :value حرفاً.',
        'array'   => ':attribute يجب أن يحتوي على أكثر من :value عنصر.',
    ],
    'gte'                  => [
        'numeric' => ':attribute يجب أن يكون أكبر من أو يساوي :value.',
        'file'    => ':attribute يجب أن يكون أكبر من أو يساوي :value كيلوبايت.',
        'string'  => ':attribute يجب أن يحتوي على :value حرفاً أو أكثر.',
        'array'   => ':attribute يجب أن يحتوي على :value عناصر أو أكثر.',
    ],
    'image'                => ':attribute يجب أن يكون صورة صالحة.',
    'in'                   => 'القيمة المختارة :attribute غير صالحة.',
    'in_array'             => 'حقل :attribute غير موجود في :other.',
    'integer'              => ':attribute يجب أن يكون عدد صحيح.',
    'ip'                   => ':attribute يجب أن يكون عنوان IP صالحاً.',
    'ipv4'                 => ':attribute يجب أن يكون عنوان IPv4 صالحاً.',
    'ipv6'                 => ':attribute يجب أن يكون عنوان IPv6 صالحاً.',
    'json'                 => ':attribute يجب أن يكون سلسلة JSON صالحة.',
    'lt'                   => [
        'numeric' => ':attribute يجب أن يكون أقل من :value.',
        'file'    => ':attribute يجب أن يكون أقل من :value كيلوبايت.',
        'string'  => ':attribute يجب أن يحتوي على أقل من :value حرفاً.',
        'array'   => ':attribute يجب أن يحتوي على أقل من :value عنصر.',
    ],
    'lte'                  => [
        'numeric' => ':attribute يجب أن يكون أقل من أو يساوي :value.',
        'file'    => ':attribute يجب أن يكون أقل من أو يساوي :value كيلوبايت.',
        'string'  => ':attribute يجب أن يحتوي على أقل من أو يساوي :value حرفاً.',
        'array'   => ':attribute يجب ألا يحتوي على أكثر من :value عناصر.',
    ],
    'max'                  => [
        'numeric' => ':attribute لا يجوز أن يكون أكبر من :max.',
        'file'    => ':attribute لا يجوز أن يكون أكبر من :max كيلوبايت.',
        'string'  => ':attribute لا يجوز أن يحتوي على أكثر من :max حرفاً.',
        'array'   => ':attribute لا يجوز أن يحتوي على أكثر من :max عناصر.',
    ],
    'mimes'                => 'يجب أن يكون :attribute ملفاً من نوع: :values.',
    'mimetypes'            => 'يجب أن يكون :attribute ملفاً من نوع: :values.',
    'min'                  => [
        'numeric' => ':attribute يجب أن يكون على الأقل :min.',
        'file'    => ':attribute يجب أن يكون على الأقل :min كيلوبايت.',
        'string'  => ':attribute يجب أن يحتوي على الأقل :min حرفاً.',
        'array'   => ':attribute يجب أن يحتوي على الأقل :min عناصر.',
    ],
    'multiple_of'          => 'يجب أن يكون :attribute مضاعفاً لـ :value',
    'not_in'               => 'القيمة المختارة :attribute غير صالحة.',
    'not_regex'            => 'تنسيق :attribute غير صالح.',
    'numeric'              => ':attribute يجب أن يكون رقماً.',
    'password'             => 'كلمة المرور غير صحيحة.',
    'current_password'     => 'كلمة المرور غير صحيحة.',
    'present'              => 'يجب أن يكون حقل :attribute موجوداً.',
    'regex'                => 'تنسيق :attribute غير صالح.',
    'required'             => 'حقل :attribute مطلوب.',
    'required_if'          => 'حقل :attribute مطلوب عندما يكون :other هو :value.',
    'required_unless'      => 'حقل :attribute مطلوب ما لم يكن :other موجوداً في :values.',
    'required_with'        => 'حقل :attribute مطلوب عندما يكون :values موجوداً.',
    'required_with_all'    => 'حقل :attribute مطلوب عندما تكون :values موجودة.',
    'required_without'     => 'حقل :attribute مطلوب عندما لا يكون :values موجوداً.',
    'required_without_all' => 'حقل :attribute مطلوب عندما لا تكون أي من :values موجودة.',
    'same'                 => ':attribute و :other يجب أن يتطابقا.',
    'size'                 => [
        'numeric' => ':attribute يجب أن يكون :size.',
        'file'    => ':attribute يجب أن يكون :size كيلوبايت.',
        'string'  => ':attribute يجب أن يحتوي على :size حرفاً.',
        'array'   => ':attribute يجب أن يحتوي على :size عناصر.',
    ],
    'starts_with'          => 'يجب أن يبدأ :attribute بأحد القيم التالية: :values',
    'string'               => ':attribute يجب أن يكون سلسلة نصية.',
    'timezone'             => ':attribute يجب أن يكون منطقة زمنية صالحة.',
    'unique'               => ':attribute قد تم أخذه سایقا.',
    'uploaded'             => ' تحميل غیر ناجحة :attribute.',
    'url'                  => ':attribute ليس عنوان URL صالح.',
    'uuid'                 => ':attribute يجب أن يكون UUID صالحاً.',

    /*
    |--------------------------------------------------------------------------
    | Custom Validation Language Lines
    |--------------------------------------------------------------------------
    |
    | Here you may specify custom validation messages for attributes using the
    | convention "attribute.rule" to name the lines. This makes it quick to
    | specify a specific custom language line for a given attribute rule.
    |
    */

    'custom' => [
        'attribute-name' => [
            'rule-name' => 'custom-message',
        ],
        'title_fa' => [
            'required' => 'العنوان مطلوب',
        ],
        'title_ar' => [
            'required' => 'العنوان مطلوب',
        ],
        'title_en' => [
            'required' => 'Title is required',
        ],
        'name_fa' => [
            'required' => 'الاسم مطلوب',
        ],
        'name_ar' => [
            'required' => 'الاسم مطلوب',
        ],
        'name_en' => [
            'required' => 'Name is required',
        ],
        'lname_fa' => [
            'required' => 'النسبة مطلوبة',
        ],
        'lname_ar' => [
            'required' => 'الكنية مطلوبة',
        ],
        'lname_en' => [
            'required' => 'Last name is required',
        ],
        'nationality_fa' => [
            'required' => 'الجنسية مطلوبة',
        ],
        'nationality_ar' => [
            'required' => 'الجنسية مطلوبة',
        ],
        'nationality_en' => [
            'required' => 'Nationality is required',
        ],
        'text_fa' => [
            'required' => 'النص مطلوب',
        ],
        'text_ar' => [
            'required' => 'النص مطلوب',
        ],
        'text_en' => [
            'required' => 'Text is required',
        ],
        'description_fa' => [
            'required' => 'توضیح الزامیست',
        ],
        'description_ar' => [
            'required' => 'وصف اجباری',
        ],
        'description_en' => [
            'required' => 'description required',
        ],
        'summary_fa' => [
            'required' => 'خلاصه الزامیست',
        ],
        'summary_ar' => [
            'required' => 'ملخص اجباری',
        ],
        'summary_en' => [
            'required' => 'summary required',
        ],
        // Add more translations as needed
    ],
    
    /*
    |--------------------------------------------------------------------------
    | Custom Validation Attributes
    |--------------------------------------------------------------------------
    |
    | The following language lines are used to swap attribute place-holders
    | with something more reader friendly such as E-Mail Address instead
    | of "email". This simply helps us make messages a little cleaner.
    |
    */

    'attributes' => [
        'name'                    => 'الإسم',
        'lname'                   => 'النسبة',
        'username'                => 'اسم المستخدم',
        'password'                => 'كلمة المرور',
        'password_repeat'         => 'تأكيد كلمة المرور',
        'order*'                   => 'ترتيب',
        'title'                   => 'عنوان',
        'label'                   => 'ملصق',
        'day'                     => 'یوم',
        'month'                   => 'الشهر',
        'year'                    => 'عام',
        'hour'                    => 'الساعة',
        'minute'                  => 'دقيقة',
        'second'                  => 'ثواني',
        'identi_code'             => 'رقم الهوية الوطنية',
        'gender_id'               => 'الجنس',
        'mobile'                  => 'موبايل',
        'tel'                     => 'هاتف',
        'phone'                   => 'هاتف',
        'address'                 => 'عنوان',
        'email'                   => 'البريد الإلكتروني',
        'about'                   => 'حول',
        'gender'                  => 'الجنس',
        'role_id'                 => 'دور',
        'role'                    => 'دور',
        'pic'                     => 'صورة الملف الشخصي',
        'image'                   => 'صورة',
        'logo'                    => 'شعار',
        'icon'                    => 'أيقونة',
        'text'                    => 'نص',
        'description'             => 'الوصف',
        'summary'                 => 'ملخص',
        'dir'                     => 'ترتيب',
        'symbol'                  => 'عنوان مختصر',
        'num'                     => 'عدد',
        'group_id'                => 'مجموعة',
        'code'                    => 'رمز',
        'view'                    => 'عرض',
        'subject_id'              => 'الموضوع',
        'parent_subject_id'       => 'موضوع الوالد',
        'category_id'             => 'فئة',
        'parent_category_id'      => 'فئة الوالد',
        'video'                   => 'فيديو',
        'full_name'               => 'الإسم & النسبة',
        'latin_name'              => 'الاسم اللاتيني',
        'reply'                   => 'الجواب',
        'title2'                  => 'العنوان الثاني',
        'title_link'              => 'عنوان الرابط',
        'link'                    => 'رابط',
        'image_gallery'           => 'گالری صورة',
        'video_gallery'           => 'گالری فيديو',
        'new_password'            => 'كلمة مرور جديدة',
        'new_password_confirmation' => 'كلمة مرور جديدة',
        'create_date'             =>'تاریخ ثبت',
        'parent_id'               => 'الوالد',
        'second_title'            => 'العنوان الثاني',
        'seo_title'               => 'عنوان كبار المسئولين الاقتصاديين',
        'seo_keywords'            => 'الكلمات الرئيسية لكبار المسئولين الاقتصاديين',
        'seo_description'         => 'شرح تحسين محركات البحث',
        'thumbnail'               => 'برجمة',
        'confirm_id'              => 'تأكيد',
        'bg'                      => 'راية',
        '*title_fa*'              => 'عنوان',
        'link_*'                  => 'وصلة',
        'group_id*'               => 'مجموعة',
        'sender_name'             => 'اسم المرسل',
        'sender_email'            => 'البريد الإلكتروني للمرسل',
        'comment'                 => 'رأي',
        'duration'                => 'مدة',
        'start_date'              => 'تاريخ البدء',
        'expire_date'             => 'تاريخ الانتهاء',
        'end_date'                => 'تاريخ الانتهاء',
        'score*'                  => 'نتيجة',
        'response'                => 'الجواب',
        'semester'                => 'الفصل الدراسي',
        'start_time_date'         => 'تاريخ البدء والوقت',
        'end_time_date'           => 'تاريخ ووقت الانتهاء',
        'less_id'                 =>'معرف الدورة',
        'system_id'               =>'النظام',
        'sender'                  =>'مرسل',
        'receiver'                =>'المتلقي',
        'receivers'               =>'المستلمون',
        'date'                    =>'تاریخ',
        'group_code'              =>'مجموعة',
        'start_hour'              =>'وقت البدء',
        'lastname'                =>'النسبة',
        'firstname'               =>'الإسم',
        'photo'                   =>'صورة',
        'teacher_person_id'       =>'استاد',
        'resume'                  =>'السيرة الذاتية',
        'studentID'               =>'رقم الطلاب',
        'codemeli'                => 'رقم الهوية الوطنية',
    ],
];