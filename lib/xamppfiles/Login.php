<?php
require 'Connection.php';

if(!$conn){
    echo 'connection error';
}

$username = $_POST["username"];
$password = $_POST["password"];
$encrypted_pwd = md5($password);
$sql = "SELECT * FROM users WHERE username = '" .$username. "' AND password = '" .$encrypted_pwd. "'";
$result = mysqli_query($conn,$sql);
$count = mysqli_num_rows($result);


if($count == 1 ){
    echo json_encode("Success");
}else {
    echo json_encode ("Error");
}
?>
