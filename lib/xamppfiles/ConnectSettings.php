<?php


    require "Connection.php";


    //if Connection is OKay

    if("CREATE_TABLE" == $action){
        $sql = "CREATE TABLE IF NOT EXISTS $table ( 
        id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY 
        username VARCHAR(50) NOT NULL
        _password VARCHAR(50) NOT NULL
        email VARCHAR(254) NOT NULL
        gender VARCHAR(20) NOT NULL
        age int(2) NOT NULL
        user_point int NOT NULL
        user_role VARCHAR(30) NOT NULL 
        )";

        if($conn -> query($sql) === TRUE){
            echo "success";
        } else {
            echo "error query ";
        }
        $conn -> close();
        return;
    }
    

    if("GET_ALL" == $action){
        $db_data = array();
        $sql = "SELECT id,username,_password,email,gender,age,user_point,user_role  from $table ORDER BY id DESC";
        $result = $conn -> query($sql);
        if($result->num_rows > 0){
            while ($row = $result -> fetch_assoc()){
                $db_data[] = $row;
            }
            echo json_encode ($db_data);
        }
        $conn->close();
        return;
    }

    if("ADD_USER" == $action){
        $username = $_POST["username"];
        $_password = $_POST["_password"];
        $email = $_POST["email"];
        $gender = $_POST["gender"];
        $age = $_POST["age"];
        $user_point = $_POST["user_point"];
        $user_role = $_POST["user_role"];
        $sql = "INSERT INTO $table (username,_password,email,gender,age,user_point,user_role) 
                VALUES ('$username','$_password','$email','$gender','$age','$user_point','$user_role')";
        
        $result = $conn-> query($sql);
        echo 'success';
     
        $conn->close();
        return;

    }

    if("UPDATE_USER" == $action){
        $user_id = $_POST['user_id'];
        $username = $_POST["username"];
        $gender = $_POST["gender"];
        $age = $_POST["age"];
        $sql = "UPDATE $table SET username,gender,age WHERE id = $user_id)";

        if($conn ->query ($sql) === TRUE ){
            echo 'success';
        }else{
            echo 'error';
        };
        // echo 'success';

        $conn -> close(); 
        return; 

    }

    if("DELETE_USER" == $action){
        $user_id = $_POST['user_id'];
        $sql = "DELETE FROM $table WHERE id = $user_id"; 
        
        if($conn ->query ($sql) === TRUE ){
            echo 'success';
        }else{
            echo 'error';
        };
        // echo 'success';

        $conn -> close(); 
        return; 
    }

?> 