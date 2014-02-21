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
			"INSERT INTO \"Faculty\"(name, title, department_id) VALUES (?, ?, ?)");
	pstmt.setString(1, request.getParameter("name"));
	pstmt.setString(2, request.getParameter("title"));
	pstmt.setInt(3, Integer.parseInt(request.getParameter("department_id")));
			
	pstmt.executeUpdate();
		
	conn.commit();
	conn.setAutoCommit(true);
%>

<!-- HTML Code to create the entry form -->
<p>The information for <%=request.getParameter("name") %> has been recorded.</p>
<p>Click <a href="/CSE132B/Faculty.jsp">here</a> to go back</p>
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