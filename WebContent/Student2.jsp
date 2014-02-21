<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Course Offerings Form</title>
</head>
<body>
<%@ page language="java" import="java.sql.*" %>
<% try{
		Class.forName("org.postgresql.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection(
	   	"jdbc:postgresql://localhost:5432/cse132b","postgres", "YUNGp12594");
%>

<%-- Selection Code --%>
<% 
	// begin transaction
	conn.setAutoCommit(false);
	PreparedStatement pstmt = conn.prepareStatement(
			"INSERT INTO \"Student\"(student_id, residency_id, first_name, middle_name, last_name, social_security, start_date, end_date, enrollment_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
	pstmt.setString(1, request.getParameter("student_id"));
	pstmt.setInt(2, Integer.parseInt(request.getParameter("residency_id")));
	pstmt.setString(3, request.getParameter("first_name"));
	pstmt.setString(4, request.getParameter("middle_name"));
	pstmt.setString(5, request.getParameter("last_name"));
	pstmt.setString(6, request.getParameter("social_security"));
	pstmt.setDate(7, Date.valueOf(request.getParameter("start_date")));
	pstmt.setDate(8, Date.valueOf(request.getParameter("end_date")));
	pstmt.setBoolean(9, Boolean.parseBoolean(request.getParameter("enrollment_status")));
			
	pstmt.executeUpdate();
	
	conn.commit();
	conn.setAutoCommit(true);
%>

<!-- HTML Code to create the entry form -->
<p>The information for <%=request.getParameter("first_name") %> <%=request.getParameter("last_name") %> has been recorded.</p>
<p>Click <a href="/CSE132B/Student.jsp">here</a> to go back or: <br>
<a href="/CSE132B/Probation.jsp?student=<%=request.getParameter("student_id") %>">Enter probation info for this student</a>
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