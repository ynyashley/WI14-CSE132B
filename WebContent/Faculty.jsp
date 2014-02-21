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
<%-- Selection Code --%>
<% 
	Statement statement = conn.createStatement();
	ResultSet rs1 = statement.executeQuery("SELECT * FROM \"Department\"");
%>

<!-- HTML Code to create the entry form -->
<h3>Enter new faculty information using the form below:</h3>
<form action="Faculty2.jsp" method="get">
	<input type="hidden" value="insert" name="action">
	Name: <input type="text" name="name"><br>
	Title: <input type="text" name="title"><br>
	Select a department from below:
	<table border="1">
	<tr>
		<th>Department Name</th>
	</tr>
	<%-- Iteration Code --%>
	<%
		while(rs1.next()) {
	%>
		<tr>
			<td><input type="submit" value="<%=rs1.getInt("department_id") %>" name="department_id"></td>
			<td><%=rs1.getString("name")%></td>
		</tr>
	<%
		}
	%>
</table>
<input type="submit" value="Submit">
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