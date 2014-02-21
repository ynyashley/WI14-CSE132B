<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Prerequisites Form for Course <%=request.getParameter("course_id") %></title>
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
	ResultSet rs1 = statement.executeQuery("SELECT * FROM \"Course\" JOIN \"Grade_Option\" ON \"Course\".go_id = \"Grade_Option\".go_id");
%>

<!-- HTML Code to create the entry form -->
<h2>Prerequisites Form for Course <%=request.getParameter("course_id") %></h2>
<form action="Prereq2.jsp" method="get">
	<table border="1">
		<tr>
			<th>Course ID</th>
			<th>Units</th>
			<th>Lab work required</th>
			<th>Grade Option</th>
		</tr>
	<%-- Iteration Code --%>
	<%
		while(rs1.next()) {
	%>
		<tr>
			<td><input type="submit" value="<%=rs1.getString("course_id")%>" name="prereq_id"></td>
			<td><%=rs1.getInt("unit") %></td>
			<td><%=rs1.getBoolean("lab_work") %></td>
			<td><%=rs1.getString("option") %>
		</tr>
	<%
		}
	%>
	</table>
	<input type="submit" value="No Prereqs" name="prereq_id">
	<input type="hidden" value="<%=request.getParameter("course_id") %>" name="course_id">
	<input type="hidden" value="<%=request.getParameter("unit") %>" name="unit">
	<input type="hidden" value="<%=request.getParameter("lab_work") %>" name="lab_work">
	<input type="hidden" value="<%=request.getParameter("grade_option") %>" name="grade_option">
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