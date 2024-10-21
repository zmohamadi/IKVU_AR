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

    'accepted'             => ':attribute باید پذیرفته شده باشد.',
    'active_url'           => 'آدرس :attribute معتبر نیست.',
    'after'                => ':attribute باید تاریخی بعد از :date باشد.',
    'after_or_equal'       => ':attribute باید تاریخی بعد از :date، یا مطابق با آن باشد.',
    'alpha'                => ':attribute باید فقط حروف الفبا باشد.',
    'alpha_dash'           => ':attribute باید فقط حروف الفبا، اعداد، خط تیره و زیرخط باشد.',
    'alpha_num'            => ':attribute باید فقط حروف الفبا و اعداد باشد.',
    'array'                => ':attribute باید آرایه باشد.',
    'before'               => ':attribute باید تاریخی قبل از :date باشد.',
    'before_or_equal'      => ':attribute باید تاریخی قبل از :date، یا مطابق با آن باشد.',
    'between'              => [
        'numeric' => ':attribute باید بین :min و :max باشد.',
        'file'    => ':attribute باید بین :min و :max کیلوبایت باشد.',
        'string'  => ':attribute باید بین :min و :max کاراکتر باشد.',
        'array'   => ':attribute باید بین :min و :max آیتم باشد.',
    ],
    'boolean'              => 'فیلد :attribute فقط می‌تواند true و یا false باشد.',
    'confirmed'            => ':attribute با فیلد تکرار مطابقت ندارد.',
    'date'                 => ':attribute یک تاریخ معتبر نیست.',
    'date_equals'          => ':attribute باید یک تاریخ برابر با تاریخ :date باشد.',
    'date_format'          => ':attribute با الگوی :format مطابقت ندارد.',
    'different'            => ':attribute و :other باید از یکدیگر متفاوت باشند.',
    'digits'               => ':attribute باید :digits رقم باشد.',
    'digits_between'       => ':attribute باید بین :min و :max رقم باشد.',
    'dimensions'           => 'ابعاد تصویر :attribute قابل قبول نیست.',
    'distinct'             => 'فیلد :attribute مقدار تکراری دارد.',
    'email'                => ':attribute باید یک ایمیل معتبر باشد.',
    'ends_with'            => 'فیلد :attribute باید با یکی از مقادیر زیر خاتمه یابد: :values',
    'exists'               => ':attribute انتخاب شده، معتبر نیست.',
    'file'                 => ':attribute باید یک فایل معتبر باشد.',
    'filled'               => 'فیلد :attribute باید مقدار داشته باشد.',
    'gt'                   => [
        'numeric' => ':attribute باید بزرگتر از :value باشد.',
        'file'    => ':attribute باید بزرگتر از :value کیلوبایت باشد.',
        'string'  => ':attribute باید بیشتر از :value کاراکتر داشته باشد.',
        'array'   => ':attribute باید بیشتر از :value آیتم داشته باشد.',
    ],
    'gte'                  => [
        'numeric' => ':attribute باید بزرگتر یا مساوی :value باشد.',
        'file'    => ':attribute باید بزرگتر یا مساوی :value کیلوبایت باشد.',
        'string'  => ':attribute باید بیشتر یا مساوی :value کاراکتر داشته باشد.',
        'array'   => ':attribute باید بیشتر یا مساوی :value آیتم داشته باشد.',
    ],
    'image'                => ':attribute باید یک تصویر معتبر باشد.',
    'in'                   => ':attribute انتخاب شده، معتبر نیست.',
    'in_array'             => 'فیلد :attribute در لیست :other وجود ندارد.',
    'integer'              => ':attribute باید عدد صحیح باشد.',
    'ip'                   => ':attribute باید آدرس IP معتبر باشد.',
    'ipv4'                 => ':attribute باید یک آدرس معتبر از نوع IPv4 باشد.',
    'ipv6'                 => ':attribute باید یک آدرس معتبر از نوع IPv6 باشد.',
    'json'                 => 'فیلد :attribute باید یک رشته از نوع JSON باشد.',
    'lt'                   => [
        'numeric' => ':attribute باید کوچکتر از :value باشد.',
        'file'    => ':attribute باید کوچکتر از :value کیلوبایت باشد.',
        'string'  => ':attribute باید کمتر از :value کاراکتر داشته باشد.',
        'array'   => ':attribute باید کمتر از :value آیتم داشته باشد.',
    ],
    'lte'                  => [
        'numeric' => ':attribute باید کوچکتر یا مساوی :value باشد.',
        'file'    => ':attribute باید کوچکتر یا مساوی :value کیلوبایت باشد.',
        'string'  => ':attribute باید کمتر یا مساوی :value کاراکتر داشته باشد.',
        'array'   => ':attribute باید کمتر یا مساوی :value آیتم داشته باشد.',
    ],
    'max'                  => [
        'numeric' => ':attribute نباید بزرگتر از :max باشد.',
        'file'    => ':attribute نباید بزرگتر از :max کیلوبایت باشد.',
        'string'  => ':attribute نباید بیشتر از :max کاراکتر داشته باشد.',
        'array'   => ':attribute نباید بیشتر از :max آیتم داشته باشد.',
    ],
    'mimes'                => 'فرمت‌های معتبر فایل عبارتند از: :values.',
    'mimetypes'            => 'فرمت‌های معتبر فایل عبارتند از: :values.',
    'min'                  => [
        'numeric' => ':attribute نباید کوچکتر از :min باشد.',
        'file'    => ':attribute نباید کوچکتر از :min کیلوبایت باشد.',
        'string'  => ':attribute نباید کمتر از :min کاراکتر داشته باشد.',
        'array'   => ':attribute نباید کمتر از :min آیتم داشته باشد.',
    ],
    'multiple_of'          => 'The :attribute must be a multiple of :value',
    'not_in'               => ':attribute انتخاب شده، معتبر نیست.',
    'not_regex'            => 'فرمت :attribute معتبر نیست.',
    'numeric'              => ':attribute باید عدد یا رشته‌ای از اعداد باشد.',
    'password'             => 'رمزعبور اشتباه است.',
    'current_password'     => 'رمزعبور اشتباه است.',
    'present'              => 'فیلد :attribute باید در پارامترهای ارسالی وجود داشته باشد.',
    'regex'                => 'فرمت :attribute معتبر نیست.',
    'required'             => 'فیلد :attribute الزامی است.',
    'required_if'          => 'هنگامی که :other برابر با :value است، فیلد :attribute الزامی است.',
    'required_unless'      => 'فیلد :attribute الزامی است، مگر آنکه :other در :values موجود باشد.',
    'required_with'        => 'در صورت وجود فیلد :values، فیلد :attribute نیز الزامی است.',
    'required_with_all'    => 'در صورت وجود فیلدهای :values، فیلد :attribute نیز الزامی است.',
    'required_without'     => 'در صورت عدم وجود فیلد :values، فیلد :attribute الزامی است.',
    'required_without_all' => 'در صورت عدم وجود هر یک از فیلدهای :values، فیلد :attribute الزامی است.',
    'same'                 => ':attribute و :other باید همانند هم باشند.',
    'size'                 => [
        'numeric' => ':attribute باید برابر با :size باشد.',
        'file'    => ':attribute باید برابر با :size کیلوبایت باشد.',
        'string'  => ':attribute باید برابر با :size کاراکتر باشد.',
        'array'   => ':attribute باید شامل :size آیتم باشد.',
    ],
    'starts_with'          => ':attribute باید با یکی از این ها شروع شود: :values',
    'string'               => 'فیلد :attribute باید متن باشد.',
    'timezone'             => 'فیلد :attribute باید یک منطقه زمانی معتبر باشد.',
    'unique'               => ':attribute قبلا انتخاب شده است.',
    'uploaded'             => 'بارگذاری فایل :attribute موفقیت آمیز نبود.',
    'url'                  => ':attribute معتبر نمی‌باشد.',
    'uuid'                 => ':attribute باید یک UUID معتبر باشد.',

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
            'required' => 'عنوان الزامیست',
        ],
        'title_ar' => [
            'required' => 'العنوان اجباری',
        ],
        'title_en' => [
            'required' => 'title required',
        ],
        'name_fa' => [
            'required' => 'نام الزامیست',
        ],
        'name_ar' => [
            'required' => 'الاسم اجباری',
        ],
        'name_en' => [
            'required' => 'name required',
        ],
        'lname_fa' => [
            'required' => 'نام خانوادگی الزامیست',
        ],
        'lname_ar' => [
            'required' => 'الكنية اجباری',
        ],
        'lname_en' => [
            'required' => 'last name required',
        ],
        'nationality_fa' => [
            'required' => 'ملیت الزامیست',
        ],
        'nationality_ar' => [
            'required' => 'الملیت اجباری',
        ],
        'nationality_en' => [
            'required' => 'nationality required',
        ],
        'text_fa' => [
            'required' => 'متن الزامیست',
        ],
        'text_ar' => [
            'required' => 'نص اجباری',
        ],
        'text_en' => [
            'required' => 'text required',
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
        'name'                    => 'نام',
        'lname'                   => 'نام خانوادگی',
        'username'                => 'نام کاربری',
        'password'                => 'رمز عبور',
        'password_repeat'         => 'تکرار رمز عبور',
        'order*'                   => 'ترتیب',
        'title'                   => 'عنوان',
        'label'                   => 'لیبل',
        'day'                     => 'روز',
        'month'                   => 'ماه',
        'year'                    => 'سال',
        'hour'                    => 'ساعت',
        'minute'                  => 'دقیقه',
        'second'                  => 'ثانیه',
        'identi_code'             => 'کد ملی',
        'gender_id'               => 'جنسیت',
        'mobile'                  => 'شماره همراه',
        'tel'                     => 'شماره ثابت',
        'phone'                   => 'شماره تماس',
        'address'                 => 'آدرس',
        'email'                   => 'ایمیل',
        'about'                   => 'درباره کاربر',
        'gender'                  => 'جنسیت',
        'role_id'                 => 'نقش',
        'role'                    => 'نقش',
        'pic'                     => 'تصویر',
        'image'                   => 'تصویر',
        'logo'                    => 'لوگو',
        'icon'                    => 'آیکون',
        'text'                    => 'متن',
        'description'             => 'توضیحات',
        'summary'                 => 'خلاصه',
        'dir'                     => 'چینش',
        'symbol'                  => 'عنوان اختصاری',
        'num'                     => 'شمارنده ماه',
        'group_id'                => 'گروه',
        'code'                    => 'کد',
        'view'                    => 'بازدید',
        'subject_id'              => 'موضوع',
        'parent_subject_id'       => 'موضوع اصلی',
        'category_id'             => 'دسته بندی',
        'parent_category_id'      => 'دسته بندی اصلی',
        'video'                   => 'ویدئو',
        'full_name'               => 'نام و نام خانوادگی',
        'latin_name'              => 'نام لاتین',
        'reply'                   => 'پاسخ',
        'title2'                  => 'دومین عنوان',
        'title_link'              => 'عنوان لینک',
        'link'                    => 'لینک',
        'image_gallery'           => 'تصاویر',
        'video_gallery'           => 'ویدئو',
        'new_password'            => 'رمز عبور جدید',
        'new_password_confirmation' => 'تأیید رمز عبور',
        'create_date'             =>'تاریخ ثبت',
        'parent_id'               => 'اصلی',
        'second_title'            => 'عنوان دوم',
        'seo_title'               => 'عنوان سئو',
        'seo_keywords'            => 'کلمات کلیدی سئو',
        'seo_description'         => 'توضیح سئو',
        'thumbnail'               => 'بند انگشتی',
        'confirm_id'              => 'تأییدیه',
        'bg'                      => 'بنر',
        '*title_fa*'            => 'عنوان',
        'link_*'                  => 'لینک',
        'group_id*'              => 'گروه',
        'sender_name'             => 'نام فرستنده',
        'sender_email'            => 'ایمیل فرستنده',
        'comment'                 => 'نظر',
        'duration'                => 'مدت زمان',
        'start_date'              => 'تاریخ شروع',
        'expire_date'              => 'تاریخ پایان',
        'end_date'              => 'تاریخ پایان',
        'score*'              => 'نمره',
        'response'              => 'پاسخ',
        'semester'              => 'ترم',
        'start_time_date'              => 'تاریخ و ساعت شروع',
        'end_time_date'              => 'تاریخ و ساعت پایان',
        'less_id'=>'شناسه درس',
        'system_id'=>'سامانه',
        'sender'=>'فرستنده',
        'receiver'=>'گیرنده',
        'receivers'=>'گیرندگان',
        'date'=>'تاریخ',
        'group_code'=>'گروه',
        'start_hour'=>'زمان شروع',
        'lastname'=>'نام خانوادگی',
        'firstname'=>'نام',
        'photo'=>'تصویر',
        'teacher_person_id'=>'استاد',
        'resume'=>'رزومه',
        'studentID'=>'کد دانشجویی',
        'codemeli' => 'کد ملی',
        'username' => 'نام کاربری',
    ],
];
