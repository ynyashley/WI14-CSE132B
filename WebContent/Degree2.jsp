<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Degree</title>
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
	ResultSet rs2 = statement.executeQuery("SELECT * FROM \"Required_Unit\"");

%>
<form action="Degree3.jsp" method="get">
	Select one of the required unit option from below:
	<input type="hidden" value="insert" name="action">
    <table border="1">
		<tr>
			<th>Required Unit ID</th>
			<th>Type</th>
			<th>Unit</th>
		</tr>
	<%-- Iteration Code --%>
	<%
		while(rs2.next()) {
	%>
		<tr>
			<td><input type="submit" value="<%=rs2.getString("ru_id")%>" name="ru_id"></td>
            <td><%=rs2.getString("type") %></td>
            <td><%=rs2.getInt("unit") %>
		</tr>
	<%
		}
	%>
	</table>
	<input type="hidden" value="<%=request.getParameter("concentration_id")%>" name="concentration_id">
	<input type="hidden" value="<%=request.getParameter("type") %>" name="type">
</form>
<%
	conn.close();
  } catch(Exception e) {
		e.printStackTrace();
  }
%>

</body>
</html>