<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Meetings (Lecture/Discussion/Review Sessions) Entry Form</title>
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
	ResultSet rs1 = statement.executeQuery("SELECT * FROM \"Section\" JOIN \"Faculty\" ON \"Section\".faculty_id=\"Faculty\".faculty_id");
%>
<table border="1">
	<tr>
		<th>Section ID</th>
		<th>Faculty Name</th>
		<th>Enrollment Limit</th>
	</tr>
	<%-- Iteration Code --%>
	<%
		while(rs1.next()) {
	%>
		<tr>
			<td><%=rs1.getInt("section_id")%></td>
			<td><%=rs1.getString("name") %></td>
			<td><%=rs1.getInt("enrollment_limit") %></td>
		</tr>
	<%
		}
	%>
</table>

<!-- HTML Code to create the entry form -->
<form action="Meeting2.jsp" method="get">
	<input type="hidden" value="insert" name="action">
	Creating meeting for section id (refer the chart above): <input type="text" name="section"><br>
	Mandatory discussion:
	<select name="mandatory_discussion">
		<option value=1>yes</option>
		<option value=0>no</option>
	</select><br>
	Day of Week: <input type="text" name="day"><br>
	Time(00:00:00): <input type="time" name="time"><br>
	Weekly:
	<select name="weekly">
		<option value=1>yes</option>
		<option value=0>no</option>
	</select><br>
	Type: 
	<select name="type">
		<option value="Lecture">Lecture</option>
		<option value="Discussion">Discussion</option>
		<option value="Review Session">Review Session</option>
	</select><br>
<input type="submit" value="Submit">
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