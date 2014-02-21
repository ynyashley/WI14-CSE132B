<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Club</title>
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
	String action = request.getParameter("action");
	// Check if it's an insertion
	if(action != null && action.equals("insert")) {
		// begin transaction
		conn.setAutoCommit(false);
		
		// Create prepared statement and use it to INSERT the Class
		// attributes INTO the Course table.
		
		PreparedStatement pstmt = conn.prepareStatement(
			"INSERT INTO \"Club\"(name, type, year_of_establishment) VALUES (?, ?, ?)");
		pstmt.setString(1, request.getParameter("name"));
		pstmt.setString(2, request.getParameter("type"));
		pstmt.setInt(3, Integer.parseInt(request.getParameter("year_of_establishment")));
		
		pstmt.executeUpdate();
		
		conn.commit();
		conn.setAutoCommit(true);
	}
%>
Your new club has been successfully registered.
<%
	conn.close();
  } catch(Exception e) {
		e.printStackTrace();
  }
%>

</body>
</html>