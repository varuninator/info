<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
//Get the database connection
try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			String checkClass = "";
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			//String str = "SELECT * FROM user";
			
			//Run the query against the database.
			//ResultSet result = stmt.executeQuery(str);
			
			
			
			String str = "SELECT * FROM ticket";
			ResultSet result = stmt.executeQuery(str);
			out.print("Reservation Info: <br/>");
			
			boolean hasReservations = false;
			while(result.next()){
				if(result.getString("first_class").equals("1")){
					checkClass = "first class";
				}
				else if(result.getString("business_class").equals("1")){
					checkClass = "business class";
				}
				else{
					checkClass = "economy class";
				}
				if(session.getAttribute("user").equals(result.getString("username"))){
					out.print("id number: "+ result.getInt("id_num") + ", flight number: " + result.getInt("flight_number") + ", username: " + result.getString("username") + ", seat number: "+ result.getInt("seat_number")+ ", first name: " + result.getString("first_name") + ", last name: " + result.getString("last_name")+ ", class: " + checkClass + "<br/>");
					hasReservations = true;
					out.print("<br/>");
				}
			}
			
			if(!hasReservations) {
				out.print("No Reservations<br/>");
			}
			
			
			%>
			<br>
			<form method="get" action="Cancel.jsp">
				<input type="submit" value="Cancel Reservation" />
			</form>
			<form method="get" action="HomePage.jsp">
				<input type="submit" value="Return to Home Page" />
			</form>			
			<%
				

} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>