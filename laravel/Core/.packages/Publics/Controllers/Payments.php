<?php

namespace Publics\Controllers;

use App\Http\Controllers\Controller;
use Symfony\Component\HttpFoundation\Request;
use Shetabit\Multipay\Invoice;
use Shetabit\Payment\Facade\Payment;
use Shetabit\Multipay\Exceptions\InvalidPaymentException;
use Models\Payment\Payment as PaymentModel;
use \Auth;
use \App;

class Payments extends Controller
{
    public function payment($price, $type_id, $record_id, $user_id="")
    {
        $invoice = new Invoice;
        $invoice->amount(intval($price));
        $invoice->detail(['mobile' => env('mobile'),'email' => env('email')]);
        try{
            return Payment::purchase($invoice, function($driver, $transactionId) use($price, $type_id, $record_id, $user_id) {
                $info = [
                        "record_id" => $record_id,
                        "transactionId" => $transactionId,
                        "amount" => $price,
                        "user_id" => $user_id,
                        "type_id" => $type_id,
                        "status_id" => 0,
                        "message" => "عملیات پرداخت ناموفق.",
                    ];
                PaymentModel::create($info);
            })->pay()->render();
            // dd($p);
            // return $p;
        }
        catch(Exception $e)
        {
            dd('catch');
            echo $e->getMessage();
        }
    }

    public function end()
    {
        $transaction_id = $_REQUEST['Authority'];
        $payment = PaymentModel::where('transactionId', $transaction_id)->first();
        try {
            $receipt = Payment::amount(intval($payment->amount))->transactionId($transaction_id)->verify();

            $payment->status_id = 1;
            $payment->referenceId = $receipt->getReferenceId();
            $payment->message = "عملیات پرداخت با موفقیت انجام شد.";
            $payment->save();
            if($payment->type_id==1)
            {
                $editTransaction = new \Profile\Controllers\Wallet\IRRWalletController;
                $editTransaction->irrDepositInsert($payment->record_id);
                $link="/profile";
            }
            if($payment->type_id==2)
            {
                $newCourse = new \Site\Controllers\CourseController;
                $newCourse->registerUserInCourse($payment->record_id);
                $link = "/".App::getLocale();
            }
            return(view("views::payment.success")->with(compact("link")));
        } catch (InvalidPaymentException $exception) {
            # source: https://next.zarinpal.com/paymentGateway/error.html
            if($exception->getCode() != 101) // به جز تکرار پرداخت
            {
                $payment->status_id = 2;
                $payment->message = $exception->getMessage();
                $payment->save();
            }
            $message = $exception->getMessage();
            return(view("views::payment.failed", compact('message')));
        }
    }

}
