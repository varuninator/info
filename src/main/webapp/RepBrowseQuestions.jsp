<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Representative Browse Questions</title>
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
			String str = "SELECT * FROM otrs.question_answer";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			

			%>
			<body>
				Unanswered Questions:
				<br>
				<br>
			</body>
			<%
			
			int count = 0;
			while(result.next()) {
				int question_number = result.getInt("question_number");
				if(result.getString("answer_string").isEmpty()) {
					out.print("Question #" + result.getInt("question_number") + ": " + result.getString("question_string") + "?");
					%>
					<body>
					<br>
					</body>
					<%
					%>
					<body>
						<form name = <%="form" + count %> method="get" action="RepQuestionAnswered.jsp">
							<label>Answer Question #<%=question_number%>: <input name = "answer"/></label>
							<br>
							<input type="hidden" name = <%=question_number%>>
					 		<input type="submit" value="Answer Question" onclick = <%="func" + count %>()/>
						</form>
					<br><br>
					</body>

					<script language = "JavaScript">
						function <%="func" + count %>(){
							document.<%="form" + count %>.<%=question_number%>.value = "yes";
							<%="form" + count %>.submit();
						}
					</script>
					<%				
				}
				count++;
			}


} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>