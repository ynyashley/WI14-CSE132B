<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Course Information</title>
</head>
<body>
<%@ page language="java" import="java.sql.*" %>
<% try{
		Class.forName("org.postgresql.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection(
	   	"jdbc:postgresql://localhost:5432/cse132b","postgres", "YUNGp12594");
%>

<!-- HTML Code to create the entry form -->
<form action="Prereq.jsp" method="post">
	<input type="hidden" value="insert" name="action">
	Course number(with department abbreviation): <input type="text" name="course_id"><br>
	<!-- Department: <input type="text" name="department_name"><br>-->
	Grade Option:
	<select name="grade_option">
		<option value="1">Letter Grade Only</option>
		<option value="2">Letter Grade or S/U</option>
		<option value="3">S/U Only</option>
	</select><br>
	Unit(s): <input type="number" name="unit" min="1" max="8"><br>
	Lab work required:
	<select name="lab_work">
		<option value="true">Yes</option>
		<option value="false">No</option>
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