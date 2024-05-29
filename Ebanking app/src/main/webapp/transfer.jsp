<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" import="java.lang.*,java.math.*,db.*,java.sql.*, java.io.*, java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Money Transfer - E-Banking App</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #2b2b2b; /* Dark background color */
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
            width: 400px;
        }
        .container h1 {
            text-align: center;
            margin-bottom: 20px;
            color: #eee;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input {
            width: calc(100% - 20px);
            padding: 8px 10px;
            border: 1px solid #ced4da;
            border-radius: 4px;
        }
        .form-group button {
            width: 100%;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            background-color: #007bff;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }
        .form-group button:hover {
            background-color: #0056b3;
        }
        input[type="text"], input[type="password"], input[type="submit"] {
            width: 90%;
            padding: 10px;
            margin: 8px 10px;
            display: inline-block;
            border: 1px solid #444; /* Darker border color */
            border-radius: 4px;
            box-sizing: border-box;
            color: #eee; /* Light font color */
            background-color: #444; /* Darker background color for inputs */
        }
        input[type="submit"] {
            background-color: #483D8B;
            color: white;
            margin: 8px 10px;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #4682B4;
        }
        label {
            color: #eee; /* Light font color for labels */
        }
        .balance-tooltip {
            display: none;
            position: absolute;
            top: -30px;
            right: 0;
            background-color: #f8f9fa;
            border: 1px solid #ced4da;
            border-radius: 4px;
            padding: 5px;
            font-size: 14px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            z-index: 1;
        }
        alert.custom-alert {
		  --backdrop-opacity: 0.7;
		}
		
		.custom-alert .alert-button-group {
		  padding: 8px;
		}
		
		button.alert-button.alert-button-confirm {
		  background-color: var(--ion-color-success);
		  color: var(--ion-color-success-contrast);
		}
		
		.md button.alert-button.alert-button-confirm {
		  border-radius: 4px;
		}
		
		.custom-alert button.alert-button {
		  border: 0.55px solid rgba(var(--ion-text-color-rgb, 0, 0, 0), 0.2);
		}
		
		button.alert-button.alert-button-cancel {
		  border-right: 0;
		  border-bottom-left-radius: 13px;
		  border-top-left-radius: 13px;
		}
		
		button.alert-button.alert-button-confirm {
		  border-bottom-right-radius: 13px;
		  border-top-right-radius: 13px;
		}
		
		.transactions {
            background-color: #444;
            padding: 10px;
            border-radius: 5px;
            margin-top: 20px;
            color: #eee;
        }
        .balance {
            font-size: 20px;
            color: #eee; 
            margin-bottom: 20px;
            text-align: center;
        }
    </style>
</head>

<jsp:useBean id="jb" scope="session" class="db.JavaBean" />
<jsp:setProperty name="jb" property="*" />

<% double amount = 0; %>

<body>
    <div class="container">
        <h1>Money Transfer</h1>
        <form id="transferForm" method="post" action="updateBalance.jsp">
            <div class="form-group">
                <label for="recipientName">Recipient Name</label>
                <input type="text" id="recipientName" name="recipientName" required>
            </div>
            <div class="form-group">
                <label for="accountNumber">Account Number</label>
                <input type="text" id="accountNumber" name="accountNumber" required>
            </div>
            <div class="form-group">
                <label for="amount">Amount</label>
                <input type="text" id="amount" name="amount" function="updateBalance()" required>
                <%
	                if(request.getParameter("amount") != null){
	    				amount = Double.parseDouble(request.getParameter("amount"));
	    				
	                }
	                out.print(amount);
                %>
            </div>
            <div class="form-group">
            	<button value="Transfer">Transfer</button>
                
                <alert trigger="present-alert" class="custom-alert" header="Are you sure?" [buttons]="alertButtons"></alert>
            </div>
        </form>
        
        <div class="transactions">
            <h4>Your account balance: </h4>
                <% 
	                String email =(String) session.getAttribute("email");
	        		int id = 0;
	    	    	
	    	    	String error;
	    	    	Connection con;
	    	     	
	    	    	Class.forName("com.mysql.cj.jdbc.Driver");
	    	    	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/ebanking?useSSL=false", "root", "Trompisor*2002*");
	    	    	
	    	    	String queryString = ("select iduser from user where Email='" + email + "';");
	    	    	Statement stmt = con.createStatement(/*ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY*/);
	    	    	ResultSet rs = stmt.executeQuery(queryString);
	    	    	if(rs.next())
	    	    		id = rs.getInt("iduser");
	    	    	
	    	    	double sum = 0;
	    	    	queryString = ("select Suma from conturi where iduser='" + id + "';");
	    	    	stmt = con.createStatement(/*ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY*/);
	    	    	rs = stmt.executeQuery(queryString);
	    	    	if(rs.next())
	    	    		sum = rs.getDouble("Suma");
	    	    	sum = sum - amount;
	    	    	
	    	    	String currency = "";
	    	    	queryString = ("select Valuta from conturi where iduser='" + id + "';");
	    	    	stmt = con.createStatement(/*ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY*/);
	    	    	rs = stmt.executeQuery(queryString);
	    	    	if(rs.next())
	    	    		currency = rs.getString("Valuta");
	                    
                %>
                   <div class="balance">
			             <%= sum %>  <%= currency %>
			        </div>
                <% 
                    
                    rs.close();
                    stmt.close();
                    con.close();
                %>
                
           		<form name="aform" action="#"> 
        <input type="text" name="name" onkeyup="nameModify(this.form.elements['email'], this);" >
        <input type="text" name="email" >
		</form>
           		
        </div>
        
    </div>

    <script>
    	const int balance = 0;
	    function updateBalance() {
	        const xhr = new XMLHttpRequest();
	        const amount = document.getElementById('amount').value;
	        
	        xhr.open("POST", "updateBalance.jsp", true);
	        xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	        xhr.send("amount=" + amount);
	       	alert("aiciiiiiiiiiiiiii");
	    }
	    function nameModify(emailElement, nameElement) {

	        emailElement.value = nameElement.value + '@stackoverflow.com';
	}
	   
	    
    </script>
</body>
</html>
