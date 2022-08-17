<?php
function send($title,$message,$token,$p_id,$p_name)
{
$url='https://fcm.googleapis.com/fcm/send';

$fields=array(
'registration'=>array(
$token
),
'priority'=>'high',
'content_available'=>true,

'notification'=>array(
"body"=>$message,
"title"=>$title,
"click_action"=>"FLUTTER_NOTIFICATION_CLICK",
"sound"=>"default"
),
'data'=>array(
"page_id"=>$p_id,
"page_name"=>$p_name
),
);
$fields=json_encode($fields);
$headers=array(
'Authorization: key='."BBWzaVozHo9Yj-HvfyQo2tOTEKR198CBX9csB_QJziPsNesJGYIb7U_eMi96HZZy4IUlEyLb5eH3HZjmwQ9XXZc".,
'Content_Type:application/json',
);
$ch=curl_init();
curl_setopt($ch,CURLOPT,$url);
curl_setopt($ch,CURLOPT_POST,true);
curl_setopt($ch,CURLOPT_HTTPHEADER,$headers);
curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
curl_setopt($ch,CURLOPT_POSTFIELDS,$fields);
$result=curl_exec($ch);
return $result;
curl_close($ch);
}
?>