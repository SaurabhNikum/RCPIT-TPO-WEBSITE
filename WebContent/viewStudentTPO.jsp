<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="connectDB.*"%>
<%@page import="services.*"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%! final private static Logger log = LoggerFactory.getLogger("viewStudentTPO_JSP"); %>
<%
	if (!Auth.getRole(session).equals("ADMIN")) {
		response.sendRedirect("adminLogin.jsp");
		return; 
	}
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>RCPIT,TPO</title>
<!-- BOOTSTRAP STYLES-->
<link href="assets/css/bootstrap.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="assets/css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLES-->
<link href="assets/css/custom.css" rel="stylesheet" />
<!-- GOOGLE FONTS-->
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<link href="assets/css/css.css" rel="stylesheet">
<script type="text/javascript">
   	function access(){
		<% Object s1 = session.getAttribute("msg");
		 if(s1!=null){ %>
		alert('<%=s1.toString()%>');
		<% session.setAttribute("msg",null);
		}	%>
	}
</script>

</head>
<body onload="access()">
	<%
		//AbstractDao abstractDao=new AbstractDao();
	%>

	<div id="wrapper">

		<%@ include file="adminPageMenu.jsp"%>

		<div id="page-wrapper">
			<div id="page-inner">
				<div class="row">
					<h2>&nbsp&nbspView Students</h2>
					<div class="col-md-12">
						<span><button data-toggle="modal" data-target="#clearStudentData" class="btn btn-danger square-btn-adjust" style="float: right; margin-bottom: 10px;margin-left: 10px;">Clear Student Data</button></a></span>
						<span><a href="/DownloadExcel"><button class="btn btn-primary square-btn-adjust" style="float: right; margin-bottom: 10px;">Download in Excel</button></a></span>
						<table border="1" id="displaytable" class="table table-bordered"
							style="">
							<thead>
								<tr>
									<th>Name</th>
									<th>Roll No</th>
									<th>Branch</th>
									<th>Division</th>

									<th>Email ID</th>
									<th>Mobile Number</th>
									<th>Selected In</th>
									<th>Package</th>
									<th>Photo</th>
									<th>Resume</th>
								</tr>
								<%
									Statement statement = null;
									ResultSet resultSet = null;
								%>
								<%
									try {
										Connection conn = DBconnect.getConnect();
										statement = conn.createStatement();
										String sql = "select * from student";
										resultSet = statement.executeQuery(sql);
										while (resultSet.next()) {
								%>
							
							<tbody>
								<tr>
									<td><%=resultSet.getString("NAME")%></td>
									<td><%=resultSet.getString("ROLL_NO")%></td>
									<td><%=resultSet.getString("BRANCH")%></td>
									<td><%=resultSet.getString("DIV")%></td>
									<td><%=resultSet.getString("EMAIL_ID")%></td>

									<td><%=resultSet.getString("MOBILE_NO")%></td>
									<td><%=resultSet.getString("SELECTED_IN")%></td>
									<td><%=resultSet.getString("PACKAGE")%></td>
									<%
										String fileName1 = null;
												String fileName = null;
												fileName = resultSet.getString("IMAGE");
												if (!fileName.equalsIgnoreCase("assets/img/find_user.png"))
													fileName = "/Download?file=" + fileName + "&type=image/jpeg";
												else
													fileName = null;

												fileName1 = resultSet.getString("resume");
												if (fileName1 != null)
													fileName1 = "/Download?file=" + fileName1 + "&type=application/pdf";
									%>
									<td><center>
											<%
												if (fileName != null) {
											%><i data-toggle="modal"
												data-target="#myModal" class="fa fa-file image_view"
												style="font-size: 150%; color: black; cursor: pointer;"
												data-rel="<%=fileName%>"
												data-name="<%=resultSet.getString("NAME")%>"> </i>
											<%
												}
											%>
										</center></td>
									<td><center>
											<%
												if (fileName1 != null) {
											%><a href="<%=fileName1%>"
												target="_blank"><i class="fa fa-download"
												style="font-size: 150%; color: red;"></i></a>
											<%
												}
											%>
										</center></td>

								</tr>
							</tbody>
							<%
								}
									//connection.close();
								} catch (Exception e) {
									log.error("Could not view students : {}", e);
								}
							%>

							</thead>
						</table>
					</div>
				</div>

			</div>

		</div>
	</div>

	</div>

	<div
		style="color: white; padding: 15px 50px 5px 50px; float: right; font-size: 16px;">
		&nbsp; <a href="menuForAdmin.jsp"
			class="btn btn-danger square-btn-adjust">Back To Home Page</a>
	</div>

	<!-- /. PAGE INNER  -->
	</div>
	<!-- /. PAGE WRAPPER  -->
	</div>

	<!-- Modal -->
	<div class="modal fade" id="myModal" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<center>
						<b><h4 class="modal-title" id="modal_name">Name</h4></b>
					</center>
				</div>
				<div class="modal-body">
					<center>
						<div id="area"></div>
					</center>
				</div>
				<div class="modal-footer">
					<span id="download_button"></span>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>
	
		<!-- Modal -->
	<div class="modal fade" id="clearStudentData" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<center>
						<b><h4 class="modal-title" id="modal_name">Are you sure?</h4></b>
					</center>
				</div>
				<div class="modal-body">
					<center>
						<div id="area">You are about to clear the whole student data. However, after clearing this data students will not be able to log in and also you can't retrieve it anymore. <strong>Recommend you to please backup this data before you clear.</strong> Ignore if already have backup</div>
					</center>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-danger" onclick="loadDoc()">Clear All Student Data</button>
					<a href="/DownloadExcel"><button type="button" class="btn btn-primary">Download in Excel</button></a>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>
			</div>

		</div>
	</div>

	<!-- /. WRAPPER  -->
	<!-- SCRIPTS -AT THE BOTOM TO REDUCE THE LOAD TIME-->
	<!-- JQUERY SCRIPTS -->
	<script src="assets/js/jquery-1.10.2.js"></script>
	<!-- BOOTSTRAP SCRIPTS -->
	<script src="assets/js/bootstrap.min.js"></script>
	<!-- METISMENU SCRIPTS -->
	<script src="assets/js/jquery.metisMenu.js"></script>
	<!-- CUSTOM SCRIPTS -->
	<script src="assets/js/custom.js"></script>
	<script type="text/javascript">
		$(".image_view")
				.click(
						function() {
							var name = $(this).data('name');
							$("#modal_name").html("NAME:- " + name);
							var imgUrl = $(this).data('rel');
							$("#area")
									.html(
											"<img src='"
													+ imgUrl
													+ "' alt='Large Profile Pic' width='50%''' />");
							$("#download_button")
									.html(
											"<a href='"+imgUrl+"'><button type='button' class='btn btn-primary'>Download</button></a>");
						});
	</script>
	<script type="text/javascript">
		function loadDoc() {
		  var xhttp = new XMLHttpRequest();
		  xhttp.onreadystatechange = function() {
		    if (this.readyState == 4 && this.status == 200) {
		      alert('Success!...');
		      window.location.reload();
			   return;
		    }
		    if(this.readyState == 4 && this.status == 401){
		    	alert('Please Login First');
			    window.location.reload();
			    return;
		    }
		    if(this.readyState == 4 && this.status != 200){
		    	alert('Error Please try later!...');
			    return;
		    }
		  };
		  xhttp.open("POST", "TPOStudentService", true);
		  xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		  xhttp.send();
		}
	</script>
	<SCRIPT language=Javascript>
		function isNumberKey(evt) {
			var charCode = (evt.which) ? evt.which : event.keyCode;

			if (charCode > 31 && (charCode<48 || charCode>57))
				return false;

			return true;
		}
	</SCRIPT>

</body>
</html>
