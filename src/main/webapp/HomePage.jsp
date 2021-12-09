<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home Page</title>
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
			
			String rep_user = request.getParameter("SearchUser");
			if(rep_user != null){
				session.setAttribute("rep_user", rep_user);
			}
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM user";
			//String strFlight = "SELECT * FROM otrs.flight";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			//ResultSet resultFlight = stmt.executeQuery(strFlight);
			
			while (result.next()) {
				if((result.getString("username").equals(session.getAttribute("user")))&&result.getString("pass").equals(session.getAttribute("pass"))){
				 	loggedIn = true;
				 	
				 	if(result.getString("first_name") != null){
						session.setAttribute("first", result.getString("first_name"));
					}
					if(result.getString("last_name") != null){
						session.setAttribute("last", result.getString("last_name"));
					}
									
					if(result.getInt("type1")==(0)){
						out.print("Welcome back " + result.getString("first_name") + " " + result.getString("last_name") + "!<br/>");
						out.print("Clearence: Admin<br/>Username: " + result.getString("username"));
						
						%>
						<form method="get" action="HelloWorld.jsp">
			  				<input type="submit" value="Logout" />
						</form>
						<body>
						<br>
						<form method="get" action="createAccount.jsp">
							<label>Username: <input name = "user"/></label>
							<label>Password: <input name = "pass"/></label>
							<label>First Name: <input name = "first"/></label>
							<label>Last Name: <input name = "last"/></label>
		  					<input type="submit" value="Create New User Account" />
						</form>
						</body>
						<br>
						
						<form method="get" action="AdminViewUserInfo.jsp">
							<label>Search Users:   <input name = "SearchUser"/></label>
			 				<input type="submit" value="Search User" />
						</form>
						<br>
						<form method="get" action="FlightInfoAdminView.jsp">
							<label>Search Flights:   <input name = "SearchFlight"/></label>
			 				 <input type="submit" value="Search Flights" />
						</form>
						</body>
						<br>
						<form method="get" action="AirlineInfoAdmin.jsp">
							<label>Search Airlines: <input name = "SearchAirline"/></label>
			 				 <input type="submit" value="Search Airline" />
						</form>
						<br>
						<form method="get" action="SalesReport.jsp"> 
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
						out.print("Welcome back " + result.getString("first_name") + " " + result.getString("last_name") + "!<br/>");
						out.print("Clearence: Customer Repersentative<br/>Username: " + result.getString("username"));
						%>
						<form method="get" action="HelloWorld.jsp">
			  				<input type="submit" value="Logout" />
						</form>
						<br>
						<body>	
						<form name = userForm method = get action = "HomePage.jsp">
							<label>Pick User:   <input name = "SearchUser"/></label>
			 				<input type="submit" value="Set User" />
						</form>
						<form method="get" action="rep_Browse.jsp">
							<label>Date for one way trip (yyyy-mm-dd): <input name = "search"/></label>
							<label>Starting Airport(XXX): <input name = "airStart"/></label>
							<label>Ending airport Airport(XXX): <input name = "airEnd"/></label>
							 <select name="flexibility" size=1>
							<option value="0">No Flexibility</option>
							<option value="1">One Day Flexibility</option>
							<option value="2">Two Day Flexibility</option>
							<option value="3">Three Day Flexibility</option>
							</select>&nbsp;<br> <input type="submit" value="Submit">
			 				<%-- <input type="submit" value="Search" />--%>
						</form>
						</body>
						<form method="get" action="rep_Browse.jsp">
							<label>Date for round start trip (yyyy-mm-dd): <input name = "search"/></label>
							<label>Date for round end trip (yyyy-mm-dd): <input name = "search2"/></label>
							<label>Starting Airport(XXX): <input name = "airStart"/></label>
							<label>Ending airport Airport(XXX): <input name = "airEnd"/></label>
							<select name="flexibility" size=1>
							<option value="0">No Flexibility</option>
							<option value="1">One Day Flexibility</option>
							<option value="2">Two Day Flexibility</option>
							<option value="3">Three Day Flexibility</option>
			 				</select>&nbsp;<br> <input type="submit" value="Submit">
			 				<%-- <input type="submit" value="Search" />--%>
						</form>
						<br>
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
						<form method="get" action="rep_AircraftInformation.jsp">
							<label>Search Aircraft: <input name = "search"/></label>
			 				 <input type="submit" value="Search" />
						</form>
						<br>
						<form method="get" action="RepBrowseQuestions.jsp">
			  				<input type="submit" value="Browse User Questions" />
						</form>
						<%
					}
					else{
						out.print("Welcome back " + result.getString("first_name") + " " + result.getString("last_name") + "!<br/>");
						out.print("Clearence: Customer<br/>Username: " + result.getString("username"));
						%>
						<form method="get" action="HelloWorld.jsp">
			  				<input type="submit" value="Logout" />
						</form>
						<br>
						<body>
						<form method="get" action="Browse.jsp">
							<label>Date for one way trip (yyyy-mm-dd): <input name = "search"/></label>
							<label>Starting Airport(XXX): <input name = "airStart"/></label>
							<label>Ending airport Airport(XXX): <input name = "airEnd"/></label>
							 <select name="flexibility" size=1>
							<option value="0">No Flexibility</option>
							<option value="1">One Day Flexibility</option>
							<option value="2">Two Day Flexibility</option>
							<option value="3">Three Day Flexibility</option>
							
							
							</select>&nbsp;<br> <input type="submit" value="Submit">
			 				<%-- <input type="submit" value="Search" />--%>
						</form>
						<br>
						</body>
						<form method="get" action="Browse.jsp">
							<label>Date for round start trip (yyyy-mm-dd): <input name = "search"/></label>
							<label>Date for round end trip (yyyy-mm-dd): <input name = "search2"/></label>
							<label>Starting Airport(XXX): <input name = "airStart"/></label>
							<label>Ending airport Airport(XXX): <input name = "airEnd"/></label>
							<select name="flexibility" size=1>
							<option value="0">No Flexibility</option>
							<option value="1">One Day Flexibility</option>
							<option value="2">Two Day Flexibility</option>
							<option value="3">Three Day Flexibility</option>
			 				</select>&nbsp;<br> <input type="submit" value="Submit">
			 				<%-- <input type="submit" value="Search" />--%>
						</form>
					    <br>
						<form method="get" action="AccountInfo.jsp">
		  				<input type="submit" value="Account Info" />
						</form>
						<form method="get" action="UserQuestions.jsp">
		  				<input type="submit" value="Ask Questions!" />
						</form>
						<%
					}
					
				}
			}
			boolean full = false;
			
			//out.print(session.getAttribute("f_num"));
				ArrayList<Integer> decWLs = new ArrayList<Integer>();
				String delWL = "";
				str = "SELECT * FROM flys INNER JOIN aircraft ON aircraft.aircraft_id = flys.aircraft_id INNER JOIN flight ON flight.flight_number = flys.flight_number INNER JOIN waitlist ON flys.flight_number = waitlist.flight_number WHERE waitlist.username = \"" + session.getAttribute("user") + "\"";
				//out.print(str);
				result = stmt.executeQuery(str);
				int currentFlight = 0;
				out.print("<br/>WAITLIST ALERTS: <br/>");
				while(result.next()){
						if(result.getInt("passengers") < result.getInt("number_of_seats") && result.getInt("spot") == 1){
							out.print("FLIGHT: " + result.getInt("flight_number")+ " HAS OPENED<br/>");
							delWL = "DELETE FROM otrs.waitlist WHERE username = \"" + result.getString("username") + "\"" + " AND " + "spot = " + result.getInt("spot") + " AND" + " flight_number = " + result.getInt("flight_number");
							out.print(delWL);
							PreparedStatement ps = con.prepareStatement(delWL);
							ps.executeUpdate();

						}
						
				}
				
				str = "SELECT * FROM waitlist WHERE flight_number = " + "";
				result = stmt.executeQuery(str);
				
				for(int i = 0; i < decWLs.size(); i++) {
					while(result.next()) {
						if(result.getInt("flight_number") == decWLs.get(i)) {
							
							
							
							decWLs.remove(i);
						}		
					}
				}
				

				
		
				
			
			
			//out.print(session.getAttribute("flFull"));
			/*if(session.getAttribute("flightFull") ==true&&session.getAttribute("f_num")!=null){
				out.print("FLIGHT: " + result.getInt("flight_number") + " IS OPEN");
			}	
			
			
			
			//out.print("passengers: "+result.getInt("passengers"));
			//out.print("seats: "+ result.getInt("number_of_seats"));
		if(result.getInt("passengers")==result.getInt("number_of_seats")){
				full = true;
			}
		
		session.setAttribute("flightFull", full);*/
		
		
		
		
			
			
			
			
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