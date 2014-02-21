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

<%-- Selection Code --%>
<% 
	String student_id = request.getParameter("student_id"); 
	String gp_id = request.getParameter("gp_id");
	String department_id = request.getParameter("dept_id");
	
	// begin transaction
	ResultSet rs;
	ResultSet rs1;
	int graduate_id = 0;

	conn.setAutoCommit(false);
	PreparedStatement pstmt;
	
	Statement statement = conn.createStatement();
	
	rs = statement.executeQuery("SELECT * FROM \"Student\" WHERE \"Student\".student_id='"+student_id+"'");
	if(!rs.next()) {
%>
		Your Student ID is not found in our database. Please try again.
<%
	}
	else {
		pstmt = conn.prepareStatement("INSERT INTO \"Graduate\"(student_id, gp_id, department_id) VALUES (?, ?, ?) returning graduate_id");
		pstmt.setString(1, student_id);
		pstmt.setInt(2, Integer.parseInt(gp_id));
		pstmt.setInt(3, Integer.parseInt(department_id));
		rs1 = pstmt.executeQuery();
		rs1.next();
		graduate_id = rs1.getInt("graduate_id");
		
		conn.commit();
		conn.setAutoCommit(true);
%>
	Graduate Student (student ID <%=student_id %>) has been successfully submitted.
	<form action="PhD.jsp" method="get">
		<input type="hidden" value="<%=graduate_id %>" name="graduate_id">
		If you are a PhD student, you can enter more information <input type="submit" value="here">.
	</form>
<%
	}
%>
<%
	conn.close();
  } catch(Exception e) {
		e.printStackTrace();
  }
%>

</body>
</html>