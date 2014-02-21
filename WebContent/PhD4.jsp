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
	String graduate_id = request.getParameter("graduate_id"); 
	String tc_id = request.getParameter("tc_id");
	String faculty_id = request.getParameter("faculty_id");
	String candidacy_id = request.getParameter("candidacy_id");
	
	// begin transaction

	conn.setAutoCommit(false);
	PreparedStatement pstmt;
	
	Statement statement = conn.createStatement();
	pstmt = conn.prepareStatement("INSERT INTO \"PhD\"(graduate_id, tc_id, faculty_id, candidacy_id) VALUES (?, ?, ?, ?)");
	pstmt.setInt(1, Integer.parseInt(graduate_id));
	pstmt.setInt(2, Integer.parseInt(tc_id));
	pstmt.setInt(3, Integer.parseInt(faculty_id));
	pstmt.setInt(4, Integer.parseInt(candidacy_id));
	pstmt.executeUpdate();
	
	conn.commit();
	conn.setAutoCommit(true);
%>
	PhD student info has been successfully submitted.
<%
	conn.close();
  } catch(Exception e) {
		e.printStackTrace();
  }
%>

</body>
</html>