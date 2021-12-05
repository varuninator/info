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
            //Get the combobox from the index.jsp
            //String str = "SELECT * FROM user";

            //Run the query against the database.
            //ResultSet result = stmt.executeQuery(str);

            String month = request.getParameter("SalesMonth");
            String year = request.getParameter("SalesYear");
            
            
			out.print("The customer who brought the most revenue is (username): " + "ENTER NAME HERE");
            out.print("<br/>");
            %>
            <br>
            <form method="get" action="SalesReport.jsp">
                 <label for="start">Start month:</label> 
                <label>Enter a month for the specific month's sales report (MM)): <input name = "SalesMonth"/></label>
                <label>Enter a year for the specific month's sales report (YYYY): <input name = "SalesYear"/></label>
                <input type="submit" value="Search Month" />
            </form>
            <br>
            <%
            if((month != null) || (year != null)){
                out.print("<br/>");
                out.print("Sales Report for the month: " + month + " - " + year + "<br/>");

                String calc = "SELECT SUM(30 * passengers) AS TRev FROM otrs.flight WHERE MONTH(departure_time) = \"" + month + "\" AND YEAR(departure_time) = \"" + year + "\"";
                ResultSet result = stmt.executeQuery(calc);
                //out.print(calc);
                result.next();
                out.print("<br/>Revenue gained during " + month + " - " + year+ ": $" + result.getInt("Trev"));
                out.print("<br/>Revenue gained during " + month + " - " + year+ ": $" + result.getInt("Trev"));



            }


} catch (Exception e) {
    out.print(e);
}
            %>
</body>
</html>