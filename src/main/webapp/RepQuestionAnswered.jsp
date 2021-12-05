<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Question Answered</title>
</head>
<body>
	<%
	try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
		String str = "SELECT * FROM otrs.question_answer";
		
		//Get parameters from the HTML form at the HelloWorld.jsp
		String a = request.getParameter("answer");

		if(!a.trim().isEmpty()) {
		//Make an insert statement for the Sells table:
		
		String up = "UPDATE otrs.question_answer SET answer_string = \"" + a + "\"" + " WHERE question_number =" + Collections.list(request.getParameterNames()).get(1);
		PreparedStatement ps = con.prepareStatement(up);
		//out.print(up);
		ps.executeUpdate();
		
		out.print("Question answered!");
		} else {
			out.print("Please insert an answer to the question that was asked.");
		}

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
	} catch (Exception ex) {
		out.print(ex);
		out.print("Question not answered");
	}
%>
</body>
</html>