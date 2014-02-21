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
	ResultSet rs = null;
	int class_id = 0;
	String course_id = request.getParameter("course_id");
	String action = request.getParameter("action");

	// begin transaction
	conn.setAutoCommit(false);
	
	// Create prepared statement and use it to INSERT the Class
	// attributes INTO the Course table.
	
	PreparedStatement pstmt = conn.prepareStatement(
		"INSERT INTO \"Class\"(title, year, quarter) VALUES (?, ?, ?) returning class_id");
	pstmt.setString(1, request.getParameter("title"));
	pstmt.setInt(2, Integer.parseInt(request.getParameter("year")));
	pstmt.setString(3, request.getParameter("quarter"));
	
	rs = pstmt.executeQuery();
	rs.next();
	class_id = rs.getInt("class_id");
	System.out.println("class_id " + class_id);
	
	pstmt = conn.prepareStatement(
			"INSERT INTO \"Course_Class\"(course_id, class_id) VALUES (?, ?)");
	pstmt.setString(1, course_id);
	pstmt.setInt(2, class_id);
		
	pstmt.executeUpdate();
	
	conn.commit();
	conn.setAutoCommit(true);
%>
<%
	Statement statement = conn.createStatement();
	ResultSet rs3 = statement.executeQuery("SELECT name FROM \"Faculty\"");
%>

<!-- HTML Code to create the entry form -->
<h3>Enter the following information for your class section:</h3>
<form action="Class4.jsp" method="get">
	Enrollment Limit:
	<input type="text" name="enrollment_limit"><br>
	<table border="1">
		<tr>
			<th>Faculty Name</th>
		</tr>
	<%-- Iteration Code --%>
	<%
		while(rs3.next()) {
	%>
		<tr>
			<td><input type="submit" value="<%=rs3.getString("name")%>" name="faculty"></td>
		</tr>
	<%
		}
	%>
	</table>
	<input type="submit" value="Add Another Section">
	<input type="hidden" value="<%=class_id %>" name="class_id">
	<input type="hidden" value="<%=course_id %>" name="course_id">
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