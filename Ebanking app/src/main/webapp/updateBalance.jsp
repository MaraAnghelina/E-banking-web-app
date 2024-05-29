<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>



<%
    String amount = request.getParameter("amount");
    // Puteți adăuga aici logica pentru a calcula noul sold în funcție de suma introdusă.
    // Deocamdată, doar returnăm un mesaj de test.
    // De exemplu, scădem suma introdusă dintr-un sold fictiv de $1000.
    int balance = Integer.parseInt(amount);
    out.print("Balance: $" + balance);
    
%>
