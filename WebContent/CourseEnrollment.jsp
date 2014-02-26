<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

<%-- Select Courses to display on the page for selection --%>
<% 
	Statement statement = conn.createStatement();
	int section_id = 0;
	String student_id = request.getParameter("student_id");
	ResultSet rs1 = statement.executeQuery("SELECT * FROM \"Section\" JOIN \"Faculty\" ON \"Faculty\".faculty_id = \"Section\".faculty_id");
%>

<!-- Create an HTML table to format the results -->
<form action="CourseEnrollment2.jsp" method="get">
	<input type="hidden" value="insert" name="action">
	Student ID: <input type="text" name="student_id">
	<table border="1">
		<tr>
			<th>Section ID</th>
			<th>Faculty Name</th>
			<th>Faculty Title</th>
			<th>Enrollment Limit</th>
		</tr>
	<%-- Iteration Code --%>
	<%
		while(rs1.next()) {
			section_id = rs1.getInt("section_id");
	%>
		<tr>
			<td><input type="submit" value="<%=section_id%>" name="section_id"></td>
			<td><%=rs1.getString("name") %></td>
			<td><%=rs1.getString("title") %></td>
			<td><%=rs1.getInt("enrollment_limit") %></td>
		</tr>
	<%
		}
	%>
	</table>
	<input type="hidden" value="<%=section_id %>" name="section_id">
	<input type="hidden" value="<%=student_id %>" name="student_id">
</form>

<%-- Close Connection Code --%>
<%
	// Close the ResultSet
	//rs1.close();
	statement.close();
		
	conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>