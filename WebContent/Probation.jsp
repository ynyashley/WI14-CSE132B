<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Probation</title>
</head>
<body>
<%@ page language="java" import="java.sql.*" %>
  <% try{
	Class.forName("org.postgresql.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection(
	   "jdbc:postgresql://localhost:5432/cse132b","postgres", "YUNGp12594");
  %>
<form action="Probation2.jsp" method="get">
	<input type="hidden" value="insert" name="action">
	StudentID: <input type="text" name="student_id"><br>
	<input type="hidden" value="<%=request.getParameter("student")%>" name="student">
	Reason: <input type="text" name="reason"><br>

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