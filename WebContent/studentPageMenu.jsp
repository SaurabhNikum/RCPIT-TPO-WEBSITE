<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="connectDB.*"%>
<%
	String fileName = "assets/img/find_user.png";
	try {
		Statement statement = null;
		ResultSet rs = null;
		Connection conn = DBconnect.getConnect();
		statement = conn.createStatement();
		String sql = "select image from student where roll_no = '" + session.getAttribute("ROLL_NO") + "'";
		rs = statement.executeQuery(sql);
		if (rs.next()) {
			fileName = rs.getString("IMAGE");
		}
	} catch (Exception e) {
		log.error("Could not load page : {}", e);
	}
	if (!fileName.equalsIgnoreCase("assets/img/find_user.png"))
		fileName = "/Download?file=" + fileName + "&type=image/jpeg";
%>
<nav class="navbar navbar-default navbar-cls-top " role="navigation"
	style="margin-bottom: 0">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target=".sidebar-collapse">
			<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
			<span class="icon-bar"></span> <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" style="font-size: 19px" href="#"><%= session.getAttribute("name") %></a>
	</div>
	<div
		style="color: white; padding: 15px 50px 5px 50px; float: right; font-size: 16px;">
		&nbsp; <a href="/Logout" class="btn btn-danger square-btn-adjust">Logout</a>
	</div>
</nav>
<!-- /. NAV TOP  -->
<nav class="navbar-default navbar-side" role="navigation">
	<div class="sidebar-collapse">
		<ul class="nav" id="main-menu">
			<li class="text-center"><img src="<%=fileName%>"
				class="user-image img-responsive" style="height: 100px;" /></li>
			<li><a href="uploadResume.jsp"><i class="fa fa-edit fa-3x"></i>Upload/Update
					Resume</a></li>
			<li><a href="uploadPic.jsp"><i class="fa fa-edit fa-3x"></i>Upload/Update
					Passport Photo</a></li>
			<li><a href="editProfile.jsp"><i class="fa fa-edit fa-3x"></i>Edit Personal Information</a></li>					
			<li><a href="viewDrives.jsp"><i class="fa fa-edit fa-3x"></i>View
					Upcoming Campus Drives Details</a></li>
			<li><a href="viewSelectionProcess.jsp"><i
					class="fa fa-edit fa-3x"></i>View selection Process Of Company</a></li>
			<li><a href="learnAptituteQuestions.jsp"><i
					class="fa fa-edit fa-3x"></i>Learn Aptitute Questions</a></li>
			<li><a
				href="https://mail.google.com/mail/u/0/#search/from%3Amilkesh.jain31%40gmail.com"><i
					class="fa fa-edit fa-3x"></i>View Notifications</a></li>
			<li><a href="askQueries.jsp"><i class="fa fa-edit fa-3x"></i>Ask
					Queries</a></li>
			<li><a href="addFeedback.jsp"><i class="fa fa-edit fa-3x"></i>Add
					Feedback For Students</a></li>
			<li><a href="viewAnsweredQueries.jsp"><i
					class="fa fa-edit fa-3x"></i>View Answered Queries By TPO</a></li>
			<li><a href="password.jsp"><i
					class="fa fa-edit fa-3x"></i>Change Password</a></li>


		</ul>

	</div>

</nav>
<!-- /. NAV SIDE  -->