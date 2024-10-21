<?php
namespace Publics\Traits;

use Models\Base\Type;

trait FileTrait
{

    public function getFileInfo($file, $dir)
    {

        // $path = base_path().'/../public_html/media/documents/images/';
        if(substr($dir, -1) != "/") $dir = $dir."/";

        $files_info = array();

        // dd($dir);
        $files = explode('###', $file);

        // dd($files);

        $types = Type::get();

        // dd($types);

        for($i=0; $i<count($files)-1; $i++){

            $strArray = explode('/',$files[$i]);
            // dd($strArray);


            $path_parts = pathinfo($dir.last($strArray));

            // dd($path_parts);



            $info['extension'] = $path_parts['extension'];
            $info['name'] = $path_parts['filename'];

            $filesize = filesize($dir.last($strArray)); // bytes
            $info['size'] = round($filesize / 1024)." KB";

            foreach($types as $type){
                $description = $type->description;
                $arrays = explode(",",$description);
                // dd($arrays);
                foreach($arrays as $arr){
                    if($arr == $info['extension']){
                        $info['file_type_id'] = $type->id;
                        break;
                    }
                }
            }

            if($info['file_type_id'] == "1"){
                $data = getimagesize($dir.last($strArray));
                $info['width'] = $data[0];
                $info['height'] = $data[1];
            }else{
                $info['width'] = "";
                $info['height'] = "";
            }

            $files_info[] = $info;
        }

        return $files_info;
    }

    public function justFileNameGallery($fileName)
    {

        $mainStrArray = [];
        $word = [];


        $mainStrArray = explode('###', $fileName);
        // dd($mainStrArray);
            foreach($mainStrArray as $item)
            {
                dd($item);
                if($item!=""&&is_string($item)){
                    // dd($item);
                    $str = explode('/', $item);
                    $word[] = $str[count($str)-1];
                }

            }

        return $word;
    }

    public function justFileName($fileName)
    {
        $word = '';

        if(is_string($fileName)){
            $str = explode('/', $fileName);
            $word = $str[count($str)-1];
        }
        else if(is_array($fileName)){

        }

        return $word;
    }

}


?>
