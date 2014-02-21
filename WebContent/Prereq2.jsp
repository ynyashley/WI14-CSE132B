<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Class Information</title>
</head>
<body>
<%@ page language="java" import="java.sql.*" %>
<% try{
		Class.forName("org.postgresql.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection(
	   	"jdbc:postgresql://localhost:5432/cse132b","postgres", "YUNGp12594");
%>

<%-- Insert Code --%>
<%
		// begin transaction
		conn.setAutoCommit(false);
		
		// Create prepared statement and use it to INSERT the Class
		// attributes INTO the Course table.
		PreparedStatement pstmt = null;
		Statement statement = conn.createStatement();

		ResultSet rs1 = statement.executeQuery("SELECT * FROM \"Course\" WHERE course_id='"+ request.getParameter("course_id") + "'");
		if(!rs1.next()) {
			pstmt = conn.prepareStatement(
					"INSERT INTO \"Course\"(course_id, go_id, unit, lab_work) VALUES (?, ?, ?, ?)");
			pstmt.setString(1, request.getParameter("course_id"));
			pstmt.setInt(2, Integer.parseInt(request.getParameter("grade_option")));
			pstmt.setInt(3, Integer.parseInt(request.getParameter("unit")));
			pstmt.setBoolean(4, Boolean.parseBoolean(request.getParameter("lab_work")));
			
			pstmt.executeUpdate();
		}
		
		String prereq_id = request.getParameter("prereq_id");
		if(!prereq_id.equals("No Prereqs")) {
			pstmt = conn.prepareStatement(
				"INSERT INTO \"Course_Prereq\"(course_id, prereq_id) VALUES (?, ?)");
			pstmt.setString(1, request.getParameter("course_id"));
			pstmt.setString(2, request.getParameter("prereq_id"));
			pstmt.executeUpdate();
		}
		
		conn.commit();
		conn.setAutoCommit(true);
%>

<!-- HTML Code to create the entry form -->
<form action="Prereq.jsp" method="get">
	<input type="submit" value="Add Another Prerequisite">
	<input type="hidden" value="<%=request.getParameter("course_id") %>" name="course_id">
	<input type="hidden" value="true" name="course_inserted">
</form>
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