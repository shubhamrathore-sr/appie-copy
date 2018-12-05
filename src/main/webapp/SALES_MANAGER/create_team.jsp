<%@page import="java.util.*"%>
<%@page import="ai.talentify.services.TeamService"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><html>
<head>
<link rel="stylesheet" type="text/css" href="/assets/css/create-team.css" />
<link rel="stylesheet" type="text/css" href="/assets/css/header.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
	<div class="main-header">
		<jsp:include page="/SALES_MANAGER/inc/navbar.jsp"></jsp:include>
	</div>
	<div class="main">

		<%
			if (request.getParameterMap().containsKey("team_id")) {
				TeamService service = new TeamService();
				HashMap<String, String> team = service
						.getTeamDetails(Integer.parseInt(request.getParameter("team_id").toString()));
		%>
		<input type="hidden" name="organization_id" value="<%=team.get("organization_id")%>" id="organization_id" /> 
		<input type="hidden" name="team_id" value="<%=request.getParameter("team_id")%>" id="team_id" />
		<div class="main-container">
			<div class="title-head">
				<p>Edit Team</p>
			</div>
			<div class="form-container">
				<div class="group-name-addMembers">
					<div class="desc">
						<h4 class="heading">Team Name</h4>
						<input type="text" class="data-field" id='name' placeholder="Enter Team Name" value="<%=team.get("name")%>">
					</div>
					<div class="desc add">
						<h4 class="heading">Add Members</h4>
						<div class="dropdown-container">
							<input type="text" id="searchInput" class="edit-add-member-field" placeholder="Type name of the Team member to add">
							<div class="dropdown-content" id="orgMembers"></div>
						</div>
					</div>
				</div>

				<div style="display: flex;">
					<div class="skill-find">

						<div class="desc">
							<h4 class="heading">Team Description</h4>
							<div class="text-container">
								<textarea type="text" id='description' class="text-field" cols="100" row="1000" placeholder="Enter Team Description"><%=team.get("description")%></textarea>
							</div>
						</div>
					</div>
					<!--  <div class="skill-select">
					<div class="desc">
						<div class="types">
							<h4 class="heading">Members</h4>
						</div>
						<div class="skill-course">
							<table>
								<tr class="text-center table-shadow td-font ng-star-inserted">
									<td><img _ngcontent-c22="" alt="..." class="image-shadow" height="40" width="40" src="https://business.talentify.in/users/S.png"></td>
									<td>Sreeram</td>
									<td>9988788888</td>
									<td>sriram@istarindia.com</td>
								</tr>
							</table>


						</div>
					</div>
				</div>-->
				</div>

			</div>


			<div class="buttons">
				<button class="create btn" id='update_team'>Update Team</button>
			</div>
			<div class="float-right">
				<input type="text" id="searchTable" class="searchTableField" placeholder="Search..">
			</div>
			<div class="table-div">
				<table style="width: 100%; border-collapse: collapse;">
					<thead class="table-header-column">
						<tr>
							<th class="table-head"></th>
							<th class="table-head">NAME</th>
							<th class="table-head">PHONE NO</th>
							<th class="table-head">EMAIL ID</th>
							<th class="table-head">Products</th>
							<th class="table-head"></th>
						</tr>
					</thead>
					<tbody id='members_table'>
					</tbody>
				</table>

			</div>

			<div class="pagination-container">
				<div class="pagination-count">Showing 10 of 10000</div>
				<div class="pagination-btn-group">
					<button type="button" class="pagination-prev">Previous</button>
					<button type="button" class="pagination-next">Next</button>

				</div>
			</div>
		</div>

		<%
			} else {
				
				HashMap<String, String> userData = (HashMap<String, String>)request.getSession().getAttribute("user");
				String managerID = userData.get("id");
				String organization_id = new TeamService().getOrganizationFromManager(managerID);
		%>
		<input type="hidden" name="organization_id" value="<%=organization_id%>" id="organization_id" /> 

		<div class="main-container">
			<div class="title-head">
				<p>Create Team</p>
			</div>
			<div class="group-desc create_team_name">
				<div class="desc">
					<h4 class="heading">Team Name <span class="mandatory">*</span></h4>
					<input type="text" id='name' class="data-field" placeholder="Enter Team Name">
				</div>
			</div>
			<div style="display: flex;" class="create-team-desc">
				<div class="skill-find">
					<div class="desc">
						<h4 class="heading">Team Description</h4>
						<div class="text-container">
							<textarea type="text" id='description' class="text-field" placeholder="Enter Team Description"></textarea>
						</div>
					</div>
				</div>
				
			</div>
			<div class="buttons">
				<button class="create btn" id='create_team'>Create</button>
			</div>
		</div>

		<%
			}
		%>

	</div>
</body>
<script>
	var teamMembersData;
	var noOfMembersToDisplay = 10;
	var incrementor = noOfMembersToDisplay;
	var startIndex = 0;
	var pageno = 1;
	$(document).ready(function() {
		console.log($('#team_id').val());
		if(typeof  $('#team_id').val() != 'undefined') {
			genrateUserTable();
		}
	});
	/* $( ".delete_user" ).live('click', (function() {
		console.log('deleted ');
		var currentElement = $(this).attr("id");
		$.get('/SALES_MANAGER/create_team.jsp?team_id='+$('#team_id').val()+'&user_id='+currentElement);
	})); */

	$(document).on(
			'click',
			'.delete_user',
			function() {

				var currentElement = $(this).attr("id");
				$.get('/team?method=DELETE_USER&team_id=' + $('#team_id').val()
						+ '&user_id=' + currentElement, function(data, status) {
					var tbody = $('#members_table');
					tbody.innerHTML = '';
					console.log(teamMembersData);
					genrateUserTable();
				});
			});

	$(document).on('click', '.pagination-prev', function() {
		console.log("clicked-prev")
		if (startIndex >= incrementor) {
			startIndex = startIndex - incrementor
			noOfMembersToDisplay = noOfMembersToDisplay - incrementor;
			generateDataOnPaging(teamMembersData);
		}
	})

	$(document).on('click', '.pagination-next', function() {
		console.log("clicked-next")

		if ((startIndex + incrementor) < teamMembersData.length) {
			startIndex = startIndex + incrementor;
			noOfMembersToDisplay = noOfMembersToDisplay + incrementor;
			generateDataOnPaging(teamMembersData);
		}

	})

	$("#searchTable").keyup(function() {
		var search = $("#searchTable").val().toLowerCase();
		var members = [];
		var data1 = teamMembersData.filter(function(member) {
			if (member.name.toLowerCase().indexOf(search) != -1) {
				members.push(member);
				return members;
			}

		});
		generateDataOnPaging(data1);

	});

	function genrateUserTable() {
		var currentElement = $('#team_id').val();
		$.get(
				"/team?method=GET_USER_DETAILS_EXPANDED&teamID="
						+ currentElement, function(data) {
					teamMembersData = data;
					generateDataOnPaging(teamMembersData);
					$('.pagination-count').empty();
					$('.pagination-count').append(
							'Showing 1-10 of ' + teamMembersData.length);
				});
	}

	function generateDataOnPaging(teamMembersData) {
		$('#members_table').empty()
		var tbody = $('#members_table');
		$('.pagination-count').empty();
		$('.pagination-count').append(
				'Showing '
						+ startIndex
						+ ' - '
						+ Math.min((startIndex + incrementor),
								teamMembersData.length) + ' of '
						+ teamMembersData.length);
		var content = '';
		for (i = startIndex; i < noOfMembersToDisplay; i++) {
			content = '<tr class="table-row">'
					+ ' <td class="table-data"><img class="masthead" src="https://business.talentify.in/'+teamMembersData[i].picture+'"></td>'
					+ '<td class="table-data">'
					+ teamMembersData[i].name
					+ '</td>'
					+ '<td class="table-data">'
					+ teamMembersData[i].email
					+ '</td>'
					+ '<td class="table-data">'
					+ teamMembersData[i].mobile
					+ '</td>'
					+ '<td class="table-data">'
					+ teamMembersData[i].products
					+ '</td>'
					+ '<td class="table-data"><button type="button delete_user" style="background:transparent;border:0px" id='+teamMembersData[i].id+'><i  id='+teamMembersData[i].id+' class="fa  fa-times close-icon delete_user" aria-hidden="true"></i></button> </td>'
					+ '</tr>';
			tbody.append(content);
		}

	}

	$("#searchInput").keyup(
			function() {
				console.log($("#organization_id").val());

				if ($("#searchInput").val().length > 3) {
					$(".dropdown-content").empty();
					$(".dropdown-content").show();

					var organization_id = $("#organization_id").val();
					var team_id = $("#team_id").val();
					var organizationMembers
					$.get("/team?method=GET_ORGANIZATION_MEMEBERS&team_id="
							+ team_id + "&organization_id=" + organization_id
							+ "&pattern=" + $("#searchInput").val(), function(
							data) {
						organizationMembers = data;
						console.log(organizationMembers);
						appendOrgMembers(organizationMembers);

					});

				}

			});
	function appendOrgMembers(organizationMembers) {

		var orgMemDiv = $("#orgMembers")
		var content = '';
		for (i = 0; i < organizationMembers.length; i++) {

			content = '<div class="org-member-container" id="'+organizationMembers[i].id+'" ><img  class="org-image" src="https://business.talentify.in/'+organizationMembers[i].picture+'"><div class="org-member-name">'
					+ organizationMembers[i].name
					+ '</div> <input type="checkbox" name="orgMemChckBox" class="orgMemChckBox" value="'+organizationMembers[i].id+'"> <div class="clear-both"</div>'
			orgMemDiv.append(content);
		}
		
	}


	$(document).on(
			'click',
			'.orgMemChckBox',
			function() {
				var MemberId = $('.orgMemChckBox').val();
				var team_id = $("#team_id").val();

				$.get('/team?method=ADD_TEAM_MEMBER&team_id=' + team_id
						+ '&user_id=' + MemberId, function(data, status) {
					var memberContainer = $("#" + MemberId);
					memberContainer.remove();
					console.log(MemberId);
					genrateUserTable();
				});
			});

	$(document).click(
			function(event) {

				if (!$(event.target).closest('.dropdown-content ').length
						&& !$(event.target).closest('.orgMemChckBox').length) {
					$(".dropdown-content").hide();
				}

			});
	
	$('#update_team').click(
			function(event) {
				$.post('/team?method=UDPATE_TEAM&team_id=' +  $("#team_id").val(), 'name='+$('#name').val()+'&description='+$('#description').val(), function(result){
					console.log(result);
			    });
				console.log('aaa');

			});
	$('#create_team').click(
			function(event) {
				$.post('/team?method=CREATE_TEAM', 'name='+$('#name').val()+'&description='+$('#description').val()+'&organization_id='+$('#organization_id').val(), function(result){
					swal("Good job!", "You just created the team, lets just and add some members now!", "success").then(function(value) {
						 // redirect to edit team page
						 window.location.href='/SALES_MANAGER/create_team.jsp?team_id='+result;
					});;
			    });
				
			});
	
	
</script>