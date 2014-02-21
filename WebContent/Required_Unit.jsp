<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Required Unit</title>
</head>
<body>
<%@ page language="java" import="java.sql.*" %>
  <% try{
	Class.forName("org.postgresql.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection(
	   "jdbc:postgresql://localhost:5432/cse132b","postgres", "YUNGp12594");
  %>
  <%
	ResultSet rs = null;
	int ru_id = 0;
	String degree = request.getParameter("degree");
	String action = request.getParameter("action");
	// Check if it's an insertion
	if(action != null && action.equals("insert")) {
		// begin transaction
		conn.setAutoCommit(false);
		
		// Create prepared statement and use it to INSERT the Class
		// attributes INTO the Course table.
		
		PreparedStatement pstmt = conn.prepareStatement("INSERT INTO \"Required_Unit\"(type, unit) VALUES (?, ?)");
		pstmt.setString(1, request.getParameter("type"));
		pstmt.setInt(2, Integer.parseInt(request.getParameter("unit")));
			
		pstmt.executeUpdate();
		
		conn.commit();
		conn.setAutoCommit(true);
	}
	%>
<h3>Enter information about a new required unit type below, for example if your degree <br>
requires 80 Upper Div Units then the type and unit will be entered in the format in the parenthesis. <br></h3>
<form action="Required_Unit.jsp" method="get">
	<input type="hidden" value="insert" name="action">
	Type of Required Unit (e.g. upper division): <input type="text" name="type"><br>
	Unit (e.g. 80): <input type="text" name="unit"><br>
	<input type="submit" value="Submit">
</form>
<%
	conn.close();
  } catch(Exception e) {
		e.printStackTrace();
  }
%>

</body>
</html>