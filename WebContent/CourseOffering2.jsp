<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Course Offering Form</title>
</head>
<body>
<h2>Course Offering Form</h2>
<p>Select one course from below</p>
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
	ResultSet rs1 = statement.executeQuery("SELECT * FROM \"Course\" JOIN \"Grade_Option\" ON \"Course\".go_id = \"Grade_Option\".go_id");
%>

<!-- HTML Code to create the entry form -->
<form action="CourseOffering3.jsp" method="get">
	<table border="1">
		<tr>
			<th>Course ID</th>
			<th>Min. Units</th>
			<th>Max. Units</th>
			<th>Lab work required</th>
			<th>Grade Option</th>
		</tr>
	<%-- Iteration Code --%>
	<%
		while(rs1.next()) {
	%>
		<tr>
			<td><input type="submit" value="<%=rs1.getString("course_id")%>" name="course_id"></td>
			<td><%=rs1.getInt("min_unit") %></td>
			<td><%=rs1.getInt("max_unit") %></td>
			<td><%=rs1.getBoolean("lab_work") %></td>
			<td><%=rs1.getString("option") %>
		</tr>
	<%
		}
	%>
	</table>
	<input type="hidden" value="<%=request.getParameter("dept") %>" name="dept_name">
</form>
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