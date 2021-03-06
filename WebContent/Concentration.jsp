<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Concentration</title>
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
	int concentration_id = 0;
	String action = request.getParameter("action");
	// Check if it's an insertion
	if(action != null && action.equals("insert")) {
		// begin transaction
		conn.setAutoCommit(false);
		
		// Create prepared statement and use it to INSERT the Class
		// attributes INTO the Course table.
		
		PreparedStatement pstmt = conn.prepareStatement(
			"INSERT INTO \"Concentration\"(name) VALUES (?)");
		pstmt.setString(1, request.getParameter("name"));

		pstmt.executeUpdate();
		
		conn.commit();
		conn.setAutoCommit(true);
	}
%>
<h3>Enter the information about your new concentration below:</h3>
<form action="Concentration.jsp" method="get">
	<input type="hidden" value="insert" name="action">

	Concentration Name: <input type="text" name="name"><br>
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