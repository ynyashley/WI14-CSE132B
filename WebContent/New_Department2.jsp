<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New Department Form</title>
</head>
<body>
<h2>New Department Form</h2>
<%@ page language="java" import="java.sql.*" %>
<% try{
		Class.forName("org.postgresql.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection(
	   	"jdbc:postgresql://localhost:5432/cse132b","postgres", "YUNGp12594");
%>

<%-- Insert Code --%>
<%
	String action = request.getParameter("action");
	if(action != null && action.equals("insert")) {
		// begin transaction
		conn.setAutoCommit(false);
		
		// Create prepared statement and use it to INSERT the Class
		// attributes INTO the Course table.
		PreparedStatement pstmt = conn.prepareStatement(
			"INSERT INTO \"Department\"(name) VALUES (?)");
		pstmt.setString(1, request.getParameter("department_name"));
			
		pstmt.executeUpdate();
		
		conn.commit();
		conn.setAutoCommit(true);
	}
%>

<!-- HTML Code to create the entry form -->
<p>Your new department has been recorded. Click <a href="/CSE132B/New_Department.jsp">here</a> to go back</p>
<!-- End HTML Code for entry form -->
<%-- Close Connection Code --%>
<%
	conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>