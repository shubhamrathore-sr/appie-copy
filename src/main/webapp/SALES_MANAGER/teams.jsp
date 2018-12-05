<%@page import="java.util.*"%>
<%@page import="ai.talentify.services.TeamService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/assets/css/team.css" />
<link rel="stylesheet" type="text/css" href="/assets/css/header.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>

<%
	// Give me a list of teams 
	HashMap<String, String> userData = (HashMap<String, String>)request.getSession().getAttribute("user");
	String managerID = userData.get("id");
	TeamService service = new TeamService();
	ArrayList<HashMap<String, String>> teams = service.getTeams(Integer.parseInt(managerID));
%>
<body>

	<div class="main-header">
		<jsp:include page="/SALES_MANAGER/inc/navbar.jsp"></jsp:include>
	</div>
	<div class="container">


		<div class="head">
			<div>
				<h1 style="color: rgb(98, 96, 96); font-weight: normal;">Teams</h1>
			</div>
			<a class="onclick" href="/SALES_MANAGER/create_team.jsp">Create Team</a>
		</div>
		<div class="teamsContainer">
			<%
				for (HashMap<String, String> teamData : teams) {
			%>

			<div class="teamCard" id="<%=teamData.get("id")%>" > 
				<div class="teamCardHead">
					<p><%=teamData.get("name")%></p>
				</div>
				<div class="teamDesc">
					<p><%=teamData.get("description")%></p>
				</div>
				<div class="teamMembers"></div>
			</div>
			<%
				}
			%>
		</div>
	</div>


</body>
<script>
	$(document).ready(
			function() {
				$('.teamCard').each(
						function() {
							var currentElement = $(this).attr("id");
							$.get("/team?method=GET_USER_DETAILS&teamID="
									+ currentElement, function(data) {
								try {
									var counter = Math.min(data.length,3);
									console.log(data);
									if(data.length > 0) {
										for (var index = 0; index < counter-1; index++) {
											var image = document
													.createElement('img');
											image.src = 'https://business.talentify.in/'+(data)[index].picture;
											var teamMembers = $('#'
													+ currentElement
													+ ' .teamMembers');
											teamMembers.append(image)
										}
										if(counter> 3) {
											var para = document.createElement('p');
											var userrCount = (data)[counter-1].count - 3;
											var node = document.createTextNode("+"
													+ userrCount + " Members");
											para.appendChild(node);
											teamMembers.append(para);
									    }
									} else {
										var teamMembers = $('#'
												+ currentElement
												+ ' .teamMembers');
										var para = document.createElement('p');
										var node = document.createTextNode("Team has no members");
										para.appendChild(node);teamMembers.append(para);
									}
								} catch (e) {
									//console.trace(e)
								}
							});
						});
			});
	
	$( ".teamCard" ).click(function() {
		var currentElement = $(this).attr("id");
		window.location.href = '/SALES_MANAGER/create_team.jsp?team_id='+currentElement;

	});
	
</script>

</html>