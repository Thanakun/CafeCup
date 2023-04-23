<?php
require "Connection.php";
if(!$conn){
    echo "connection error";

}

$username = $_POST["username"];
$password = $_POST["password"];
$encrypted_pwd = md5($password);
$email = $_POST["email"];
$gender = $_POST["gender"];
$age = $_POST["age"];
$user_point = $_POST["user_point"];
$user_role = $_POST["user_role"];

$sql = "SELECT * FROM users WHERE email = '$email'";


$result = mysqli_query($conn,$sql);
$count = mysqli_num_rows($result);

if($count == 1){
    echo json_encode('Errror');

}else{
    $insert = "INSERT INTO $table (username,password,email,gender,age,user_point,user_role) 
    VALUES ('$username','$encrypted_pwd','$email','$gender','$age','$user_point','$user_role')";}
    $query = mysqli_query($conn,$insert);
    if($query){
        echo json_encode('Succeed');
    }
?>
