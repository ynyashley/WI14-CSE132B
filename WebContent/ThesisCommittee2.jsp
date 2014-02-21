<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Thesis Committee Submission</title>
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
	String faculty1 = request.getParameter("faculty1"); 
	String faculty2 = request.getParameter("faculty2"); 
	String faculty3 = request.getParameter("faculty3"); 
	String faculty4 = request.getParameter("faculty4"); 
	
	// begin transaction
	ResultSet rs;
	ResultSet rs1;
	int tc_id = 0;
	conn.setAutoCommit(false);
	PreparedStatement pstmt = conn.prepareStatement(
			"INSERT INTO \"Thesis_Committee\" DEFAULT VALUES returning tc_id");
			
	rs = pstmt.executeQuery();
	rs.next();
	tc_id = rs.getInt("tc_id");
	
	Statement statement = conn.createStatement();
	
	rs1 = statement.executeQuery("SELECT department_id FROM \"Faculty\" WHERE \"Faculty\".faculty_id=" + Integer.parseInt(request.getParameter("faculty1")));
	rs1.next();
	int dept1 = rs1.getInt("department_id");
	rs1 = statement.executeQuery("SELECT department_id FROM \"Faculty\" WHERE \"Faculty\".faculty_id=" + Integer.parseInt(request.getParameter("faculty2")));
	rs1.next();
	int dept2 = rs1.getInt("department_id");
	rs1 = statement.executeQuery("SELECT department_id FROM \"Faculty\" WHERE \"Faculty\".faculty_id=" + Integer.parseInt(request.getParameter("faculty3")));
	rs1.next();
	int dept3 = rs1.getInt("department_id");
	rs1 = statement.executeQuery("SELECT department_id FROM \"Faculty\" WHERE \"Faculty\".faculty_id=" + Integer.parseInt(request.getParameter("faculty4")));
	rs1.next();
	int dept4 = rs1.getInt("department_id");
	
	if(dept1 == dept2 && dept2 == dept3 && dept3 == dept4) {
%>
	One professor needs to come from a different department in your Thesis Committee. Please try again.
<%
	}
	else {
		for(int i = 1; i <= 4; i++) {
			pstmt = conn.prepareStatement("INSERT INTO \"Tc_Faculty\"(tc_id, faculty_id) VALUES (?, ?)");
			pstmt.setInt(1, tc_id);
			pstmt.setInt(2, Integer.parseInt(request.getParameter("faculty" + String.valueOf(i))));
			pstmt.executeUpdate();
		}
		conn.commit();
		conn.setAutoCommit(true);
%>
	Your Thesis Committee has been successfully recorded.
<%
	}
%>

<!-- HTML Code to create the entry form -->
<!-- End HTML Code for entry form -->

<%-- Close Connection Code --%>
<%
	rs.close();
	rs1.close();
	conn.close();
	} catch(Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>