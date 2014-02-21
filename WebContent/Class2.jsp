<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Class Information</title>
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
<form action="Class3.jsp" method="get">
	<input type="hidden" value="insert" name="action">
	Course number(with department abbreviation): <%=request.getParameter("course_id") %><br>
	<input type="hidden" value="<%=request.getParameter("course_id")%>" name="course_id">
	Title: <input type="text" name="title"><br>
	Quarter:
	<select name="quarter">
		<option value="fall">Fall</option>
		<option value="winter">Winter</option>
		<option value="spring">Spring</option>
		<option value="summer">Summer</option>
	</select><br>
	Year: <input type="text" name="year"><br>
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