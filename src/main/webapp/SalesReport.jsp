<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd%22%3E
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sales Report</title>
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

            String month = request.getParameter("SalesMonth");
            String year = request.getParameter("SalesYear");
            
			String calc = "SELECT COUNT(*) AS numTickets FROM ticket";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(calc);
			result.next();
			int numTickets = result.getInt("numTickets");
			
			if(numTickets == 0) {
				out.print("Cannot calculate the customer who brought in the most revenue because no tickets have been purchased yet.");
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
	            	out.print("There are no customers within the system: Cannot derive a single customer who brought in the most revenue at this time");
		            out.print("<br/>");
	            }
	            else if(usercounter >= 2){
		            calc = "SELECT u.username, COUNT(*) FROM otrs.user u, otrs.ticket t WHERE u.username = t.username GROUP BY u.username " +
		            "HAVING COUNT(*) = (SELECT MAX(t1.flightsBooked) AS ticketMaxCustomer FROM (SELECT count(*) AS flightsBooked FROM otrs.user u, otrs.ticket t " +
					"WHERE u.username = t.username GROUP BY u.username) AS t1);";
					
					result = stmt.executeQuery(calc);
					result.next();
					
					out.print("The customer who brought the most revenue is (username): " + result.getString("username"));
		            out.print("<br/>");
	            }else{
	            	calc = "SELECT * FROM user";
	            	result = stmt.executeQuery(calc);
	            	while(result.next()){
	                	if((result.getInt("type1") != 0) && (result.getInt("type1") != 1)){ 
	                		out.print("The customer who brought the most revenue is (username): " + result.getString("username"));
	                    	out.print("<br/>");
	                    	break;
	                	}
	                }
	            }
			}
            %>
            <br>
            <form method="get" action="SalesReport.jsp">
            	<label>Enter a month and year for the specific month's sales report below </label>
            	<br>
                <label>Enter a month (MM)): <input name = "SalesMonth"/></label>
                <label>Enter a year (YYYY): <input name = "SalesYear"/></label>
                <input type="submit" value="Search Month's sales report" />
            </form>
            <br>
            <%
            if ((month != null) || (year != null)){
	            if((month.trim().isEmpty()) && (!year.trim().isEmpty())){
	                out.print("<br/>Please enter a month for " + year + " and try again.");
	            }
	            else if((!month.trim().isEmpty()) && (year.trim().isEmpty())){
	                out.print("<br/>Please enter a year for month " + month + " and try again.");
	            }
	            else if((!month.trim().isEmpty()) && (!year.trim().isEmpty())){
	                out.print("<br/>Sales Report for the month: " + month + " - " + year + "<br/>");
	
	                calc = "SELECT SUM(30 * passengers) AS TRev FROM otrs.flight WHERE MONTH(departure_time) = \"" + month + "\" AND YEAR(departure_time) = \"" + year + "\"";
	                result = stmt.executeQuery(calc);
	                result.next();
	                out.print("<br/>Revenue gained during: $" + result.getInt("Trev"));
	                
	                calc = "SELECT SUM(passengers) AS TotalPassengers FROM otrs.flight WHERE MONTH(departure_time) = \"" + month + "\" AND YEAR(departure_time) = \"" + year + "\"";
	                result = stmt.executeQuery(calc);
	                result.next();
	                out.print("<br/>Total tickets sold: " + result.getInt("TotalPassengers"));
	            }
	            else if((month.trim().isEmpty()) && (year.trim().isEmpty())){
	            	out.print("<br/>Please enter a month (MM) and year (YYYY) above and try again.");
	            }
            }
            %>
            <br>
            <form method="get" action="HomePage.jsp">
		  	<input type="submit" value="Go directly back to home page" />
			</form>
            <%


} catch (Exception e) {
    out.print(e.getMessage());
    //out.print(e);
}
            %>
</body>
</html>