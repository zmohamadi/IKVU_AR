<?php
namespace Publics\Controllers;

use App\Http\Controllers\Controller;

class TinyMCE extends Controller{
    private $accepted_origins = [
        "http://localhost",
        "http://127.0.0.1",
        "http://raika.sanegar.ir",
        "http://www.raika.sanegar.ir",
    ];
    private $imageFolder = "./media/tiny/";
    private $imageExtension = ["gif", "jpg", "png"];

    public function uploadImage($dir){
        /***************************************************
         * Only these origins are allowed to upload images *
         ***************************************************/
        $accepted_origins = $this->accepted_origins;
        $imageFolder = $this->imageFolder;
        if($dir != ""){
            $dir = \str_replace('-', '/', $dir);
            $imageFolder = $dir;
        }
        $origin = $_SERVER['HTTP_ORIGIN'];
        $str = explode(':', $origin);
        if(isset($str[2]))
            $origin = str_replace(":".$str[2], '', $origin);

        if (isset($_SERVER['HTTP_ORIGIN'])) {
            // same-origin requests won't set an origin. If the origin is set, it must be valid.
            if (in_array($origin, $accepted_origins)) {
                header('Access-Control-Allow-Origin: ' . $_SERVER['HTTP_ORIGIN']);
            } else {
                header("HTTP/1.1 403 Origin Denied");
                return;
            }
        }
        // Don't attempt to process the upload on an OPTIONS request
        if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
            header("Access-Control-Allow-Methods: POST, OPTIONS");
            return;
        }

        reset ($_FILES);
        $temp = current($_FILES);

        if (is_uploaded_file($temp['tmp_name'])){

            if (preg_match("/([^\w\s\d\-_~,;:\[\]\(\).])|([\.]{2,})/", $temp['name'])) {
                header("HTTP/1.1 400 Invalid file name.");
                return;
            }

            // Verify extension
            if (!in_array(strtolower(pathinfo($temp['name'], PATHINFO_EXTENSION)), $this->imageExtension)) {
                header("HTTP/1.1 400 Invalid extension.");
                return;
            }

            // Accept upload if there was no origin, or if it is an accepted origin
            $name = $this->newName($temp['name']);
            $filetowrite = str_replace('./', '', $imageFolder) . $name;
            move_uploaded_file($temp['tmp_name'], $filetowrite);

            // Determine the base URL
            $protocol = isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] == 'on' ? "https://" : "http://";
            // $baseurl = $protocol . $_SERVER["HTTP_HOST"] . rtrim(dirname($_SERVER['REQUEST_URI']), "/") . "/";
            // $baseurl = $protocol . $_SERVER["HTTP_HOST"] . "/";
            $baseurl = "";

            return json_encode(array('location' => $baseurl . $filetowrite));
        } else {
            header("HTTP/1.1 500 Server Error");
        }
    }

    public function newName($name){
        $name = str_replace(" ", "_", $name);
        $ext  = pathinfo($name, PATHINFO_EXTENSION);
        $rand = rand(100, 999);
        $fileName  = pathinfo($name, PATHINFO_FILENAME);
        $newname   = $fileName.$rand.time().'.'.$ext;

        return $newname;
    }
}
