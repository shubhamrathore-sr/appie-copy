<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="ai.talentify.db.utils.DBUtils"%>
<%@page import="ai.talentify.services.LeadService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Sales Associate Lead List - Talentify</title>

<link rel="stylesheet" type="text/css"
	href="/assets/css/multipleleads_ass.css" />
<link rel="stylesheet" type="text/css" href="/assets/css/header.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<div class="main-header">
		<jsp:include page="/SALES_ASSOCIATE/inc/navbar.jsp"></jsp:include>
	</div>
<%
	// Give me a list of teams 
	HashMap<String, String> userData = (HashMap<String, String>)request.getSession().getAttribute("user");
	String managerID = userData.get("id");
	
%>

	<div class="main">
		<div class="main-container">
			<div class="head">
				<div class="sort">
					<form class="searchForm">
						<input type="text" class="search">
						<button type="submit" class="serach-btn">
							<i class="fa fa-search"></i>
						</button>
					</form>
					<select class="select">
						<option value="">Filter</option>
					</select> <select class="select">
						<option value="">Sort</option>
					</select>
				</div>
				
			</div>
			<div id="all-leads">
			</div>




			<!-- <button class="button" style="width: 200px;">Allocate Now</button> -->
			<div class="pagination-container">
				<div class="pagination-count">Showing 10 of 10000</div>
				<div class="pagination-btn-group">
					<button type="button" class="pagination-prev">Previous</button>
					<button type="button" class="pagination-next">Next</button>

				</div>
			</div>
		</div>
	</div>
</body>
<script>
//Start of carousel snippet
	function next(id) {
		var row = document.getElementById("slider_row" + id);
		sideScroll(row, 'right', 5, 250, 10);

	}
	function prev(id) {
		var row = document.getElementById("slider_row" + id);
		sideScroll(row, 'left', 5, 250, 10);

	}

	function sideScroll(element, direction, speed, distance, step) {
		scrollAmount = 0;
		var slideTimer = setInterval(function() {
			if (direction == 'left') {
				element.scrollLeft -= step;
			} else {
				element.scrollLeft += step;
			}
			scrollAmount += step;
			if (scrollAmount >= distance) {
				window.clearInterval(slideTimer);
			}
		}, speed);
	}
//end of carousel snippet

	var noOfMembersToDisplay = 10;
	var incrementor = noOfMembersToDisplay;
	var startIndex = 0;
	var leadDataGlobal;


	$(document)
			.ready(
					function() {
						// Handler for .ready() called. container lead_container

						$
								.get(
										"/leads?method=GET_LEADS_ASSOC&associateID=<%=managerID%>&offset=0&limit=10",
										function(data) {
											leadDataGlobal=data;
											generateLeadData(data);
										});
					});
	
	function fetchLeadData(){
		var manId=<%=managerID%>
		$.get("/leads?method=GET_LEADS&managerID="+manId+"&offset="+startIndex+"&limit="+incrementor+"",
				function(data) {
			console.log(data);
					generateLeadData(data);
					
				});
		
	}
	
	
	$(document).on('click', '.pagination-prev', function() {
		console.log("clicked-prev")

		if (startIndex >= incrementor) {
			startIndex = startIndex - incrementor
			noOfMembersToDisplay = noOfMembersToDisplay - incrementor;
			console.log("startIndex="+startIndex)

			fetchLeadData()
			//generateDataOnPaging(teamMembersData);
		}
	})

	$(document).on('click', '.pagination-next', function() {
		console.log("clicked-next")

		//if ((startIndex + incrementor) < leadDataGlobal.length) {
			startIndex = startIndex + incrementor;
			noOfMembersToDisplay = noOfMembersToDisplay + incrementor;
			console.log("startIndex="+startIndex)

			fetchLeadData()

			//generateDataOnPaging(teamMembersData);
		//}

	})
	
	

	function generateLeadData(data) {
		$('#all-leads').empty();
		for (var i = 0; i < data.length; i++) {

			
			

			var leadContainer = '<div class="container lead_container" id="'+data[i].leadid+'">'
					+ '<div style="width: 50%; margin-top: 25px;">'
					+ '<h3 class="company_name" title="'+data[i].company_name+'">'
					+ data[i].company_name.substring(0, 10)
					+ '</h3>'
					+ '<div class="slider-container">'
					+

					'<button type="button"'
					+ 'style="background: transparent; border: none;"'
					+ 'onclick="prev('
					+ data[i].leadid
					+ ')" id="prev_'
					+ data[i].leadid
					+ '">'
					+ '<i class="fa fa-angle-left prev-icon"></i>'
					+ '</button>'
					+

					'<div class="slider" id="slider_row'+data[i].leadid+'">'
					+

					'<div class="flex" id="sales-contact-person_'+data[i].leadid+'">'
					+ '</div>'
					+

					'<div class="last"></div>'
					+ '</div>'
					+

					'<button type="button"'
					+ 'style="background: transparent; border: none;"'
					+ 'onclick="next('
					+ data[i].leadid
					+ ')" id="next_'
					+ data[i].leadid
					+ '">'
					+ '<i class="fa fa-angle-right next-icon"></i>'
					+ '</button>' +

					'</div>' + '</div>' +

					'<div id="'+ data[i].leadid+'" class="container-2" ></div>' + '</div>';
					
					
			$("#all-leads").append(leadContainer);
			
			generateSalesContactPerson(data[i].sales_contact_persons,data[i].leadid);

		}
	}

	function generateSalesContactPerson(persons,leadid) {
		var salesContactPersons = JSON.parse(persons);

		
							
						
							//console.log(data.length);
							for (i = 0; i < salesContactPersons.length; i++) {

								var person = '<div class="child-container slide sales-contact-person" id="'+salesContactPersons[i].id+'">'
										+ '<h3 class="user-name" title="'+salesContactPersons[i].personName+'">'
										+ salesContactPersons[i].personName.substring(0, 10)
										+ '</h3>'
										+ '<p class="phone-number">'
										+ salesContactPersons[i].personEmail
										+ '</p>'
										+ '<p style="margin: 4%;">'
										+ salesContactPersons[i].personMobile
										+ '</p>' + '</div>';
										$('#sales-contact-person_'+leadid).append(person);
							}

		
		 $( ".lead_container" ).each(function( index ) {
		$.get("/leads?method=GET_LEAD_DETAILS&leadID="+leadid, function(data) {
			//console.log('#'+leadId + ' .container-2');
			$('#'+leadid + '.container-2').replaceWith((data));
		});
	
	});  

	}
</script>

</html>