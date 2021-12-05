<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Login</title>
	</head>

	<body>
	<%
	out.print("Welcome!<br/><br/>Login Below:<bre/>");
	%>
		<br>
		<form method="get" action="HomePage.jsp">
			<label>Username: <input name = "user"/></label>
			<label>Password: <input name = "pass"/></label>
		  <input type="submit" value="Login" />
		</form>
		<br>
		<br>
	<% 
	out.print("Dont have an account with us?<br/>Dont worry! Create one below:<br/><br/>(Maximum of 50 characters are allowed for each)");
	%>
		<form method="get" action="createAccount.jsp">
			<label>Username: <input name = "user"/></label>
			<label>Password: <input name = "pass"/></label>
			<label>First Name: <input name = "first"/></label>
			<label>Last Name: <input name = "last"/></label>
		  <input type="submit" value="Create Account" />
		</form>
		<%
	%>
	</body>
</html>