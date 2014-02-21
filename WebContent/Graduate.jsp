<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Graduate Student Entry Form</title>
</head>
<body>
<%@ page language="java" import="java.sql.*" %>
<% try{
		Class.forName("org.postgresql.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection(
	   	"jdbc:postgresql://localhost:5432/cse132b","postgres", "YUNGp12594");
%>
<% 
	Statement statement = conn.createStatement();
	ResultSet rs1 = statement.executeQuery("SELECT * FROM \"Department\"");
%>

<!-- HTML Code to create the entry form -->
<form action="Graduate2.jsp" method="get">
	<input type="hidden" value="insert" name="action">
	Student ID: <input type="text" name="student_id"><br>
	Graduate Program:
	<select name="gp_id">
		<option value="1">MS</option>
		<option value="2">BS</option>
		<option value="3">BS/MS</option>
	</select><br>
	Choose your department from the chart below:
	<table border="1">
		<tr>
			<th>Department ID</th>
			<th>Department Name</th>
		</tr>
	<%-- Iteration Code --%>
	<%
		while(rs1.next()) {
	%>
		<tr>
			<td><input type="submit" value="<%=rs1.getInt("department_id")%>" name="dept_id"></td>
			<td><%=rs1.getString("name") %></td>
		</tr>
	<%
		}
	%>
	</table>
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