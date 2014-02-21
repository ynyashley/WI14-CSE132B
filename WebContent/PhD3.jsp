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
	ResultSet rs = statement.executeQuery("SELECT * FROM \"Faculty\"");
	int graduate_id = Integer.parseInt(request.getParameter("graduate_id"));
%>

<!-- HTML Code to create the entry form -->
Entering information for Graduate Student ID <%=graduate_id %>:
<form action="PhD4.jsp" method="get">
	<input type="hidden" value="insert" name="action">
	Choose your adviser from below:
	<table border="1">
		<tr>
			<th>Faculty ID</th>
			<th>Faculty Name</th>
		</tr>
	<%-- Iteration Code --%>
	<%
		while(rs.next()) {
	%>
		<tr>
			<td><input type="submit" value="<%=rs.getInt("faculty_id")%>" name="faculty_id"></td>
			<td><%=rs.getString("name") %></td>
		</tr>
	<%
		}
	%>
	</table>
	<input type="hidden" value="<%=graduate_id %>" name="graduate_id">
	<input type="hidden" value="<%=request.getParameter("tc_id") %>" name="tc_id">
	<input type="hidden" value="<%=request.getParameter("candidacy_id") %>" name="candidacy_id">
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