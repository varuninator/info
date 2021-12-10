<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Browse Flights</title>
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
			
			String str = "";
			
			String orderby = "base_price";
			String filter = "";
			out.print(session.getAttribute("search2"));
			out.print(session.getAttribute("round_trip"));
			if(request.getParameter("price_greater") != "" && request.getParameter("price_greater") != null){
				filter += " and base_price > " + request.getParameter("price_greater");
			}
			if(request.getParameter("price_less") != "" && request.getParameter("price_less") != null){
				filter += " and base_price < " + request.getParameter("price_less");
			}
			if(request.getParameter("take_off_before") != "" && request.getParameter("take_off_before") != null){
				filter += " and time(departure_time) < \"" + request.getParameter("take_off_before") +"\"";
			}
			if(request.getParameter("land_off_before") != "" && request.getParameter("land_off_before")!= null){
				filter += " and time(arrival_time) < \"" + request.getParameter("land_off_before") + "\"";
			}
			if(request.getParameter("sort_by") != null){
				if(request.getParameter("sort_by").equals("take-off time")){
					orderby = "departure_time";
				}
				if(request.getParameter("sort_by").equals("landing time")){
					orderby = "arrival_time";
				}
				if(request.getParameter("sort_by").equals("duration of flight")){
					orderby = "arrival_time-departure_time";
				}
			}
			
			if(request.getParameter("sort_by") == null && filter.equals("")){
				String sch2 = request.getParameter("search2");
				//String sch1 = request.getParameter("search");
			
				if(sch2 != null){
					session.setAttribute("search2", sch2);
				}
				
				String sch = request.getParameter("search");
				//String sch1 = request.getParameter("search");
			
				if(sch != null){
					session.setAttribute("search", sch);
					session.setAttribute("round_trip", "false");
					
				}else if(session.getAttribute("search2") != null){
					String temp = String.valueOf(session.getAttribute("search"));
					session.setAttribute("search", session.getAttribute("search2"));
					session.setAttribute("search2", temp);
					session.setAttribute("round_trip", "true");
					
				}
				
				String start = request.getParameter("airStart");

				if(start != null){
					session.setAttribute("Start", start);
				}
				String end = request.getParameter("airEnd");
				if(end != null){
					session.setAttribute("End", end);
				}
				if(session.getAttribute("round_trip") == "true"){
					String temp = String.valueOf(session.getAttribute("Start"));
					session.setAttribute("Start", session.getAttribute("End"));
					session.setAttribute("End", temp);
				}

			}
			
			

			//out.print(request.getParameter("button0"));
			//out.print("test");
			//out.print(session.getAttribute("selected_flight"));
			
			//out.print("You have selected the date " + sch + " do you want to book?");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			//ONE way Search
			
			if(request.getParameter("flexibility") != null){
				session.setAttribute("flex", "");
			}
			if((request.getParameter("flexibility") != null && request.getParameter("flexibility").equals("0")) || (session.getAttribute("flex") != null && String.valueOf(session.getAttribute("flex")).equals("0"))){
				out.print("Date: " + session.getAttribute("search"));
				session.setAttribute("flex", "0");
					if(session.getAttribute("Start") != "" && session.getAttribute("End") != ""){
						str = "SELECT * FROM otrs.flight join flys using( flight_number )  where departing_airport =\"" + session.getAttribute("Start") + "\" and arriving_airport = \"" + session.getAttribute("End") + "\" and date(departure_time) = \"" + session.getAttribute("search") + "\"" + filter + " order by " + orderby;
					}else if (session.getAttribute("Start") != ""){
						str = "SELECT * FROM otrs.flight join flys using( flight_number )  where departing_airport =\"" + session.getAttribute("Start") + "\" and date(departure_time) = \"" + session.getAttribute("search") + "\"" + filter + " order by " + orderby;
					}else if (session.getAttribute("End") != ""){
						str = "SELECT * FROM otrs.flight join flys using( flight_number )  where arriving_airport = \"" + session.getAttribute("End") + "\" and date(departure_time) = \"" + session.getAttribute("search") + "\"" + filter + " order by " + orderby;
					}else{
						str = "SELECT * FROM otrs.flight join flys using( flight_number )  where date(departure_time) = \"" + session.getAttribute("search") + "\"" + filter + " order by " + orderby;
					}
			}
			else if((request.getParameter("flexibility") != null && request.getParameter("flexibility").equals("1")) || String.valueOf(session.getAttribute("flex")).equals("1")){
				out.print("Date: " + session.getAttribute("search"));
				session.setAttribute("flex", "1");
					if(session.getAttribute("Start") != "" && session.getAttribute("End") != ""){
						str = "SELECT * FROM otrs.flight join flys using( flight_number )  where departing_airport =\"" 
							+ session.getAttribute("Start") + 
							"\" and arriving_airport = \"" 
							+ session.getAttribute("End") + 
							"\" and (date(departure_time) = \"" 
							+ session.getAttribute("search") + 
							"\" or date(DATE_ADD(departure_time, interval 1 day)) = \"" 
							+ session.getAttribute("search") + 
							"\" or date(DATE_ADD(departure_time, interval -1 day)) = \"" 
							+ session.getAttribute("search") + "\")"
							+ filter + " order by " + orderby;
					}else if (session.getAttribute("Start") != ""){
						str = "SELECT * FROM otrs.flight join flys using( flight_number )  where departing_airport =\""
							+ session.getAttribute("Start") + 
							"\" and (date(departure_time) = \"" 
							+ session.getAttribute("search") + 
							"\" or date(DATE_ADD(departure_time, interval 1 day)) = \"" 
							+ session.getAttribute("search") + 
							"\" or date(DATE_ADD(departure_time, interval -1 day)) = \"" 
							+ session.getAttribute("search") + "\")"
							+ filter + " order by " + orderby;
					}else if (session.getAttribute("End") != ""){
						str = "SELECT * FROM otrs.flight join flys using( flight_number )  where arriving_airport = \"" 
							+ session.getAttribute("End") + 
							"\" and (date(departure_time) = \"" 
							+ session.getAttribute("search") + 
							"\" or date(DATE_ADD(departure_time, interval 1 day)) = \"" 
							+ session.getAttribute("search") + 
							"\" or date(DATE_ADD(departure_time, interval -1 day)) = \"" 
							+ session.getAttribute("search") + "\")"
							+ filter + " order by " + orderby;
					}else{	
						str = "SELECT * FROM otrs.flight join flys using( flight_number )  where (date(departure_time) = \""
							+ session.getAttribute("search") + 
							"\" or date(DATE_ADD(departure_time, interval 1 day)) = \"" 
							+ session.getAttribute("search") + 
							"\"or date(DATE_ADD(departure_time, interval -1 day)) = \"" 
							+ session.getAttribute("search") + "\")" 
							+ filter + " order by " + orderby;
						
					}
			}
			else if((request.getParameter("flexibility") != null && request.getParameter("flexibility").equals("2")) || String.valueOf(session.getAttribute("flex")).equals("2")){
				out.print("Date: " + session.getAttribute("search"));
				session.setAttribute("flex", "2");
				if(session.getAttribute("Start") != "" && session.getAttribute("End") != ""){
					str = "SELECT * FROM otrs.flight join flys using( flight_number )  where departing_airport =\"" 
						+ session.getAttribute("Start") + 
						"\" and arriving_airport = \"" 
						+ session.getAttribute("End") + 
						"\" and (date(departure_time) = \"" 
						+ session.getAttribute("search") +
						"\" or date(DATE_ADD(departure_time, interval 2 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -2 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval 1 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -1 day)) = \"" 
						+ session.getAttribute("search") + "\")"
						+ filter + " order by " + orderby;
				}else if (session.getAttribute("Start") != ""){
					str = "SELECT * FROM otrs.flight join flys using( flight_number )  where departing_airport =\""
						+ session.getAttribute("Start") + 
						"\" and (date(departure_time) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval 2 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -2 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval 1 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -1 day)) = \"" 
						+ session.getAttribute("search") + "\")"
						+ filter + " order by " + orderby;
				}else if (session.getAttribute("End") != ""){
					str = "SELECT * FROM otrs.flight join flys using( flight_number )  where arriving_airport = \"" 
						+ session.getAttribute("End") + 
						"\" and (date(departure_time) = \"" 
						+ session.getAttribute("search") +
						"\" or date(DATE_ADD(departure_time, interval 2 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -2 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval 1 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -1 day)) = \"" 
						+ session.getAttribute("search") + "\")"
						+ filter + " order by " + orderby;
				}else{	
					str = "SELECT * FROM otrs.flight join flys using( flight_number )  where (date(departure_time) = \""
						+ session.getAttribute("search") +
						"\" or date(DATE_ADD(departure_time, interval 2 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -2 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval 1 day)) = \"" 
						+ session.getAttribute("search") + 
						"\"or date(DATE_ADD(departure_time, interval -1 day)) = \"" 
						+ session.getAttribute("search") + "\")" 
						+ filter + " order by " + orderby;
					
				}
		}
		else if((request.getParameter("flexibility") != null && request.getParameter("flexibility").equals("3")) || String.valueOf(session.getAttribute("flex")).equals("3")){
			out.print("Date: " + session.getAttribute("search"));
			session.setAttribute("flex", "3");
				if(session.getAttribute("Start") != "" && session.getAttribute("End") != ""){
					str = "SELECT * FROM otrs.flight join flys using( flight_number )  where departing_airport =\"" 
						+ session.getAttribute("Start") + 
						"\" and arriving_airport = \"" 
						+ session.getAttribute("End") + 
						"\" and (date(departure_time) = \"" 
						+ session.getAttribute("search") +
						"\" or date(DATE_ADD(departure_time, interval 3 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -3 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval 2 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -2 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval 1 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -1 day)) = \"" 
						+ session.getAttribute("search") + "\")"
						+ filter + " order by " + orderby;
				}else if (session.getAttribute("Start") != ""){
					str = "SELECT * FROM otrs.flight join flys using( flight_number )  where departing_airport =\""
						+ session.getAttribute("Start") + 
						"\" and (date(departure_time) = \"" 
						+ session.getAttribute("search") +
						"\" or date(DATE_ADD(departure_time, interval 3 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -3 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval 2 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -2 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval 1 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -1 day)) = \"" 
						+ session.getAttribute("search") + "\")"
						+ filter + " order by " + orderby;
				}else if (session.getAttribute("End") != ""){
					str = "SELECT * FROM otrs.flight join flys using( flight_number )  where arriving_airport = \"" 
						+ session.getAttribute("End") + 
						"\" and (date(departure_time) = \"" 
						+ session.getAttribute("search") +
						"\" or date(DATE_ADD(departure_time, interval 3 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -3 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval 2 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -2 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval 1 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -1 day)) = \"" 
						+ session.getAttribute("search") + "\")"
						+ filter + " order by " + orderby;
				}else{	
					str = "SELECT * FROM otrs.flight join flys using( flight_number )  where (date(departure_time) = \""
						+ session.getAttribute("search") +
						"\" or date(DATE_ADD(departure_time, interval 3 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -3 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval 2 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval -2 day)) = \"" 
						+ session.getAttribute("search") + 
						"\" or date(DATE_ADD(departure_time, interval 1 day)) = \"" 
						+ session.getAttribute("search") + 
						"\"or date(DATE_ADD(departure_time, interval -1 day)) = \"" 
						+ session.getAttribute("search") + "\")" 
						+ filter + " order by " + orderby;
					
				}
		}

			ResultSet result = stmt.executeQuery(str);
			int count = 0;
			
			%>
			<form name = userForm method = get action = "Browse.jsp">
				<label>Prices greater than:  <input name = "price_greater"/></label>
				<label>Prices less than   <input name = "price_less"/></label>
				<label>Take off before:   <input name = "take_off_before"/></label>
				<label>Land before:   <input name = "land_off_before"/></label>
				<input type="submit" value="Filter" />
			</form>
			
			
			<form name = order method = get action = "Browse.jsp">
				<select name="sort_by">
					<option>price</option>
					<option>take-off time</option>
					<option>landing time</option>
					<option>duration of flight</option>
			 	</select> 
			 	<input type="submit" value="Sort" />
			</form>
			<br>
			<%
			while(result.next()){
			if(request.getParameter("oneway") == "false"){
				if(session.getAttribute("round_trip") == "false"){
					if(result.getTimestamp("arrival_time").after(Timestamp.valueOf(String.valueOf(session.getAttribute("search2"))+" 00:00:00"))){
						continue;
					}
				} 
				if(session.getAttribute("round_trip") == "true"){
					if(result.getTimestamp("departure_time").before(Timestamp.valueOf(String.valueOf(session.getAttribute("search2"))+" 23:59:59"))){
						continue;
					}
				} 
			}
				
				//Timestamp depTime = result.getTimestamp("departure_time");
				//session.setAttribute("depTime", depTime);
				
				out.print("Flight number:" + result.getInt("flight_number") + ", Airline: " + result.getString("airline_id") + ", Start: " + result.getString("departing_airport") + ", End: " + result.getString("arriving_airport") + ", Take-off Time: " + result.getTimestamp("departure_time") + ", Arrival Time: " + result.getTimestamp("arrival_time")+ ", Price: $" + result.getInt("base_price"));
				int flight_num = result.getInt("flight_number");
				String depTime = String.valueOf(result.getTimestamp("departure_time"));
				depTime = depTime.substring(0, 10) + depTime.substring(11);
				//out.print("<br/>" + depTime);
				
				%>
				<form name = <%="form" + count %> method="get" action = "Book.jsp">
				<input type = "hidden" name = <%=flight_num %>>
				<input type = "hidden" name = <%=depTime %>>
  				<input type="submit" value="Book First Class" onclick = <%="func" + count %>()/>
				</form>
				
				<form name = <%="form" + count %> method="get" action = "BookSecond.jsp">
				<input type = "hidden" name = <%=flight_num %>>
				<input type = "hidden" name = <%=depTime %>>
  				<input type="submit" value="Book Business Class" onclick = <%="func" + count %>()/>
				</form>
				
				<form name = <%="form" + count %> method="get" action = "BookThird.jsp">
				<input type = "hidden" name = <%=flight_num %>>
				<input type = "hidden" name = <%=depTime %>>
  				<input type="submit" value="Book Economy Class" onclick = <%="func" + count %>()/>
				</form>
				
				<form name = <%="form" + count %> method="get" action = "Account.jsp">
				<input type = "hidden" name = <%=flight_num %>>
				<input type = "hidden" name = <%=depTime %>>
  				<input type="submit" value="Join Waitlist" onclick = <%="func" + count %>()/>
				</form>
				<br>
				<script language = "JavaScript">
					function <%="func" + count %>(){
						document.<%="form" + count %>.<%=flight_num%>.value = "yes";
						document.<%="form" + count %>.<%=depTime%>.value = "yes";
						<%="form" + count %>.submit();
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