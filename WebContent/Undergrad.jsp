<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Course Information</title>
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
	ResultSet rs1 = statement.executeQuery("SELECT * FROM \"College\"");
%>

<!-- HTML Code to create the entry form -->
<form action="Undergrad2.jsp" method="get">
	<input type="hidden" value="insert" name="action">
	Student ID: <input type="text" name="student_id"><br>
	Major: <input type="text" name="major"><br>
	Minor: <input type="text" name="minor"><br>
	Choose your college from the chart below:
	<table border="1">
		<tr>
			<th>College ID</th>
			<th>College Name</th>
		</tr>
	<%-- Iteration Code --%>
	<%
		while(rs1.next()) {
	%>
		<tr>
			<td><input type="submit" value="<%=rs1.getInt("college_id")%>" name="college_id"></td>
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