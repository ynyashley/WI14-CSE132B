<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Club</title>
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
	ResultSet rs1 = statement.executeQuery("SELECT * FROM \"Club\"");
%>
<form action="Club2.jsp" method="get">
	Your student ID: <input type="text" name="student_id">
	<table border="1">
		<tr>
			<th>Club ID</th>
			<th>Club Name</th>
			<th>Club Type</th>
		</tr>
	<%-- Iteration Code --%>
	<%
		while(rs1.next()) {
	%>
		<tr>
			<td><input type="submit" value="<%=rs1.getInt("club_id")%>" name="club_id"></td>
			<td><%=rs1.getString("name") %></td>
			<td><%=rs1.getString("type") %>
		</tr>
	<%
		}
	%>
	</table>
	<input type="hidden" value="<%=rs1.getString("name") %>" name="club_name">
</form>
<%
	conn.close();
  } catch(Exception e) {
		e.printStackTrace();
  }
%>

</body>
</html>