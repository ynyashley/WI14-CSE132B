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
	ResultSet rs1 = statement.executeQuery("SELECT * FROM \"Course\" JOIN \"Grade_Option\" ON \"Course\".go_id = \"Grade_Option\".go_id");
%>

<!-- Create an HTML table to format the results -->
<form action="Class2.jsp" method="get">
	<input type="hidden" value="insert" name="action">
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
			<td><input type="submit" value="<%=rs1.getString("course_id")%>" name="course_id"></td>
			<td><%=rs1.getInt("unit") %></td>
			<td><%=rs1.getBoolean("lab_work") %></td>
			<td><%=rs1.getString("option") %>
		</tr>
	<%
		}
	%>
	</table>
</form>

<%-- Close Connection Code --%>
<%
	// Close the ResultSet
	rs1.close();
	//rs2.close();
	statement.close();
		
	conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>