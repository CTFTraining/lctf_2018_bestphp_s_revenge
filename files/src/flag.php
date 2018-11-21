<?php
session_start();
echo 'only localhost can get flag!';
$flag = 'LCTF{lctf_2018_bestphp_s_revenge}';
if ($_SERVER["REMOTE_ADDR"] === "127.0.0.1") {
	$_SESSION['flag'] = $flag;
}
?>
session_start();
echo 'only localhost can get flag!';
$flag = 'LCTF{*************************}';
if($_SERVER["REMOTE_ADDR"]==="127.0.0.1"){
       $_SESSION['flag'] = $flag;
   }
only localhost can get flag!