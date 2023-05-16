<?php
    $server_name = "localhost";
    $server_username = "root";
    $server_password = "";
    $db_name = "foodappdb";
    $table = "users";
    
    // $action = $_POST["action"];

    $conn = mysqli_connect($server_name,$server_username,$server_password,$db_name);

    if($conn -> connect_error){
        die("Connection Failed : " . $conn->connect_error);
    }