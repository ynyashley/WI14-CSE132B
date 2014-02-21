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
	
	// begin transaction
	ResultSet rs;

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
		pstmt = conn.prepareStatement("INSERT INTO \"Student_Section\"(student_id, section_id) VALUES (?, ?)");
		pstmt.setString(1, student_id);
		pstmt.setInt(2, Integer.parseInt(request.getParameter("section_id")));
		pstmt.executeUpdate();
		
		conn.commit();
		conn.setAutoCommit(true);
%>
	Your course history has been successfully updated.
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