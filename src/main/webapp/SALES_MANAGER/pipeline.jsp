<%@page import="ai.talentify.services.PipelineService"%>
<%@page import="java.util.*"%>
<%@page import="ai.talentify.services.TeamService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%><!DOCTYPE html>
<html>
<head>
<title>Pipeline</title>
<meta charset="UTF-8">
<meta name="keywords" content="HTML,CSS,XML,JavaScript">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="/assets/css/pipeline.css" />
<link rel="stylesheet" type="text/css" href="/assets/css/styles.css" />
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/assets/css/header.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

</head>

<body>
	<div class="main-header">
		<jsp:include page="/SALES_MANAGER/inc/navbar.jsp"></jsp:include>

	</div>
	<div class="main">
		<div class="container">
			<div class="btn-container">
				<a style="text-decoration: none; color: white"
					href="/SALES_MANAGER/create_pipeline.jsp" class="button">New
					Pipeline</a>
			</div>
			<%
				HashMap<String, String> userData = (HashMap<String, String>) request.getSession().getAttribute("user");
				String managerID = userData.get("id");
			%>
			<input type="hidden" id="managerId" value=<%=userData.get("id")%>>
			<div class="pipeline-container"></div>

		</div>
	</div>

</body>
<script>
	function deletePipeline(pipelineId) {
		$.get("/pipeline?method=DELETE_PIPELINE&pipelineId=" + pipelineId,
				function(data) {
					console.log("deleted");
					location.reload();

				});
	}

	$(document).ready(
			function() {
				var managerId = $('#managerId').val();
				$.get("/pipeline?method=GET_ALL_PIPELINES&managerId="
						+ managerId, function(data) {
					generatePipelines(data)
				});

			});

	function generatePipelines(data) {
		//iterate over pipeline container
		for (var i = 0; i < data.length; i++) {
			//console.log(data[i].name)
			//Do something

			var pipelinehtml = '<div class="content-container">'
					+ '<div class="content" id="pipeline_id_'+data[i].id+'">'
					+ '<div class="pipe-holder">'
					+ '<div class="pipename">'
					+ data[i].name
					+ '</div>'
					+ '<div class="position-relative">'
					+ '<button type="button" class="button-transparent "onclick="editPipeline('
					+ data[i].id
					+ ')">'
					+ '<i class="fa fa-edit edit-icon"></i>'
					+ '</button>'
					+ '<button type="button" class="button-transparent "onclick="deletePipeline('
					+ data[i].id
					+ ')">'
					+ '<i class="fa fa-trash pointer delete-icon"></i>'
					+ '</button>'
					+ '</div>'
					+ '</div>'
					+ '<div class="pipeline-stage-container stage-container-'+data[i].id+'">'
					+
					//iterate over stage 
					'</div>' + '</div>' + '</div>';

			//append pipelinehtml 
			$(".pipeline-container").append(pipelinehtml);
			//calling stage generator

			var stages = JSON.parse(data[i].stagedetails);
			generateStages(stages, data[i].id)

		}
	}

	function generateStages(stages, pipelineId) {

		for (var i = 0; i < stages.length; i++) {

			var stagehtml = '<div class="pipeline-stage" id="stage_id_'+stages[i].stage_id+'">'
					+ '<div class="icon-container task-container-'+stages[i].stage_id+'">'
					+
					//iterate over stage tasks and icon based on task type

					'</div>'
					+ '<div class="pipeline-line">'
					+ '<i class="round fa fa-circle "></i> <i class="arrow fa fa-angle-right "></i>'
					+ '</div>'
					+ '<div class="tags">'
					+ '<p class="tag">'
					+ stages[i].stage_name + '</p>' + '</div>' + '</div>';

			//append stagehtml to pipeline-stage-container
			$(".stage-container-" + pipelineId).append(stagehtml);
			//calling to generate tasks
			var tasks = stages[i].stage_tasks;
			generateTasks(tasks, stages[i].stage_id);

		}

	}

	function generateTasks(tasks, stageId) {

		var calliconhtml = '<div class="phone icon">'
				+ '<i class="fa fa-phone" aria-hidden="true"></i>' + '</div>';

		var presentationhtml = '<div class="desktop pipe-logo">'
				+ '<i class="fa fa-desktop"></i>' + '</div>';

		var emailhtml = '<div class="message icon">'
				+ '<i class="fa fa-envelope" aria-hidden="true"></i>'
				+ '</div>';

		var webinarhtml = '<div class="queue pipe-logo">'
				+ '<i class="material-icons pipe-icon "> add_to_queue </i>'
				+ '</div>';

		var meetinghtml = '<div class="group pipe-logo">'+
			'<i class="material-icons pipe-icon ">group</i>'+
			'</div>';

		for (var i = 0; i < tasks.length; i++) {

			switch (tasks[i].task_type) {
			case "SALES_CALL_TASK":
				// append iconhtml to icon-container
				$(".task-container-" + stageId).append(calliconhtml);

				break;
			case "SALES_MEETING_TASK":
				// append iconhtml to icon-container
				$(".task-container-" + stageId).append(meetinghtml);

				break;
			case "SALES_WEBINAR_TASK":
				// append iconhtml to icon-container
				$(".task-container-" + stageId).append(webinarhtml);

				break;
			case "SALES_EMAIL_TASK":
				// append iconhtml to icon-container
				$(".task-container-" + stageId).append(emailhtml);

				break;
			case "SALES_PRESENTATION_TASK":
				// append iconhtml to icon-container
				$(".task-container-" + stageId).append(presentationhtml);
				break;
			default:

			}

		}
	}

	function editPipeline(pipelineId) {
		window.location.href = '/SALES_MANAGER/create_pipeline.jsp?pipeline_id='
				+ pipelineId;

	}
</script>

</html>