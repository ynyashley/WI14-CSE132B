<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Meeting</title>
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
	//ResultSet rs1 = statement.executeQuery("SELECT * FROM \"Section\" JOIN \"Faculty\" ON \"Section\".faculty_id=\"Faculty\".faculty_id");
	ResultSet rs1 = statement.executeQuery("SELECT * FROM \"Class_Section\" JOIN \"Class\" ON \"Class_Section\".class_id=\"Class\".class_id");
	
%>
Please provide information about the courses you took:
<form action="PastClasses2.jsp" method="get">
	<table border="1">
		<tr>
			<th>Section ID</th>
			<th>Title</th>
			<th>Quarter</th>
			<th>Year</th>
		</tr>
		<%-- Iteration Code --%>
		<%
			while(rs1.next()) {
		%>
			<tr>
				<td><%=rs1.getInt("section_id")%></td>
				<td><%=rs1.getString("title") %></td>
				<td><%=rs1.getString("quarter") %></td>
				<td><%=rs1.getInt("year") %></td>
			</tr>
		<%
			}
		%>
	</table>
	Your student ID: <input type="text" name="student_id"><br>
	Grade received: <input type="text" name="grade"><br>
	Section ID(refer to the column "Section ID" from above):<input type="text" name="section_id"><br>
	<input type="submit" name="Submit">
</form>
<%-- Close Connection Code --%>
<%
	conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>