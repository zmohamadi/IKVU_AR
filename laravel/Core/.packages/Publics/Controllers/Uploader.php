<?php

namespace Publics\Controllers;

use App\Http\Controllers\Controller;

// use Api\Admin\Lara\Models\FileModel;
// use Api\Admin\Lara\Models\FileTypeModel;

class Uploader extends Controller
{
    private $check = true;
    private $dir = './media/upload/';
    private $message = '';
    private $input = '';
    private $quality = 100;
    private $crop = null;
    public $resize = null;
    public $thumb = null;
    public $uploadVar = null;
    /***
     * image | audio | video | doc | allfile
     */
    private $typeGroup = '';
    private $acceptedType = [];
    private $maxSize = '';
    private $controller = '';

    private $cropWidth = 700;
    private $cropHeight = 700;

    public function __construct($dir, $request)
    {
        // dd($request->resize);

        $this->dir = $dir;
        if ($request->resize) {
            $this->resize = $request->resize;
        }
        if ($request->crop) {
            $this->crop = $request->crop;
        }
        if ($request->thumb) {
            $this->thumb = $request->thumb;
        }
        if ($request->uploadVar) {
            $this->uploadVar = $request->uploadVar;
        }
    }

    public function run()
    {
        $this->getInformation();
        $this->checkMimeType();
        $this->uploadData();

        return $this->message;
    }

    public function getInformation()
    {
        $this->input = $_FILES['file'];
    }

    public function getInfo()
    {
        $info = \Security::decoder($_POST['data']);
        //$this->input = $_FILES[$_POST['name']];
        $this->input = $_FILES['file'];
        $this->acceptedType = explode(',', str_replace('.', '', trim($info->acceptedFiles)));
        $this->maxSize = ($info->maxFilesize != '') ? $info->maxFilesize : 'all';
        $this->controller = $info->controller;
        $this->typeGroup = ($info->type != 'all') ? $info->type : 'all';
        $this->dir .= $this->controller.'/';
    }

    public function checkSize()
    {
        if ($this->check) {
            if ($this->maxSize != 'all') {
                if ($this->input['size'] > ($this->maxSize * 1000000)) {
                    $this->check = false;
                    $this->message = 'error: file size error!!';
                }
            }
        }
    }

    public function checkType()
    {
        if ($this->check) {
            $type = explode('/', $this->input['type']);
            $chekType = $type[0];
            if ($chekType != $this->typeGroup && $this->typeGroup != 'all') {
                $this->check = false;
                $this->message = 'error: file type is not accepted!!';
            }
        }
    }

    public function checkMimeType()
    {
        if ($this->input['type'] != \mime_content_type($this->input['tmp_name'])) {
            $this->check = false;
            $this->message = 'error: file type is not valid!!';
        }
    }

    public function uploadData()
    {
        $info = pathinfo($this->input['name']);
        $rand = rand(100, 9999);
        $typeArray = explode('/', $this->input['type']);
        $type = $typeArray[0];
        $newname = $type.$rand.time().'.'.$info['extension'];

        if (move_uploaded_file($this->input['tmp_name'], $this->dir.$newname)) {
            $this->message = $newname;
            $explodeName = explode('.',$this->input['name']);
            $ext = end($explodeName);
            if ($ext == "xlsx" || $ext == "xls") {
                // ---
            }else{
                if ($this->crop) {
                    $this->cropImage($this->dir.$newname, $newname, $this->dir, $this->crop);
                } elseif ($this->resize) {
                    $sizes = \explode('-', $this->resize);
                    $width = $sizes[0];
                    $height = $sizes[1];
                    $this->resizeTo($this->dir.$newname, $width, $height, true);
                }
                if ($this->thumb) {
                    $arraySize = Tools::getCharArray($this->thumb);
    
                    foreach ($arraySize as $value) {
                        $this->createThumb($newname, $value);
                    }
                }
            }
        }
    }

    public function upload()
    {
        if ($this->check) {
            $info = pathinfo($this->input['name']);
            $newname = $info['filename'].time().'.'.$info['extension'];
            $type = explode('/', $this->input['type']);
            $uploadtype = $type[0];
            switch ($uploadtype) {
          case 'image':
            $this->uploading('image', $newname);
            break;
          case 'audio':
            $this->uploading('audio', $newname);
            break;
          case 'video':
            $this->uploading('video', $newname);
            break;
          default:
            $this->uploading('all', $newname);
            break;
        }
        }
    }

    public function cropImage($filename, $newName, $newNamePath, $size = '')
    {
        $file = $this->createImageFrom($filename);

        $width = imagesx($file);
        $height = imagesy($file);

        if ($size != '') {
            $sizes = \explode('-', $size);
            $this->cropWidth = $sizes[0];
            $this->cropHeight = $sizes[1];
        }

        $wr = $width / $this->cropWidth;
        $hr = $height / $this->cropHeight;
        $baseRatio = min($wr, $hr);

        if ($baseRatio == $wr) {
            $ratio = $this->cropWidth / $width;
            $width = $this->cropWidth;
            $height = ceil($height * $ratio);
        } elseif ($baseRatio == $hr) {
            $ratio = $this->cropHeight / $height;
            $height = $this->cropHeight;
            $width = ceil($width * $ratio);
        }

        $this->resizeTo($filename, $width, $height);
        $file = $this->createImageFrom($filename);

        $centreX = round($width / 2);
        $centreY = round($height / 2);

        $cropWidthHalf = round($this->cropWidth / 2);
        $cropHeightHalf = round($this->cropHeight / 2);

        $x1 = max(0, $centreX - $cropWidthHalf);
        $y1 = max(0, $centreY - $cropHeightHalf);

        $temp = $this->createTrueColorBoom($this->cropWidth, $this->cropHeight);

        imagecopy($temp, $file, 0, 0, $x1, $y1, $width, $height);

        if (!file_exists($newNamePath)) {
            mkdir($newNamePath, 0777, true);
        }

        $this->imageFromTo($temp, $newNamePath.$newName);

        imagedestroy($temp);
    }

    public function resizeTo($fileAddress, $width, $height, $keepAspectRatio = false)
    {
        $source = $this->createImageFrom($fileAddress);

        $mainWidth = imagesx($source);
        $mainHeight = imagesy($source);

        if ($keepAspectRatio) {
            list($width, $height) = $this->getDimensionkeepAspectRatio($width, $height, $mainWidth, $mainHeight);
        }

        $thumb_create = $this->createTrueColorBoom($width, $height);
        // imagecopyresized($thumb_create, $source, 0, 0, 0, 0, $width, $height, $mainWidth, $mainHeight);
        imagecopyresampled($thumb_create, $source, 0, 0, 0, 0, $width, $height, $mainWidth, $mainHeight);
        $this->imageFromTo($thumb_create, $fileAddress);
    }

    public function createThumb($newname, $folder)
    {
        $url = $this->dir.$folder.'/';

        if (!file_exists($url)) {
            mkdir($url, 0777, true);
        }

        $dimension = getimagesize($this->dir.$newname);

        switch ($folder) {
            case 'm':
                $width = \Config::get('admin.'.$this->uploadVar.'.m_width');
                $height = \Config::get('admin.'.$this->uploadVar.'.m_height');

                break;
            case 't':
                $width = \Config::get('admin.'.$this->uploadVar.'.t_width');
                $height = \Config::get('admin.'.$this->uploadVar.'.t_height');

                break;
        }

        list($width, $height) = $this->getDimensionkeepAspectRatio($width, $height, $dimension[0], $dimension[1]);
        $thumb_create = $this->createTrueColorBoom($width, $height);
        $source = $this->createImageFrom($this->dir.$newname);

        // imagecopyresized($thumb_create, $source, 0, 0, 0, 0, $width, $height, $dimension[0], $dimension[1]);
        imagecopyresampled($thumb_create, $source, 0, 0, 0, 0, $width, $height, $dimension[0], $dimension[1]);
        $this->imageFromTo($thumb_create, $url.$newname);

        return $newname;
    }

    public function remove()
    {
        $fname = $_POST['name'];
        if ($_POST['typegroup'] == 'all') {
            if (is_numeric($_POST['type'])) {
                $file = FileTypeModel::find($_POST['type']);
                $typegroup = $file->title;
            } else {
                $typegroup = $_POST['type'];
            }
        } else {
            $typegroup = $_POST['typegroup'];
        }

        $filename = $this->dir.$_POST['controller'].'/'.$typegroup.'/'.$_POST['name'];
        if (file_exists($filename)) {
            unlink($filename);
        }
        if ($typegroup == 'image') {
            $medium = $this->dir.$_POST['controller'].'/'.$typegroup.'/medium/'.$_POST['name'];
            if (file_exists($medium)) {
                unlink($medium);
            }
        }

        echo 'delete';
    }

    public function createImageFrom($filepath)
    {
        $type = exif_imagetype($filepath);
        $allowedTypes = array(
          1,  // [] gif
          2,  // [] jpg
          3,  // [] png
          6,   // [] bmp
      );
        if (!in_array($type, $allowedTypes)) {
            return false;
        }

        switch ($type) {
          case 1:
            $im = imagecreatefromgif($filepath);
            break;
          case 2:
            $im = imagecreatefromjpeg($filepath);
            break;
          case 3:
            $im = imagecreatefrompng($filepath);
            break;
          case 6:
            $im = imagecreatefrombmp($filepath);
            break;
      }

        return $im;
    }

    public function imageFromTo($source, $destination)
    {
        $ext = pathinfo($destination, PATHINFO_EXTENSION);
        switch ($ext) {
            case 'gif':
                imagegif($source, $destination);
                break;
            case 'jpg':
            case 'jpeg':
            case 'JPEG':
                // imagejpeg($source, $destination, $this->quality);
                imagepng($source, $destination, -1, PNG_ALL_FILTERS);
                break;
            case 'png':
                imagepng($source, $destination, -1, PNG_ALL_FILTERS);
                break;
            case 'bmp':
                imagebmp($source, $destination);
                break;
            default:
                imagejpeg($source, $destination, $this->quality);
                break;
        }
    }

    public function createTrueColorBoom($width, $height)
    {
        $colorBoom = imagecreatetruecolor($width, $height);
        imagealphablending($colorBoom, true);
        imagesavealpha($colorBoom, true);

        $bgcolor = imagecolorallocatealpha($colorBoom, 0, 0, 0, 127);
        imagefill($colorBoom, 0, 0, $bgcolor);

        return $colorBoom;
    }

    public function getDimensionkeepAspectRatio($width, $height, $mainWidth, $mainHeight)
    {
        $wR = $width / $mainWidth;
        $hR = $height / $mainHeight;
        $mainR = min($wR, $hR);
        $width = $mainWidth * $mainR;
        $height = $mainHeight * $mainR;

        return [$width, $height];
    }
}
