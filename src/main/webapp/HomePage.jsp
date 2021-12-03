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
			boolean loggedIn = false;
			boolean search = false;
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String username = request.getParameter("user");
			String password = request.getParameter("pass");
			if(username != null){
				session.setAttribute("user", username);
			}
			if(password != null){
				session.setAttribute("pass", password);
			}
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM user";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			while (result.next()) {
				if((result.getString("username").equals(session.getAttribute("user")))&&result.getString("pass").equals(session.getAttribute("pass"))){
				 	loggedIn = true;
				 	
					out.print("You are currently logged in as  "+ session.getAttribute("user"));
					if(result.getInt("type1")==(0)){
						out.print(" and are an admin.");
						%>
						<form method="get" action="HelloWorld.jsp">
			  				<input type="submit" value="Logout" />
						</form>
						<body>
						<form method="get" action="FlightInfoAdminView.jsp">
							<label>Search Flights:   <input name = "SearchFlight"/></label>
			 				 <input type="submit" value="Search Flights" />
						</form>
						</body>
						<form method="get" action="AdminViewUserInfo.jsp">
							<label>Search Users:   <input name = "SearchUser"/></label>
			 				 <input type="submit" value="Search User" />
						</form>
						<form method="get" action="AirlineInfoAdmin.jsp">
							<label>Search Airlines: <input name = "SearchAirline"/></label>
			 				 <input type="submit" value="Search Airline" />
						</form>
						<form method="get" > 
		  				<input type="submit" value="Sales Report" />
						</form>
						<form method="get" action="UserList.jsp" > 
		  				<input type="submit" value="List of all users" />
						</form>
						<form method="get" action="FlightList.jsp" > 
		  				<input type="submit" value="List of most active Flights" />
						</form>
						<%
						
					}

					else if(result.getInt("type1")==1){
						out.print(" and are a customer representative.");
						%>
						<form method="get" action="HelloWorld.jsp">
			  				<input type="submit" value="Logout" />
						</form>
						<body>
						<form method="get" action="rep_Browse.jsp">
							<label>Search Flights: <input name = "search"/></label>
			 				 <input type="submit" value="Search" />
						</form>
						<form method="get" action="rep_UserInformation.jsp">
							<label>Search User: <input name = "search"/></label>
			 				 <input type="submit" value="Search" />
						</form>
						<form method="get" action="rep_FlightInformation.jsp">
							<label>Search Flight: <input name = "search"/></label>
			 				 <input type="submit" value="Search" />
						</form>
						<form method="get" action="rep_AirportInformation.jsp">
							<label>Search Airport: <input name = "search"/></label>
			 				 <input type="submit" value="Search" />
						</form>
						<form method="get" action="rep_AirlineInformation.jsp">
							<label>Search Airline: <input name = "search"/></label>
			 				 <input type="submit" value="Search" />
						</form>
						<form method="get" action="UserQuestions.jsp">
			  				<input type="submit" value="Browse User Questions" />
						</form>
						<%
					}
					else{
						out.print(" and are a customer.");
						%>
						<form method="get" action="HelloWorld.jsp">
			  				<input type="submit" value="Logout" />
						</form>
						<body>
						<form method="get" action="Browse.jsp">
							<label>Search Flights: <input name = "search"/></label>
			 				 <input type="submit" value="Search" />
						</form>
						</body>
						<form method="get" action="Account.jsp">
		  				<input type="submit" value="Account" />
						</form>
						<form method="get" action="UserQuestions.jsp">
		  				<input type="submit" value="Questions" />
						</form>
						<%
					}
					
				}
				
				
		
				//out.print(result.getString("username")+ "\n");
			}
			
			if(!loggedIn){
				out.print("Sorry you have entered an incorrect username or password");
				%>
				<form method="get" action="HelloWorld.jsp">
	  				<input type="submit" value="Try Again" />
				</form>
				<%
			}
			
		
			
			
			
} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>