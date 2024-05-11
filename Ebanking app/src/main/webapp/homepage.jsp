<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Banking Homepage</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #2b2b2b;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        
        .container {
            background-color: #353535; 
            padding: 20px; 
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.1);
            width: 70%; 
            text-align: center;
            position: relative;
        }

        .balance {
            font-size: 24px;
            color: #eee; 
            margin-bottom: 20px;
        }

        .button-container {
            display: flex; 
            justify-content: space-between; 
            overflow-x: auto; 
            margin-bottom: 10px; 
        }

        .button-container input[type="submit"] {
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            box-sizing: border-box;
            color: white;
            background-color: #483D8B; 
            cursor: pointer;
            transition: background-color 0.3s;
            min-width: 120px;
        }

        .button-container input[type="submit"]:hover {
            background-color: #4682B4; 
        }

        .help-button {
            position: fixed;
            bottom: 20px;
            right: 20px;
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: #483D8B;
            color: white;
            font-size: 24px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            transition: background-color 0.3s;
            border: none; 
            z-index: 999;
        }

        .help-button:hover {
            background-color: #4682B4;
        }

        .settings-button {
            position: fixed;
            bottom: 20px;
            right: calc(20px + 50px + 10px); 
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: #483D8B;
            color: white;
            font-size: 24px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            transition: background-color 0.3s;
            border: none; 
            z-index: 998;
        }

        .settings-button:hover {
            background-color: #4682B4;
        }
    </style>
</head>
<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />
<body>
    
   
  
    
    <div class="container">
    	 
        <h2 style="color: #eee;">Welcome to M&A <%= request.getParameter("username") %>!</h2>
        
        <div class="balance">
            Your Account Balance: $1000 
        </div>

        <div class="button-container">
            <input type="submit" value="View Transactions">
            <input type="submit" value="Withdraw Funds">
            <input type="submit" value="Deposit Funds">
            <input type="submit" value="Transfer Money">
            <input type="submit" value="Loans">
        </div>
        
    </div>
    

   
    <div class="help-button" onclick="redirectToHelpPage()">
        <i class="fas fa-question"></i>
    </div>

   
    <div class="settings-button" onclick="redirectToSettingsPage()">
        <i class="fas fa-cog"></i>
    </div>

   
    <script>
        function redirectToHelpPage() {
            window.location.href = "help.jsp";
        }

       
        function redirectToSettingsPage(username) {
            window.location.href = "settings.jsp?username=" + <%= request.getParameter("username") %>;
        }
    
    </script>
    
</body>
</html>