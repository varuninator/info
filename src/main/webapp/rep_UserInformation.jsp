<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Information</title>
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
			
			String sch = request.getParameter("search");
			
			if(sch != null){
				session.setAttribute("search", sch);
			}
			%>
			<form method="get" action="rep_UserInformation.jsp">
					<label>Search User: <input name = "search"/></label>
	 				 <input type="submit" value="search" />
				</form>
			<%
			String ticket_class = request.getParameter("class");
			String seat = request.getParameter("seat");
			String str = "";
			ResultSet result;
			
			
			if(seat != null  && seat != "" && session.getAttribute("id") != null){
				str = "Select * from ticket where flight_number = " + session.getAttribute("ticket_flight") + " and seat_number = " + seat;

				result = stmt.executeQuery(str);
				if(result.next() == false){
					str = "update ticket set seat_number = " + request.getParameter("seat") + " where id_num = " + session.getAttribute("id");
					PreparedStatement ps = con.prepareStatement(str);
					
					ps.executeUpdate();
				}
			}
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			//String str = "SELECT * FROM user";
			
			//Run the query against the database.
			//ResultSet result = stmt.executeQuery(str);
			str = "SELECT * FROM user";
		
			//Run the query against the database.
			result = stmt.executeQuery(str);
			while(result.next()){
				if(result.getString("username").equals(session.getAttribute("search"))){
					String label = "User: " + result.getString("username");
					%>
					<form method="get" action="rep_UserInformation.jsp">
							<label><%=label + " "%><input name = "edit_user"/></label>
			 				 <input type="submit" value="edit" />
						</form>
					<%
					label = "Type: " + result.getInt("type1");
					%>
					<form method="get" action="rep_UserInformation.jsp">
							<label><%=label + " "%><input name = "edit_type"/></label>
			 				 <input type="submit" value="edit" />
						</form>
					<%
					out.print("<br/>");
				}
			}
			
			str = "SELECT * from ticket WHERE username = \"" + session.getAttribute("search") + "\"";
			//Run the query against the database.
			result = stmt.executeQuery(str);
			out.print("<br/>");		
			int count = 0;

			
			while(result.next()){
				out.print("Flight_Number: " + result.getInt("flight_number") + ", Id Number: " + result.getInt("id_num") + ", Seat: " + result.getInt("seat_number"));
				if(result.getBoolean("first_class")){
					out.print(", Class: First");
				}
				if(result.getBoolean("business_class")){
					out.print(", Class: Business");
				}
				if(result.getBoolean("economy_class")){
					out.print(", Class: Economy");
				}
				
				String id = String.valueOf(result.getInt("id_num"));
				String flight_number = String.valueOf(result.getInt("flight_number"));

					%> <form name = <%="form" + count %> method="get" action = "rep_UserInformation.jsp">
					<input type = "hidden" name = <%=id%>>
					<input type = "hidden" name = <%=flight_number%>>
					<label>Edit Seat: <input name = "seat"/></label>
	 				 <label>Edit Type: <input name = "class"/></label>
	  				<input type="submit" value="edit" onclick = <%="func" + count %>()/>
					</form>

					<script language = "JavaScript">
						function <%="func" + count %>(){
						<%
						session.setAttribute("id", id);
						session.setAttribute("ticket_flight", flight_number);
						%>
						}
						
					</script>
					<%
					count++;
				}
				

					
	} catch (Exception e) {
	out.print(e);
}
%>
			
</body>
</html>