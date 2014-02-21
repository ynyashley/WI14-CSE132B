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
		
		PreparedStatement pstmt = conn.prepareStatement(
				"INSERT INTO \"Student_Section\"(student_id, section_id) VALUES (?, ?)");
		pstmt.setString(1, request.getParameter("student_id"));
		pstmt.setInt(2, Integer.parseInt(request.getParameter("section_id")));
		
		pstmt.executeUpdate();
		
		conn.commit();
		conn.setAutoCommit(true);
		
%>

<!-- HTML Code to create the entry form -->
You have successfully enrolled in section <%=request.getParameter("section_id") %>.
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