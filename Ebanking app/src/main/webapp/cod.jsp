<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>

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
            padding: 50px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(255, 255, 255, 0.1);
            width: 70%; 
        }

        label {
            color: #eee;
            display: block;
            margin-bottom: 8px;
            text-align: center;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px 15px;
            margin-top: 6px;
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

<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />

<body>
	
	<%
		String email =(String) session.getAttribute("email");
		int id = 0;
		
	    String error;
		Connection con;
	 	
		Class.forName("com.mysql.cj.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebanking?useSSL=false&allowPublicKeyRetrieval=true", "root", "Berberita@10");
		jb.connect();
		
		String queryString = ("select iduser from user where Email='" + email + "';");
    	Statement stmt = con.createStatement(/*ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY*/);
    	ResultSet rs = stmt.executeQuery(queryString);
    	if(rs.next())
    		id = rs.getInt("iduser");
    	
    	String currency = "";
    	queryString = ("select Valuta from conturi where iduser='" + id + "';");
    	stmt = con.createStatement(/*ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY*/);
    	rs = stmt.executeQuery(queryString);
    	if(rs.next())
    		currency = rs.getString("Valuta");
		
		if(request.getParameter("sum") != null){
				double sum = Double.parseDouble(request.getParameter("sum"));
				String date = new Date().toString().substring(0, 10);
				stmt = con.createStatement();
				stmt.executeUpdate("insert into tranzactii(TipTranzactie, Suma, Data, Valuta, iduser) values('" + "withdraw funds" + "' , '" + sum + "', '" + date + "', '" + currency + "', '" + id +"' );");
				stmt = con.createStatement();
				
				double suma = 0;
		    	queryString = ("select Suma from conturi where iduser='" + id + "';");
		    	stmt = con.createStatement(/*ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY*/);
		    	rs = stmt.executeQuery(queryString);
		    	if(rs.next())
		    		suma = rs.getDouble("Suma");
		    	suma = suma - sum;
				
				stmt.executeUpdate("update conturi set Suma = '" + suma + "' where iduser='" + id + "';");
				
		}
		if(request.getParameter("amount") != null){
			double sum = Double.parseDouble(request.getParameter("amount"));
			String date = new Date().toString().substring(0, 10);
			stmt = con.createStatement();
			stmt.executeUpdate("insert into tranzactii(TipTranzactie, Suma, Data, Valuta, iduser) values('" + "deposit funds" + "' , '" + sum + "', '" + date + "', '" + currency + "', '" + id +"' );");
			stmt = con.createStatement();
			
			double suma = 0;
	    	queryString = ("select Suma from conturi where iduser='" + id + "';");
	    	stmt = con.createStatement(/*ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY*/);
	    	rs = stmt.executeQuery(queryString);
	    	if(rs.next())
	    		suma = rs.getDouble("Suma");
	    	suma = suma + sum;
			
			stmt.executeUpdate("update conturi set Suma = '" + suma + "' where iduser='" + id + "';");
		}
		
		jb.disconnect();
		
    %>

    <div class="content">
        
        <div class="container">
            <form action="homepage.jsp" method="post">
            
            	<h2>Your code: </h2> 
        		<label id="random-code-label"></label>    
        
            	<script>
	            	function generateRandomCode() {
	            	    var code = Math.floor(Math.random() * 9000) + 1000;
	            	    return code;
	            	}
	            	
	            	var randomCode = generateRandomCode();
	            	var label = document.getElementById("random-code-label");
	            	label.textContent = randomCode;
	            	
            	</script>
            
                <input type="submit" name="submit" value="Finish">
            </form>
        </div>
    </div>
</body>
</html>