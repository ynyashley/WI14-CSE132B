<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Degree Requirement Form</title>
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

  	ResultSet rs = null;
	ResultSet rs2 = statement.executeQuery("SELECT * FROM \"Concentration\"");

  %>
  <%
	int degree_id = 0;

	String action = request.getParameter("action");
	// Check if it's an insertion
	if(action != null && action.equals("insert")) {
		// begin transaction
		conn.setAutoCommit(false);
		
		// Create prepared statement and use it to INSERT the Class
		// attributes INTO the Course table.
		PreparedStatement pstmt;
		System.out.println("degree_id: " + request.getParameter("degree_id"));
		
		if(request.getParameter("degree_id") == null) {
			if(request.getParameter("concentration_id").equals("Skip")) {
				pstmt = conn.prepareStatement(
						"INSERT INTO \"Degree\"(type) VALUES (?) returning degree_id");
				pstmt.setString(1, request.getParameter("type"));
			}
			else {
				pstmt = conn.prepareStatement(
					"INSERT INTO \"Degree\"(type, concentration_id) VALUES (?,?) returning degree_id");
				pstmt.setString(1, request.getParameter("type"));
				pstmt.setInt(2, Integer.parseInt(request.getParameter("concentration_id")));
			}
			rs = pstmt.executeQuery();
			rs.next();
			degree_id = rs.getInt("degree_id");
		}
		else {
			degree_id = Integer.parseInt(request.getParameter("degree_id"));
		}

		pstmt = conn.prepareStatement(
				"INSERT INTO \"Degree_RU\"(degree_id, ru_id) VALUES (?, ?)");
		pstmt.setInt(1, degree_id);
		pstmt.setInt(2, Integer.parseInt(request.getParameter("ru_id")));
			
		pstmt.executeUpdate();
		
		conn.commit();
		conn.setAutoCommit(true);
	}
%>
Your Degree Requirement Info has been submitted successfully.
<form action="Degree2.jsp" method="get">
	<input type="submit" value="Add Another Required Unit">
	<input type="hidden" value="<%=request.getParameter("type") %>" name="type">
	<input type="hidden" value="<%=request.getParameter("concentration_id") %>" name="concentration_id">
	<input type="hidden" value="<%=degree_id %>" name="degree_id">
</form>
<%
	conn.close();
  } catch(Exception e) {
		e.printStackTrace();
  }
%>

</body>
</html>