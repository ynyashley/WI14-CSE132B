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
<form action="Student2.jsp" method="post">
	<input type="hidden" value="insert" name="action">
	Student ID: <input type="text" name="student_id"><br>
	Residency Status:
	<select name="residency_id">
		<option value="1">California Resident</option>
		<option value="2">Foreign Student</option>
		<option value="3">Non-CA Student</option>
	</select><br>
	First Name: <input type="text" name="first_name"><br>
	Middle Name: <input type="text" name="middle_name"><br>
	Last Name: <input type="text" name="last_name"><br>
	Social Security Number: <input type="text" name="social_security"><br>
	Start Date (YYYY-MM-DD): <input type="date" name="start_date"><br>
	Graduation Date (or expected graduation date, YYYY-MM-DD): <input type="date" name="end_date"><br>
	Enrollment status:
	<select name="enrollment_status">
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