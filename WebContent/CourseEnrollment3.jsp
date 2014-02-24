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
	String student_id = request.getParameter("student_id");
	int section_id = Integer.parseInt(request.getParameter("section_id"));
	int unit = Integer.parseInt(request.getParameter("unit"));

	// begin transaction
	conn.setAutoCommit(false);
	
	PreparedStatement pstmt = conn.prepareStatement(
			"INSERT INTO \"Student_Section\"(student_id, section_id, unit) VALUES (?, ?, ?)");
	pstmt.setString(1, student_id);
	pstmt.setInt(2, section_id);
	pstmt.setInt(3, unit);
	
	pstmt.executeUpdate();
	
	conn.commit();
	conn.setAutoCommit(true);
%>
You have successfully enrolled in section <%=section_id %>.

<%-- Close Connection Code --%>
<%
	conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>