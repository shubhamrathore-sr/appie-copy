<%@page import="ai.talentify.services.PipelineService"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="keywords" content="HTML,CSS,XML,JavaScript">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="/assets/css/editPipeline.css" />
<link rel="stylesheet" type="text/css" href="/assets/css/header.css" />
<link rel="stylesheet" type="text/css" href="/assets/css/styles.css" />


<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="../assets/js/showMenu.js"></script>
</head>
<body>
	<div class="main-header">
		<jsp:include page="/SALES_MANAGER/inc/navbar.jsp"></jsp:include>
	</div>
	<%
		HashMap<String, String> userData = (HashMap<String, String>) request.getSession().getAttribute("user");
		String managerID = userData.get("id");
		if (request.getParameterMap().containsKey("pipeline_id")) {

			PipelineService service = new PipelineService();
			String pipelineId = request.getParameter("pipeline_id").toString();
			ArrayList<HashMap<String, String>> pipelineArray = service.getPipelineDetails(pipelineId);
			HashMap<String, String> pipeline = pipelineArray.get(0);
	%>
	<div class="container" id="pipeline_id_<%=pipeline.get("id")%>>">
		<input type="hidden" id="pipeId" value="<%=pipeline.get("id")%>">
		<div class="btn-container">
			<div style="width: 70%">
				<a href="pipeline.jsp"><i class="material-icons"> arrow_back
				</i></a>
			</div>
			<div style="display: flex; width: 70%; justify-content: flex-end">
				<button class="button">Add Team</button>
				<button class="button">Add Products</button>
			</div>
		</div>
		<div class="content-container">
			<div class="content">
				<div class="pipe-desc">
					<label class="pipeline-label font-20x">Pipeline Name:</label>
					<div class="pipeline-name" contenteditable="true"><%=pipeline.get("name")%></div>
				</div>

				<div class="pipe-card-container">
					<%
						ArrayList<HashMap<String, String>> stages = service.getStages(pipeline.get("id"));

							for (HashMap<String, String> stage : stages) {
								ArrayList<HashMap<String, String>> stageTasks = service.getStageTasks(stage.get("id"));
					%>
					<div class="pipe-card" id="stage_id_<%=stage.get("id")%>">
						<div class="icon-container">
							<%
								for (HashMap<String, String> task : stageTasks) {
							%>
							<%
								switch (task.get("task_type")) {
												case "SALES_CALL_TASK" :
							%>
							<div class="phone pipe-logo">
								<i class="fa fa-phone" aria-hidden="true"></i>
							</div>
							<%
								break;
												case "SALES_WEBINAR_TASK" :
							%>
							<div class="queue pipe-logo">
								<i class="material-icons pipe-icon "> add_to_queue </i>
							</div>
							<%
								break;
												case "SALES_EMAIL_TASK" :
							%>
							<div class="email pipe-logo">
								<i class="fa fa-envelope" aria-hidden="true"></i>
							</div>
							<%
								break;
												case "SALES_PRESENTATION_TASK" :
							%>
							<div class="desktop pipe-logo">
								<i class="fa fa-desktop"></i>
							</div>
							<%
								break;
												case "SALES_MEETING_TASK" :
							%>

							<div class="group pipe-logo">
								<i class="material-icons pipe-icon ">group</i>
							</div>
							<%
								break;
											}
										}
							%>

						</div>
						<div class="pipe">
							<div class="line-content">
								<i></i> <i class="round fa fa-circle "></i> <i
									class="arrow fa fa-angle-right fa-3x"></i>
							</div>
							<div>
								<p class="pipe-text"><%=stage.get("stage_name")%></p>
							</div>
						</div>
					</div>

					<%
						}
					%>

				</div>

				<div>
					<div class="pipe-holder">
						<p class="category">Team:</p>
						<div class="labels">
							<div class="label label-1">
								<div>Sales Team 1</div>
								<i class="material-icons cross-icon"> close </i>
							</div>
						</div>
					</div>
					<div class="pipe-holder">
						<p class="category">Products:</p>
						<div class="labels">
							<div class="label label-2">
								<div>Talentify Sales Intelligence</div>
								<i class="material-icons cross-icon"> close </i>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="pipeline">
			<div class="table">

				<div class="cardsContainer">
					<%
						for (HashMap<String, String> stage : stages) {
								ArrayList<HashMap<String, String>> stageTasks = service.getStageTasks(stage.get("id"));
					%>

					<div class="column">
						<div class="headerDiv">

							<a class="names stage-name" id="<%=stage.get("id")%>"
								contenteditable="true"><%=stage.get("stage_name")%></a>

							<div class="remove">
								<button type="button" class="button-transparent"
									onclick="removeStage(<%=stage.get("id")%>)">
									<i class="material-icons remove-icon font-17 text-muted">
										close </i>
								</button>
							</div>
						</div>
						<div class="add-card ">
							<button type="button" class="button-transparent"
								onclick="addTask(<%=stage.get("id")%>)">
								<i class="material-icons add-task-icon  mt-1"> add </i>
							</button>
						</div>
						<div class="cards" id="task_cards_<%=stage.get("id")%>">
							<%
								for (HashMap<String, String> task : stageTasks) {

											switch (task.get("task_type")) {
												case "SALES_CALL_TASK" :
							%>
							<div class="card" id="task_id_<%=task.get("id")%>">
								<div class="cardHead call-card">
									<button type="button" class="button-transparent flex"
										onclick="removeTask(<%=task.get("id")%>)">
										<i
											class=" green material-icons font-17 text-muted webinar_icon_color">
											close </i>
									</button>
									<p class="green">
										<b>Call</b>
									</p>
									<div style="position: relative;"
										id="toggle_task_<%=task.get("id")%>">
										<button type="button" class="button-transparent flex"
											onclick="toggleTaskList(<%=task.get("id")%>)">
											<i class="fa green fa-phone"></i>
										</button>

									</div>
								</div>
								<div class="cardDesc">
									<p class="card-description" id="<%=task.get("id")%>"
										contenteditable="true"><%=task.get("description")%></p>
								</div>
							</div>

							<%
								break;
												case "SALES_PRESENTATION_TASK" :
							%>
							<div class="card" id="task_id_<%=task.get("id")%>">
								<div class="cardHead presentation-card">
									<button type="button" class="button-transparent flex"
										onclick="removeTask(<%=task.get("id")%>)">

										<i
											class="blue material-icons font-17 text-muted webinar_icon_color">
											close </i>
									</button>
									<p class="blue">
										<b>Presentation</b>
									</p>
									<div style="position: relative;"
										id="toggle_task_<%=task.get("id")%>">
										<button type="button" class="button-transparent flex"
											onclick="toggleTaskList(<%=task.get("id")%>)">

											<i class="blue fa fa-desktop"></i>
										</button>
									</div>
								</div>

								<div class="cardDesc">
									<p class="card-description" id="<%=task.get("id")%>"
										contenteditable="true"><%=task.get("description")%>
									</p>
								</div>

							</div>

							<%
								break;
												case "SALES_EMAIL_TASK" :
							%>
							<div class="card" id="task_id_<%=task.get("id")%>">
								<div class="cardHead email-card">
									<button type="button" class="button-transparent flex"
										onclick="removeTask(<%=task.get("id")%>)">
										<i
											class="red material-icons font-17 text-muted webinar_icon_color">
											close </i>
									</button>
									<p class="red">
										<b>Email</b>
									</p>
									<div style="position: relative;"
										id="toggle_task_<%=task.get("id")%>">
										<button type="button" class="button-transparent flex"
											onclick="toggleTaskList(<%=task.get("id")%>)">
											<i class="red fa fa-envelope"></i>
										</button>
									</div>
								</div>

								<div class="cardDesc">
									<p class="card-description" id="<%=task.get("id")%>"
										contenteditable="true"><%=task.get("description")%></p>
								</div>

							</div>

							<%
								break;
												case "SALES_WEBINAR_TASK" :
							%>
							<div class="card" id="task_id_<%=task.get("id")%>">
								<div class="cardHead webinar-card">
									<button type="button" class="button-transparent flex"
										onclick="removeTask(<%=task.get("id")%>)">
										<i
											class="purple material-icons font-17 text-muted webinar_icon_color">
											close </i>
									</button>
									<p class="purple">
										<b>webinar</b>
									</p>
									<div style="position: relative;"
										id="toggle_task_<%=task.get("id")%>">
										<button type="button" class="button-transparent flex"
											onclick="toggleTaskList(<%=task.get("id")%>)">
											<i class="material-icons purple "> add_to_queue </i>
										</button>
									</div>
								</div>
								<div class="cardDesc">
									<p class="card-description" id="<%=task.get("id")%>"
										contenteditable="true"><%=task.get("description")%></p>
								</div>
							</div>

							<%
								break;
												case "SALES_MEETING_TASK" :
							%>
							<div class="card" id="task_id_<%=task.get("id")%>">
								<div class="cardHead group-card">
									<button type="button" class="button-transparent flex"
										onclick="removeTask(<%=task.get("id")%>)">
										<i
											class="light-green material-icons font-17 text-muted webinar_icon_color">
											close </i>
									</button>
									<p class="light-green">
										<b>Meeting</b>
									</p>
									<div style="position: relative;"
										id="toggle_task_<%=task.get("id")%>">
										<button type="button" class="button-transparent flex"
											onclick="toggleTaskList(<%=task.get("id")%>)">
											<i class="material-icons light-green ">group</i>
										</button>
									</div>
								</div>
								<div class="cardDesc">
									<p class="card-description" id="<%=task.get("id")%>"
										contenteditable="true"><%=task.get("description")%></p>
								</div>
							</div>
							<%
								break;
												default :
													break;
											}
							%>
							<%
								}
							%>
						</div>

					</div>




					<%
						}
					%>
				</div>
				<div class="column columnLast">
					<div class="add-container ">
						<button type=button class="button-transparent"
							onclick="addStage()">
							<i class="material-icons add-column text-danger mt-1 font-38 ">
								add_circle </i>
						</button>

					</div>
				</div>
			</div>

		</div>
	</div>
	<%
		} else {
	%>

	<div class="container">
		<input id="managerId" type="hidden" value="<%=managerID%>">
		<div class="btn-container">
			<div style="width: 70%">
				<a href="pipeline.jsp"><i class="material-icons"> arrow_back
				</i></a>
			</div>
			<div style="display: flex; width: 70%; justify-content: flex-end">
				<button class="button">Add Team</button>
				<button class="button">Add Products</button>
			</div>
		</div>
		<div class="content-container">
			<div class="content">
				<div class="pipe-desc">
					<label class="pipeline-label font-20x">Pipeline Name:</label>
					<div class="create-pipeline-name" contenteditable="true">Enter
						Pipeline name</div>
				</div>
				<div class="pipe-card-container"></div>
				<div>
					<div class="pipe-holder">
						<p class="category">Team:</p>
					</div>
					<div class="pipe-holder">
						<p class="category">Products:</p>
					</div>
				</div>
			</div>
			<div class="pipeline">
				<div class="table">
					<div class="cardsContainer"></div>
					<div class="column columnLast">
						<div class="add-container ">
							<button type=button class="button-transparent">
								<i class="material-icons add-column text-danger mt-1 font-38 ">
									add_circle </i>
							</button>

						</div>
					</div>
				</div>
			</div>

		</div>



	</div>
	<%
		}
	%>
</body>
<script>
	var pipeId = $('#pipeId').val();
	var call="SALES_CALL_TASK";
	var email="SALES_EMAIL_TASK";
	var meeting="SALES_MEETING_TASK";
	var presentation="SALES_PRESENTATION_TASK";
	var webinar="SALES_WEBINAR_TASK";
	
	
	function addStage() {

		console.log(pipeId);
		$.post('/pipeline?method=ADD_STAGE&pipelineId=' + pipeId, function(
				result) {
			console.log(result);
			window.location.reload();

		});
	}
	
	function addTask(stageId){
		console.log(stageId);
		
		var neg=-Math.abs(stageId);
		var defaultcard='<div class="card">'+
		'<div class="cardHead call-card">'+
		'<i class=" green material-icons font-17 text-muted webinar_icon_color">close </i>'+
		'<p class="green"><b>Select Task</b></p>'+
		'<div style="position: relative;"id="toggle_task_'+neg+'">'+
			'<button type="button" class="button-transparent flex"'+
				'onclick="toggleTaskList('+neg+')">'+
		'<i class="material-icons green ">list</i>'+
		'</button>'+
		'</div>'+
		'</div>'+
		'<div class="cardDesc"><p>description</p></div>'+
		'</div>';
		$( "#task_cards_"+stageId ).append( defaultcard );
	}
	
	function toggleTaskList(taskId){
		
		if($('#popover_'+taskId).length){
			$('#popover_'+taskId).remove();
			
		}else{
		
		var tasklistpopover='<div id="popover_'+taskId+'" class="task-list-popover">'+
								'<div class="arrow-up">'+
									'<div class="inner-traingle"></div>'+
								'</div>'+
								'<div class="popover-body">'+
									'<button type="button" class="button-transparent flex" onclick="changeTask('+taskId+',\''+call+'\')">'+
										'<i class="fa green fa-phone"></i>'+
									'</button>'+
									'<button type="button" class="button-transparent flex" onclick="changeTask('+taskId+',\''+presentation+'\')">'+
										'<i class="blue fa fa-desktop"></i>'+
									'</button>'+
									'<button type="button" class="button-transparent flex" onclick="changeTask('+taskId+',\''+email+'\')">'+
										'<i class="red fa fa-envelope"></i>'+
									'</button>'+
									'<button type="button" class="button-transparent flex" onclick="changeTask('+taskId+',\''+webinar+'\')">'+
										'<i class="material-icons purple "> add_to_queue </i>'+
									'</button>'+
									'<button type="button" class="button-transparent flex" onclick="changeTask('+taskId+',\''+meeting+'\')">'+
										'<i class="material-icons light-green ">group</i>'+
									'</button>'+
								'</div>'+
							'</div>';


	$('#toggle_task_'+taskId).append(tasklistpopover);
		}
		
	}
	function removeStage(stageId){
		console.log(stageId);
		$.post('/pipeline?method=DELETE_STAGE&stageId=' + stageId, function(
				result) {
			console.log(result);
			window.location.reload();
		});
	}
	
	function removeTask(taskId){
		console.log(taskId);
		$.post('/pipeline?method=DELETE_TASK&taskId=' + taskId, function(
				result) {
			console.log(result);
			window.location.reload();
		});
	}
	
	function changeTask(taskId,tasktype){
		console.log(taskId);
		console.log(tasktype);
		if(taskId>0){
		$.post('/pipeline?method=CHANGE_TASKTYPE&taskId=' + taskId+'&taskType='+tasktype, function(
				result) {
			console.log(result);
			window.location.reload();

		});
		}else{
			stageId=Math.abs(taskId);
			$.post('/pipeline?method=ADD_TASK&stageId=' + stageId+'&taskType='+tasktype, function(
					result) {
				console.log(result);
				window.location.reload();

			});

		}
		
		
	}
	
	
	//this snippet will blur the elemnets on enter and esc key
	$(" .pipeline-name, .stage-name,.card-description ,.create-pipeline-name").bind("keydown", function(event) {
	    var target = $(event.target);
	    c = event.keyCode;
	    
	    if(c === 13 || c === 27) {
	        $(this).blur();
	    }
	});	
	
	//this snippet will check when focus is out
	//and saves the data
	$('.stage-name').on('focusout', function() {
	    var stageId=$(this).attr('id')
	    var stageName=$(this).text();
	    $.post('/pipeline?method=CHANGE_STAGE_NAME&stageId=' + stageId+'&stageName='+stageName, function(
			result) {
		});	
	});
	
	$('.pipeline-name').on('focusout', function() {
	    var pipelineName=$(this).text();
	    $.post('/pipeline?method=CHANGE_PIPELINE_NAME&pipelineId=' + pipeId+'&pipelineName='+pipelineName, function(
				result) {
		});	
	 });
	
	
	$('.card-description').on('focusout', function() {
	    var taskId=$(this).attr('id')
	    var description=$(this).text();
	    $.post('/pipeline?method=CHANGE_CARD_DESCRIPTION&taskId=' + taskId+'&description='+description, function(
			result) {
		});	
	 });
	
	
	$('.create-pipeline-name').on('focusout', function() {
	    var pipelineName=$(this).text();
	    var managerId=$('#managerId').val();
	   $.post('/pipeline?method=CREATE_PIPELINE&managerId=' + managerId+'&pipelineName='+pipelineName, function(
		pipelineId) {
			//redirect to edit pipeline
			window.location.href = '/SALES_MANAGER/create_pipeline.jsp?pipeline_id='+pipelineId;

		});	
	 });



</script>
</html>