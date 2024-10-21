<?php

namespace SAdmin\Controllers\PublicCLR;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class Breadcrumb extends Controller
{
    private $models = [
     // Base *****************************************************************************************************
        'city' => [\Models\Base\City::class, 'name_'],
        'province' => [\Models\Base\Province::class, 'name_'],
        'country' => [\Models\Base\Country::class, 'name_'],
        'socialType' => [\Models\Base\SocialType::class, 'name_'],
        'keyword' => [\Models\Base\Keyword::class, 'title'],
        'language' => [\Models\Base\Language::class, 'title'],
        'status' => [\Models\Base\Status::class, 'title_'],
        'month' => [\Models\Base\Month::class, 'title_'],
        'facilitySubject' => [\Models\Project\FacilitySubject::class, 'title_'],
        'facility' => [\Models\Project\Facility::class, 'title_'],
    // Person ***************************************************************************************************
        'personnelUser' => [\Models\Person\User::class, 'lname'],
        'customer' => [\Models\Person\Customer::class, 'lname'],
        'address' => [\Models\Person\Address::class, 'address'],
        'level' => [\Models\Person\Level::class, 'name'],
        'role' => [\Models\ACL\Role::class, 'name'],
    // Kala ****************************************************************************************************
        'product' => [\Models\Kala\Product::class, 'name'],
        'category' => [\Models\Kala\Category::class, 'title_'],
        'usage' => [\Models\Kala\Usage::class, 'title_'],
        'feature' => [\Models\Kala\Feature::class, 'title_'],
        'featureType' => [\Models\Kala\featureType::class, 'title_'],
        'value' => [\Models\Kala\Value::class, 'title_'],
        'brand' => [\Models\Kala\Brand::class, 'name_'],
        'shop' => [\Models\Kala\Shop::class, 'name_'],
        'productModel' => [\Models\Kala\ProductModel::class, 'title_'],
        'color' => [\Models\Kala\Color::class, 'name_'],
        // 'productComment' => [\Models\Kala\ProductComment::class, 'sender_name'],
    // Content ***************************************************************************************************
        'blog' => [\Models\Content\Blog::class, 'title'],
        'blogSubject' => [\Models\Content\BlogSubject::class, 'title_'],
        'siteText' => [\Models\Content\SiteText::class, 'title_'],
        'slider' => [\Models\Content\Slider::class, 'title'],
        'contact' => [\Models\Content\ContactUs::class, 'sender_name'],
        'blogComment' => [\Models\Content\BlogComment::class, 'sender_name'],
    // Financial ***************************************************************************************************
    ];

    public function getInfo(Request $request)
    {
        $params = $request->except('lang');
        $lang = $request->lang;
        $info = [];
        foreach ($params as $key => $item) {
            $attr = $this->models[$key][1];
            if (substr($attr, -1, 1) == '_') {
                $attr .= $lang;
            }

            $obj = $this->models[$key][0]::
                        select($attr)
                        ->find($item);

            $info[$key.'Title'] = $obj->$attr;
        }

        return $info;
    }
}
