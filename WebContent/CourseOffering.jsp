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
	ResultSet rs1 = statement.executeQuery("SELECT name FROM \"Department\"");
%>

<!-- HTML Code to create the entry form -->
<h2>Course Offering Form</h2>
<h3>Select the department from which the course is offered:</h3>
<form action="CourseOffering2.jsp" method="get">
	<table border="1">
		<tr>
			<th>Department Name</th>
		</tr>
	<%-- Iteration Code --%>
	<%
		while(rs1.next()) {
	%>
		<tr>
			<td><input type="submit" value="<%=rs1.getString("name")%>" name="dept"></td>
		</tr>
	<%
		}
	%>
	</table>
</form>
<p>or, create a new department from <a href="/CSE132B/New_Department.jsp">here</a></p>
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