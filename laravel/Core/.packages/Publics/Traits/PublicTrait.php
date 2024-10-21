<?php
namespace Publics\Traits;

trait PublicTrait
{

    public function grid($request,$model)
    {
        // dd(request);

        // --------- sort -------------
        $sortType = $request->sortType;
        if($sortType == ""){
            $sortType = "DESC";
        }
        $sort = $request->sort;
        if($sort == ""){
            $sort = "id";
        }

        $rs = explode('.', $sort);
        if(count($rs) > 1)
        {
            $model->joinRelations($rs[0], true);
            $items = $model->orderByJoin($sort, $sortType);
        }
        else
        {
            $items = $model->orderBy($sort, $sortType);
        }
        // --------- search -------------

        $search = $request->search;
        if($search != "")
        {
            $strSearch = explode('.', $search);
            if(count($strSearch) > 1)
            {
                $model->joinRelations($strSearch[0], true);
                $items = $model->orderByJoin($sort, $sortType);
                dd(items);
            }
            else
            {
                $items->where('name', 'like', "%$search%");
                // $items->where($request->searchIn, 'like', "%$search%");
            }

        }

        // --------- number paginate -------------
        $number = $request->number;
        if($number == ""){
            $number = 5;
        }
        // dd($items);

        // $items=$items->where('id', '>' , 0);

        $prs = $items->paginate($number);

        $sumLength = 50;
        for($i=0 ; $i<count($prs) ; $i++){
            if(strlen($prs[$i]->summary) > 100){
                $length = strpos($prs[$i]->summary," ",$sumLength);
                $prs[$i]->summary = substr($prs[$i]->summary,0,$length);
                $prs[$i]->summary = $prs[$i]->summary." ...";
            }
        }
        return $prs;
    }

    public function getData($models)
    {
        $info=[];

        foreach ($models as $value)
        {
            $className = 'Models\\' . $value;
            $modelObj =  new $className;

            $index = explode('\\',$value);
            $info[count($index)-1] = $modelObj::wherer('status')->get();
        }
        return response()->json($info);
    }

}


?>
