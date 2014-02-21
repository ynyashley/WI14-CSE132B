<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Thesis Committee Submission</title>
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
	ResultSet rs1 = statement.executeQuery("SELECT * FROM \"Faculty\"");
%>
<table border="1">
	<tr>
		<th>Faculty ID</th>
		<th>Faculty Name</th>
	</tr>
	<%-- Iteration Code --%>
	<%
		while(rs1.next()) {
	%>
		<tr>
			<td><%=rs1.getInt("faculty_id")%></td>
			<td><%=rs1.getString("name") %></td>
		</tr>
	<%
		}
	%>
</table>
<form action="ThesisCommittee2.jsp" method="get">
	<input type="hidden" value="insert" name="action">
	<p>Enter the ID of the 4 faculty referenced above:</p>
	Faculty ID 1: <input type="text" name="faculty1"><br>
	Faculty ID 2: <input type="text" name="faculty2"><br>
	Faculty ID 3: <input type="text" name="faculty3"><br>
	Faculty ID 4: <input type="text" name="faculty4"><br>
<input type="submit" value="Submit">
</form>
<%
	conn.close();
  } catch(Exception e) {
		e.printStackTrace();
  }
%>

</body>
</html>