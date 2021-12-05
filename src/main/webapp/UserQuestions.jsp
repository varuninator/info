<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Questions</title>
</head>
<body>
<%
//Get the database connection
try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			boolean search = false;
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			//String str = "SELECT * FROM user";
			
			//Run the query against the database.
			//ResultSet result = stmt.executeQuery(str);
			
			//be able to search questions and answers by keywords

						%>
						<form method="get" action="UserQuestionAsked.jsp">
							<label>Enter a Question: <input name = "question"/></label>
			 				 <input type="submit" value="Ask" />
						</form>
						
						<form method="get" action="UserBrowseQuestions.jsp">
			 				 <input type="submit" value="Browse Questions" />
						</form>
						<br>
						<br>
			
						<form method="get" action="UserSearchByKeywords.jsp">
							<input type="radio" id="q" name="searchBy" value="question">
							<label for="q">Search by question keyword(s)</label>
							<br>
							<input type="radio" id="a" name="searchBy" value="answer">
							<label for="a">Search by answer keyword(s)</label>
							<br><br>
							<label>Enter 1st Keyword: <input name = "keyword_1"/></label>
			 				<br>
			 				<label>Enter 2nd Keyword: <input name = "keyword_2"/></label>
			 				<br>
			 				<label>Enter 3rd Keyword: <input name = "keyword_3"/></label>
			 				<br><br>
			 				<input type="submit" value="Search by Keywords" />						
			 			</form>
						<%
					
} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>