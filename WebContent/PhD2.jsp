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
	ResultSet rs = statement.executeQuery("SELECT * FROM \"Tc_Faculty\" JOIN \"Faculty\" ON \"Faculty\".faculty_id = \"Tc_Faculty\".faculty_id");
	int graduate_id = Integer.parseInt(request.getParameter("graduate_id"));
%>

<!-- HTML Code to create the entry form -->
Entering information for Graduate Student ID <%=graduate_id %>:
<form action="PhD3.jsp" method="get">
	<input type="hidden" value="insert" name="action">
	Choose your Thesis Committee from the chart below:
	<table border="1">
		<tr>
			<th>Thesis Committee ID</th>
			<th>Professor Name</th>
			<th>Professor Title</th>
		</tr>
	<%-- Iteration Code --%>
	<%
		while(rs.next()) {
	%>
		<tr>
			<td><input type="submit" value="<%=rs.getInt("tc_id")%>" name="tc_id"></td>
			<td><%=rs.getString("name") %></td>
			<td><%=rs.getString("title") %>
		</tr>
	<%
		}
	%>
	</table>
	<input type="hidden" value="<%=graduate_id %>" name="graduate_id">
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