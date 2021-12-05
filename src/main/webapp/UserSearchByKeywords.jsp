<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Browse Questions</title>
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
			
			//Get parameters from the HTML form at the HelloWorld.jsp
			String searchBy = request.getParameter("searchBy");
			String k1 = request.getParameter("keyword_1");
			String k2 = request.getParameter("keyword_2");
			String k3 = request.getParameter("keyword_3");
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM otrs.question_answer";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			if(searchBy == null) {
				out.print("Please select whether to search by question or answer keywords.");
			} else {
				if(searchBy.equals("question")) {
					out.print("Questions containing keywords:\n");
				} else if(searchBy.equals("answer")) {
					out.print("Answers containing keywords:\n");				
				}
				
				if(!k1.trim().isEmpty()) {
					%>
					<body>
					<br>
					</body>
					<%
					out.print("Keyword #1 = " + k1);
				}
				if(!k2.trim().isEmpty()) {
					%>
					<body>
					<br>
					</body>
					<%
					out.print("Keyword #2 = " + k2);
				}
				if(!k3.trim().isEmpty()) {
					%>
					<body>
					<br>
					</body>
					<%
					out.print("Keyword #3 = " + k3);
				}
				if(k1.trim().isEmpty() && k2.trim().isEmpty() && k3.trim().isEmpty()) {
					%>
					<body>
					<br>
					</body>
					<%
					if(searchBy.equals("question")) {
						out.print("No keywords were entered... Displaying all questions.");
					} else if(searchBy.equals("answer")) {
						out.print("No keywords were entered... Displaying all questions with answers.");
					}
				}
				%>
				<body>
				<br><br>
				</body>
				<%
			} 
			
			while(result.next()) {
				if(searchBy == null) {
					break;
				}
				if(searchBy.equals("question")) {
					if(result.getString("question_string").contains(k1.trim()) && result.getString("question_string").contains(k2.trim()) && result.getString("question_string").contains(k3.trim())) {
						out.print("Question #" + result.getInt("question_number") + ": " + result.getString("question_string") + "?");
						%>
						<body>
						<br>
						</body>
						<%
						out.print("Answer #" + result.getInt("question_number") + ": " + result.getString("answer_string"));
						%>
						<body>
						<br><br>
						</body>
						<%
					}
				} else if(searchBy.equals("answer")) {
					if(result.getString("answer_string").isEmpty()) {
						continue;
					} else if(result.getString("answer_string").contains(k1.trim()) && result.getString("answer_string").contains(k2.trim()) && result.getString("answer_string").contains(k3.trim())) {
						out.print("Question #" + result.getInt("question_number") + ": " + result.getString("question_string") + "?");
						%>
						<body>
						<br>
						</body>
						<%
						out.print("Answer #" + result.getInt("question_number") + ": " + result.getString("answer_string"));
						%>
						<body>
						<br><br>
						</body>
						<%
					}
				}
			}


} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>