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
	ResultSet rs1 = statement.executeQuery("SELECT * FROM \"Department\"");
	//ResultSet rs2 = statement.executeQuery("SELECT * FROM \"Tc_Faculty\" JOIN \"Faculty\" ON \"Faculty\".faculty_id = \"Tc_Faculty\".faculty_id");
	int graduate_id = Integer.parseInt(request.getParameter("graduate_id"));
%>

<!-- HTML Code to create the entry form -->
Entering information for Graduate Student ID <%=graduate_id %>:
<form action="PhD2.jsp" method="get">
	<input type="hidden" value="insert" name="action">
	PhD Candidacy:
	<select name="candidacy_id">
		<option value="1">PhD candidate</option>
		<option value="2">PhD pre-candidate</option>
	</select><br>
	<input type="hidden" value="<%=graduate_id %>" name="graduate_id">
	<input type="submit" value="next">
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