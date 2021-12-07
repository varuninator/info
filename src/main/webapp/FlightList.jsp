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
            boolean searched = false;

            //Create a SQL statement
            Statement stmt = con.createStatement();

			String calc = "SELECT COUNT(*) AS numTickets FROM ticket";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(calc);
			result.next();
			int numTickets = result.getInt("numTickets");
			
			if(numTickets == 0) {
				out.print("Cannot calculate the most active flight because no tickets have been purchased yet.");
				out.print("<br/>");
			} else {
				calc = "SELECT * FROM user";
				result = stmt.executeQuery(calc);
	
				int usercounter = 0;
	            while(result.next()){
	            	if((result.getInt("type1") != 0) && (result.getInt("type1") != 1)){ 
	            		usercounter++;
	            	}
	            }
	            if(usercounter == 0){
	            	out.print("There are no customers within the system: Cannot derive a the most active flight at this time");
		            out.print("<br/>");
	            }
	            else if(usercounter >= 1){
		            calc = "SELECT f.flight_number, COUNT(*) FROM otrs.flight f, otrs.ticket t WHERE f.flight_number = t.flight_number GROUP BY f.flight_number " +
		            "HAVING COUNT(*) = (SELECT MAX(t1.ticketsSold) AS ticketMaxFlight FROM (SELECT count(*) AS ticketsSold FROM otrs.flight f, otrs.ticket t " +
					"WHERE f.flight_number = t.flight_number GROUP BY f.flight_number) AS t1);";
					
					result = stmt.executeQuery(calc);
					
					while(result.next()) {
						out.print("The most active flight is (flight number): " + result.getString("flight_number"));
						out.print("<br/>");
					}
	            }
			}
			
} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>