<?php

namespace Admin\Controllers\Public;

use Publics\Controllers\Uploader;
use Publics\Controllers\TinyMCE;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class Upload extends Controller
{
    public function uploadFile(Request $request, $dir = './media')
    {
        $dir = str_replace('-', '/', $dir);

        if (substr($dir, -1, 1) != '/') {
            $dir .= '/';
        }

        $uploader = new Uploader($dir, $request);
        $message = $uploader->run();

        return $message;
    }
    
    public function ckUpload(Request $request, $dir = './media')
    {
        $message = $this->uploadFile($request, $dir);
        $dir = str_replace('-', '/', $dir);
        if (substr($dir, -1, 1) != '/') {
            $dir .= '/';
        }

        if (substr($dir, 0, 2) == './') {
            $dir = substr($dir, 1);
        }

        $data = [
                'uploaded' => 1, 
                'fileName' => $message, 
                'url' => env('APP_URL', 'http://127.0.0.1:8000').$dir.$message,
                'fileUrl' => env('APP_URL', 'http://127.0.0.1:8000').$dir.$message,
            ];

        return response()->json($data);
    }

    public function tinyUpload(Request $request, $dir = './media'){
        // dd($dir);
        $dir = str_replace('-', '/', $dir);

        if (substr($dir, -1, 1) != '/') {
            $dir .= '/';
        }

        $tiny = new TinyMCE();
        return $tiny->uploadImage($dir);
    }

    public function deleteFile($dir, $file)
    {
        $dir = str_replace('-', '/', $dir);
        if (substr($dir, -1, 1) != '/')
        {
            $dir .= '/';
        }

        if (File_exists($dir.'m/'.$file))
        {
            unlink($dir.'m/'.$file);
        }
        if (File_exists($dir.'t/'.$file))
        {
            unlink($dir.'t/'.$file);
        }
        unlink($dir.$file);

        return 'deleted';
    }
}
