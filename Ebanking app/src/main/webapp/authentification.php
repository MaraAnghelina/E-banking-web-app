<?php 
			    	$host = "localhost";
			    	$user = "root";
			    	$password = 'Trompisor*2002*';
			    	$db = 'ebanking';
			    	
			    	$con = mysqli_connect($host, $user, $password, $db);
			    	if(!$con){
						die("Failed to connect with MySQL: ".mysqli_connect_errno());
					}
					echo 'Connected';
					
					$username = $_POST['username'];
					$password = $_POST['password'];
					
					$username = stripclashes($username);
					$password = stripclashes($password);
					$username = mysqli_real_escape_string($con, $username);
					$password = mysqli_real_escape_string($con, $password);
					
					$sql = "select * from user where Email = '$username' and Parola = '$password' ";
					$result = mysqli_querry($con, $sql);
					$row = mysqli_fetch_array($result, MYSQLI_ASSOC);
					$count = mysqli_num_rows($result);
					
					if($count == true){
					    include('aici.html');
					}
					else include('index.html');
?>