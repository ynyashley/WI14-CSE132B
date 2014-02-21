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
		int section_id = 0;
		// begin transaction
		conn.setAutoCommit(false);
		
		// Create prepared statement and use it to INSERT the Class
		// attributes INTO the Course table.
		Statement statement = conn.createStatement();
		System.out.println("Test 3 "+request.getParameter("class_id"));
		System.out.println(request.getParameter("faculty"));
		ResultSet rs1 = statement.executeQuery("SELECT faculty_id FROM \"Faculty\" WHERE name='"+ request.getParameter("faculty") + "'");
		ResultSet rs2;
		
		rs1.next();
		int faculty_id = rs1.getInt("faculty_id");
		
		PreparedStatement pstmt = conn.prepareStatement("INSERT INTO \"Section\"(faculty_id, enrollment_limit) VALUES(?, ?) returning section_id");
		pstmt.setInt(1, faculty_id);
		pstmt.setInt(2, Integer.parseInt(request.getParameter("enrollment_limit")));
		rs2 = pstmt.executeQuery();
		rs2.next();
		section_id = rs2.getInt("section_id");
		
		pstmt = conn.prepareStatement(
				"INSERT INTO \"Class_Section\"(class_id, section_id) VALUES (?, ?)");
		pstmt.setInt(1, Integer.parseInt(request.getParameter("class_id")));
		pstmt.setInt(2, section_id);
		
		pstmt.executeUpdate();
		
		conn.commit();
		conn.setAutoCommit(true);
		
%>

<!-- HTML Code to create the entry form -->
<form action="Class3.jsp" method="get">
	<input type="submit" value="Add Another Section">
	<input type="hidden" value="<%=request.getParameter("course_id") %>" name="course_id">
	<input type="hidden" value="<%=request.getParameter("class_id") %>" name="class_id">
	<input type="hidden" value="<%=request.getParameter("title") %>" name="title">
	<input type="hidden" value="<%=request.getParameter("quarter") %>" name="quarter">
	<input type="hidden" value="<%=request.getParameter("year") %>" name="year">
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