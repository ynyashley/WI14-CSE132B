<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Meetings (Lecture/Discussion/Review Sections) Entry Form</title>
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
	int meeting_id = 0;
	Statement statement = conn.createStatement();
	String section = request.getParameter("section");
	String action = request.getParameter("action");
	

	// Check if it's an insertion
	if(action != null && action.equals("insert")) {
		// begin transaction
		conn.setAutoCommit(false);
		
		// Create prepared statement and use it to INSERT the Class
		// attributes INTO the Course table.
 		
		PreparedStatement pstmt = conn.prepareStatement("INSERT INTO \"Meeting\"(mandatory_discussion, day, time, weekly, type) VALUES (?, ?, ?, ?, ?) returning meeting_id");
		pstmt.setBoolean(1, Boolean.parseBoolean(request.getParameter("mandatory_discussion")));
		pstmt.setString(2, request.getParameter("day"));
		pstmt.setTime(3, Time.valueOf(request.getParameter("time")));
		pstmt.setBoolean(4, Boolean.parseBoolean(request.getParameter("weekly")));
		pstmt.setString(5, request.getParameter("type"));
		
		ResultSet rs1 = pstmt.executeQuery();
		rs1.next();
        meeting_id = rs1.getInt("meeting_id");
		
		pstmt = conn.prepareStatement(
				"INSERT INTO \"Section_Meeting\"(section_id, meeting_id) VALUES (?, ?)");
			pstmt.setInt(1, Integer.parseInt(section));
			pstmt.setInt(2, meeting_id);
			
		pstmt.executeUpdate();
		
		conn.commit();
		conn.setAutoCommit(true);
	}
%>

<!-- HTML Code to create the entry form -->
Your meeting has been scheduled and submitted.
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