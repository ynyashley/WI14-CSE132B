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
<%-- Insert Code --%>
<%
	int section_id = Integer.parseInt(request.getParameter("section_id"));
	String student_id = request.getParameter("student_id");
	int class_id = 0;
	String course_id = null;
	int min_unit = 0;
	int max_unit = 0;
	// begin transaction
	conn.setAutoCommit(false);
	
	Statement statement = conn.createStatement();
	ResultSet rs1 = statement.executeQuery("SELECT * FROM \"Class_Section\" WHERE section_id=" + section_id);
	rs1.next();
	class_id = rs1.getInt("class_id");
	System.out.println("class_id: " + class_id);
	rs1.close();
	
	statement = conn.createStatement();
	ResultSet rs2 = statement.executeQuery("SELECT course_id FROM \"Course_Class\" WHERE class_id=" + class_id);
	while(rs2.next()) {
		course_id = rs2.getString("course_id");
	}
	System.out.println("course_id: " + course_id);
	rs2.close();
		
	statement = conn.createStatement();
	if(course_id != null) {
		ResultSet rs3 = statement.executeQuery("SELECT * FROM \"Course\" WHERE course_id='" + course_id + "'");
		while(rs3.next()) {
			min_unit = rs3.getInt("min_unit");
			max_unit = rs3.getInt("max_unit");
		}
		rs3.close();
	}

	System.out.println("min: " + min_unit);
	System.out.println("max: " + max_unit);
	
	if(min_unit == max_unit) {
		PreparedStatement pstmt = conn.prepareStatement(
				"INSERT INTO \"Student_Section\"(student_id, section_id, unit) VALUES (?, ?, ?)");
		pstmt.setString(1, request.getParameter("student_id"));
		pstmt.setInt(2, section_id);
		pstmt.setInt(3, min_unit);
		
		pstmt.executeUpdate();
		
		conn.commit();
		conn.setAutoCommit(true);
%>
You have successfully enrolled in section <%=section_id %>.
<%
	}
	else {	// prompt user to enter how many units he wants to take
%>
<form action="CourseEnrollment3.jsp" method="get">
Number of units you would like to take:
<input type="number" min="<%=min_unit %>" max= "<%=max_unit %>" name="unit">
<input type="hidden" value="<%=student_id %>" name="student_id">
<input type="hidden" value="<%=section_id %>" name="section_id">
<input type="submit" value="Submit">
</form>
<%
	}
%>

<%-- Close Connection Code --%>
<%
	conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>