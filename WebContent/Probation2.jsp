<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Probation</title>
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
	int probation_id = 0;
	String student_id = request.getParameter("student_id");
	String action = request.getParameter("action");
	// Check if it's an insertion
	if(action != null && action.equals("insert")) {
		// begin transaction
		conn.setAutoCommit(false);
		
		// Create prepared statement and use it to INSERT the Class
		// attributes INTO the Course table.
		
		PreparedStatement pstmt = conn.prepareStatement(
			"INSERT INTO \"Probation\"(reason) VALUES (?) returning probation_id");
		pstmt.setString(1, request.getParameter("reason"));

		
		rs = pstmt.executeQuery();
		rs.next();
		probation_id = rs.getInt("probation_id");
		
		pstmt = conn.prepareStatement(
				"INSERT INTO \"Student_Probation\"(student_id, probation_id) VALUES (?, ?)");
		pstmt.setString(1, student_id);
		pstmt.setInt(2, probation_id);
			
		pstmt.executeUpdate();
		
		conn.commit();
		conn.setAutoCommit(true);
	}
	%>
Probation info for student with student ID <%=student_id %> has been submitted.
<%
	conn.close();
  } catch(Exception e) {
		e.printStackTrace();
  }
%>

</body>
</html>