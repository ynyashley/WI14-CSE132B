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
	Statement statement = conn.createStatement();
	ResultSet rs1 = statement.executeQuery("SELECT department_id FROM \"Department\" WHERE name='"+ request.getParameter("dept_name")+ "'");
	rs1.next();
	
	// begin transaction
	conn.setAutoCommit(false);
	PreparedStatement pstmt = conn.prepareStatement(
			"INSERT INTO \"Department_Course\"(department_id, course_id) VALUES (?, ?)");
	pstmt.setInt(1, rs1.getInt("department_id"));
	pstmt.setString(2, request.getParameter("course_id"));
			
	pstmt.executeUpdate();
		
	conn.commit();
	conn.setAutoCommit(true);
%>

<!-- HTML Code to create the entry form -->
<p>The course offering for <%=request.getParameter("dept_name") %> Department has been recorded.</p>
<p>Click <a href="/CSE132B/CourseOffering.jsp">here</a> to go back</p>
<!-- End HTML Code for entry form -->

<%-- Close Connection Code --%>
<%
	rs1.close();
	conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>