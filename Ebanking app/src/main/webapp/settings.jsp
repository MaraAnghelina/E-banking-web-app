<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />

<%
    String username = (String) session.getAttribute("username"); 

    
    if (request.getParameter("submit") != null) {
        try {
            jb.connect();
            String newPassword = request.getParameter("newPassword");

            
%>

<html>
<head>
    <title>Update Successful</title>
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
        
        h1, p, a {
            color: #eee;
            text-align: center;
        }

        a {
            text-decoration: none;
            color: #4682B4;
        }
    </style>
</head>
<body>
    <h1>Update Successful</h1>
    <p>Your password has been updated successfully.</p>
    <p><a href="homepage.jsp">Back to Homepage</a></p>
</body>
</html>
<%
            jb.disconnect();
        } catch (Exception e) {
           
            out.println("Error: " + e.getMessage());
        }
    }
%>



<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings</title>
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
        
        .content {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        
        h2 {
            color: #eee;
            text-align: center;
            margin-bottom: 20px;
        }

        .container {
            background-color: #444;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.1);
            width: 70%; 
        }

        label {
            color: #eee;
            display: block;
            margin-bottom: 8px;
        }

        input[type="password"] {
            width: calc(100% - 22px);
            padding: 12px;
            margin-bottom: 16px;
            border: 1px solid #4682B4;
            border-radius: 4px;
            box-sizing: border-box;
            color: #eee;
            background-color: #333;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px 15px;
            border: none;
            border-radius: 4px;
            box-sizing: border-box;
            color: white;
            background-color: #483D8B; 
            cursor: pointer;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #4682B4; 
        }
    </style>
</head>

<body>
    <div class="content">
        <h2>Enter new password </h2> 
        <div class="container">
            <form action="updateUserData.jsp" method="post">
                <label for="newPassword">New Password:</label>
                <input type="password" id="newPassword" name="newPassword" required><br><br>
                <input type="submit" name="submit" value="Update">
            </form>
        </div>
    </div>
</body>
</html>