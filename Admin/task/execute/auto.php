<?php
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_URL, "https://paybhoomi.in/admin/task/execute/auto-withdraw.aspx?id=generate");
    curl_setopt($curl,CURLOPT_USERAGENT,"useragentvalue");
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
    curl_exec($curl);
    curl_close($curl);
?>