<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Degree Requirement Form</title>
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

	ResultSet rs2 = statement.executeQuery("SELECT * FROM \"Concentration\"");

 %>
<form action="Degree2.jsp" method="get">
	<input type="hidden" value="insert" name="action">
	Degree Type: <input type="text" name="type"><br>
	Select a concentration from below if applicable:
    <table border="1">
		<tr>
			<th>Concentration ID</th>
			<th>Concentration Name</th>
		</tr>
	<%-- Iteration Code --%>
	<%
		while(rs2.next()) {
	%>
		<tr>
			<td><input type="submit" value="<%=rs2.getString("concentration_id")%>" name="concentration_id"></td>
            <td><%=rs2.getString("name") %></td>
		</tr>
	<%
		}
	%>
	</table>
	Or, 
<input type="submit" value="Skip" name="concentration_id">
</form>
<%
	conn.close();
  } catch(Exception e) {
		e.printStackTrace();
  }
%>

</body>
</html>