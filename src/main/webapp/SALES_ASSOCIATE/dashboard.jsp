<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*"%>
<%@page import="ai.talentify.services.associate.Dashboard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Sales Associate Dashboard - Talentify</title>
<link rel="stylesheet" type="text/css" href="/assets/css/assdashboard.css" />
<link rel="stylesheet" type="text/css" href="/assets/css/header.css" />
<link rel="stylesheet" type="text/css" href="/assets/css/styles.css" />

<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdn.rawgit.com/nnattawat/flip/master/dist/jquery.flip.min.js"></script>
<script src="/assets/js/twilio.js"></script>

</head>
<body>
	<div class="main-header">
		<jsp:include page="/SALES_ASSOCIATE/inc/navbar.jsp"></jsp:include>
	</div>

	<div class="main">
		<div class="container">
			<div class="top-container">
				<div class="head">
					<p class="heading">Today's Tasks</p>
				</div>
				<button class="button-transparent">
					<div class="arrow arrow-left">
						<i class="material-icons" onclick="showDivs(-3)">arrow_back_ios</i>
					</div>
				</button>
				<button class="button-transparent">
					<div class="arrow arrow-right">
						<i class="material-icons" onclick="showDivs(3)">arrow_forward_ios</i>
					</div>
				</button>
				<div class="cardsContainer">
					<div class="card">
						<div class="card-field">
							<div class="card-head">
								<div class="head-flex">
									<div class="activity">TODAY'S ACTIVITY</div>
									<div class="tasks">0 Tasks Completed</div>
								</div>
							</div>
							<div class="card-body"></div>
							<div class="card-bottom">
								<div class="complete-task-icon">
									<i class="material-icons font-22 complete-task-circle">fiber_manual_record </i>
								</div>
								<div class="task-remains">4 Tasks remaining for the day</div>
							</div>
						</div>
					</div>

					<%
						HashMap<String, String> userData = (HashMap<String, String>) request.getSession().getAttribute("user");
						Dashboard dashboard = new Dashboard();
						List<HashMap<String, String>> data = dashboard.getTodaysTasks(Integer.parseInt(userData.get("id")));
						for (HashMap<String, String> card : data) {
							String imageURL = "https://business.talentify.in/users/" + card.get("contact_name").substring(0, 1)
									+ ".png";
					%>

					<div class="card task_card" id="<%=card.get("task_id")%>">


						<div class="card-field front">
							<div class="name">
								<div class="highlight"><%=card.get("company_name")%></div>
							</div>
							<div class="name-dat"><%=card.get("contact_name")%></div>
							<div class="name-logo">
								<img class="img-fluid" src="<%=imageURL%>" alt="<%=card.get("contact_name")%>">
							</div>

							<div class="task-history">
								<div class="task-heading ">Task History</div>
								<div class="task-details history">
									<!-- <div class="task-details-row">
										<div>
											<i class="material-icons call-icon"> phone </i>
										</div>
										<div class="task-date">30/11/2018 02:41 PM</div>
									</div>

									<div class="task-details-row">
										<div>
											<i class="material-icons call-icon"> phone </i>
										</div>
										<div class="task-date">30/11/2018 02:41 PM</div>
									</div> -->
								</div>
							</div>


							<div class="task-history" style="overflow: auto;">
								<div class="task-heading last_action_details">Last Action Items</div>
								<!-- 								<div class="task-details-text task-details-row">Customer must have made payment was on the payment page but wanted to do it alone</div>
 -->
							</div>

							<div class="call-btn-container">
								<button class="call-btn make-call" data-task_id='<%=card.get("task_id")%>' data-customer_phone='<%=card.get("contact_number")%>' data-agent_number='<%=card.get("agent_mobile")%>'>
									<i class="material-icons call-btn-icon"> phone </i>CALL
									<!-- <div>CALL</div> -->
								</button>
							</div>
						</div>

						<div class="card-flip back">
							<div class="call-detail">
								<div class="text-box">
									<textarea id='call_notes_<%=card.get("task_id")%>' placeholder="Call Notes..."></textarea>
								</div>
								<div class="star-box">
									<div class="stars">
										<span class="star-inserted" style="cursor: pointer;"> <!---->★
										</span> <span class="star-inserted" style="cursor: pointer;"> <!---->★
										</span> <span class="star-inserted" style="cursor: pointer;"> <!---->★
										</span> <span class="star-inserted" style="cursor: pointer;"> <!---->★
										</span> <span class="star-inserted" style="cursor: pointer;"> <!---->★
										</span>
									</div>
									<div class="check">
										<input type="checkbox"> <label>Next Stage</label>
									</div>
								</div>
								<div class="select-box">
									<select class="common">
										<option>Call</option>
									</select> <select class="common followup_products_<%=card.get("task_id")%>">
										<option>India Insurance Product</option>
									</select> <select class="common followup_members_<%=card.get("task_id")%>">
										<option>Abhinav Singh</option>
									</select>
									<div class="date-time">
										<input type="date" value="<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>" class="date common followup_date_<%=card.get("task_id")%>" id='followup_date_<%=card.get("task_id")%>'>
										<input type="time" value="<%=new SimpleDateFormat("HH:mm:ss").format(new Date())%>" class="time common followup_time_<%=card.get("task_id")%>" id='followup_time_<%=card.get("task_id")%>'>
									</div>
								</div>
								<div class="btn-box">
									<button class="call-btn call-option hangup">Hang Up</button>
									<button class="call-btn call-option redial" data-task_id='<%=card.get("task_id")%>' data-customer_phone='<%=card.get("contact_number")%>' data-agent_number='<%=card.get("agent_mobile")%>'>Redial</button>
									<button class="call-btn call-option cancel" data-task_id='<%=card.get("task_id")%>'>Cancel</button>
								</div>
								<div class="volume-indicators" id="volume-indicators_<%=card.get("task_id")%>">
									<label>Mic Volume</label>
									<div class="input-volume" id="input-volume_<%=card.get("task_id")%>"></div>
									<label>Speaker Volume</label>
									<div class="output-volume" id="output-volume_<%=card.get("task_id")%>"></div>
								</div>
								<div class="call-duration" id="call-duration_<%=card.get("task_id")%>">
									<i class="material-icons dur-call"> phone </i>
									<div class="duration">
										Call duration <span id="call-duration-value_<%=card.get("task_id")%>">2.038</span> seconds
									</div>
								</div>
								<div class="submit-btn-container" data-task_id="">
									<button class="call-btn" data-task_id='<%=card.get("task_id")%>' onclick="submitCallTask(<%=card.get("task_id")%>)">SUBMIT</button>
								</div>
							</div>
						</div>
					</div>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript">
$(document).ready(function(){
	 $.get("/assoc?method=TWILIO_TOKEN&task_id="
				+ 123, function(data) {
		 console.log('Token: ' + data.token);
		 Twilio.Device.setup(data.token);
	 });
});

$(".task_card").flip({
  trigger: 'manual'
});

$( ".make-call" ).click(function() {
	var currentElement = $(this).data("task_id");  
	console.log(currentElement);
	$("#"+currentElement).flip(true);
	prefillFlipCardData(currentElement);
	placeCall($(this).data('customer_phone'), currentElement);
});
$('.redial').click(function(){
	var currentElement = $(this).data("task_id");  
	placeCall($(this).data('customer_phone'), currentElement);
});
$( ".cancel" ).click(function() {
	var currentElement = $(this).data("task_id");  
	console.log(currentElement);
	$("#"+currentElement).flip(false);
});
// This is the bit where We fill in tash history and last action 
$( ".task_card" ).each(function() {
	var currentElement = $(this).attr("id");
	
	$.get("/assoc?method=GET_TASK_HISTORY&task_id="
			+ currentElement, function(data) {
		//console.log(data);
		if(data.length>0) {
		for (var i = 0; i < data.length; i++){
		   //console.log(data[i]);
		   
		   var taskHistory ='<div class="task-details-row"><div><i class="material-icons call-icon"> phone </i></div><div class="task-date">'+data[i].updated_at+'</div></div>';
		   $('#'+currentElement+' .task-details').append(taskHistory);
		  
		   
		   var last_comment='<div class="task-details-text task-details-row">'+data[i].string_agg+'</div>';
		   $('#'+currentElement+' .last_action_details').append(last_comment);
		}
		} else {
			var taskHistory ='<div class="task-details-row"><div></div><div class="task-date">No Task History</div></div>';
			   var last_comment='<div class="task-details-text task-details-row">No Task Comments</div>';

			   //$('#'+currentElement+' .task-details').append(taskHistory);
			  // $('#'+currentElement+' .task-heading').append(last_comment);
		}
	});
});

var slideIndex = 0;

var x = document.getElementsByClassName("card");
for (let i = 0; i < x.length; i++)
    x[i].style.display = "none";
for (let i = 0; i < 3; i++)
    x[i].style.display = "block";


function showDivs(n) {
    var x = document.getElementsByClassName("card");
    if (slideIndex + n < x.length && slideIndex + n >= 0) {
        slideIndex += n;
        console.log("in if")
        for (let i = 0; i < x.length; i++)
            x[i].style.display = "none";

        for (i = slideIndex; i < slideIndex + 3; i++)
            x[i].style.display = "block";
    }
    console.log("slide =" + slideIndex)
}

prefillFlipCardData = function(taskId) { 
	$.get("/assoc?method=GET_FOLLOW_UP_TASK_DETAILS&task_id="
			+ taskId, function(data) {
		if(data.products.length>0) {
			var select = $('.followup_products_'+taskId)[0];
			var options = '';
			for (var i = 0; i < data.products.length; i++){
		   		options+='<option data-product_id="'+
		   		data.products[i].id
		   		+'">'+data.products[i].name+'</option>'
			}
			$(select).html(options);
		}
		if(data.reportees.length>0) {
			var select = $('.followup_members_'+taskId)[0];
			var options = '';
			for (var i = 0; i < data.reportees.length; i++){
		   		options+='<option data-member_id="'+
		   		data.reportees[i].id
		   		+'">'+data.reportees[i].name+'</option>'
			}
			$(select).html(options);
		}
				
	});
};
placeCall = function(customerPhone, taskId){
	var start = new Date().getTime();
	var connectedTime = new Date().getTime();
	console.log('Placeing call to: '+customerPhone);
    // First we check if the user has microphone and gives us permissions for the same
	navigator.mediaDevices.getUserMedia({ audio: true })
     .then(function (stream) {
       let tracks = stream.getTracks();
       tracks.forEach(function (track) {
         track.stop();
       });
       var outputVolumeBar = document.getElementById('output-volume_'+taskId);
       var inputVolumeBar = document.getElementById('input-volume_'+taskId);
       var volumeIndicators = document.getElementById('volume-indicators_'+taskId);
       // If we have received the permission we then fetch the token for twilio
      
		var options = {
		        To: customerPhone, record: 'record-from-answer-dual', enableRingingState: true
		};
		var connection = Twilio.Device.connect(options);
		//window.myVar = setInterval(function(){ console.log('Connection status: '+connection.status()); }, 300);
		Twilio.Device.ready(function (device) {
			console.log('Twilio.Device Ready!');
		});
		Twilio.Device.on('error',  function (error) {
			console.log('Twilio.Device Error: ' + error.message);
		});
		Twilio.Device.on('connect', function (conn) {
			connectedTime = new Date().getTime();
			console.log('Successfully established call in '+(connectedTime-start)+'ms!');
			volumeIndicators.style.display = 'block';
			document.getElementById('call-duration_'+taskId).style.display = 'none';
			bindVolumeIndicators(conn, outputVolumeBar, inputVolumeBar, volumeIndicators);
		});
		Twilio.Device.on('accept', function (conn) {
			var acceptedTime = new Date().getTime();
			console.log('Successfully acce[pted call in '+(acceptedTime-start)+'ms!');
		});
        Twilio.Device.on('disconnect', function (conn) {
			var disconnectedTime = new Date().getTime();
			console.log('start '+(start)+'ms!');
			console.log('connectedTime '+(connectedTime)+'ms!');
			console.log('disconnectedTime '+(disconnectedTime)+'ms!');
			console.log('Spoke for '+(disconnectedTime - connectedTime)+'ms!');
			console.log('Call ended.');
        	console.log(conn);
			volumeIndicators.style.display = 'none';	
			document.getElementById('call-duration-value_'+taskId).innerText = (disconnectedTime - connectedTime)/1000;
			document.getElementById('call-duration_'+taskId).style.display = 'block';
		});

     });
    $('.hangup').click(function() {
		console.log('Hanging up...');
		Twilio.Device.disconnectAll();
	});
};

function bindVolumeIndicators(connection, outputVolumeBar, inputVolumeBar, volumeIndicators) {
    connection.volume(function(inputVolume, outputVolume) {
      var inputColor = 'red';
      if (inputVolume < .50) {
        inputColor = 'green';
      } else if (inputVolume < .75) {
        inputColor = 'yellow';
      }

      inputVolumeBar.style.width = Math.floor(inputVolume * 300) + 'px';
      inputVolumeBar.style.background = inputColor;

      var outputColor = 'red';
      if (outputVolume < .50) {
        outputColor = 'green';
      } else if (outputVolume < .75) {
        outputColor = 'yellow';
      }

      outputVolumeBar.style.width = Math.floor(outputVolume * 300) + 'px';
      outputVolumeBar.style.background = outputColor;
    });
  }
  
  
  function submitCallTask(taskID) {
	 var sales_member_id = $( "#followup_members_"+taskID+" option:selected" ).val();
	 var date_time = $('followup_date_'+taskID).val();
	 var time = "";
	 var is_follow_up = true;
	 var call_rating;
	 var call_notes= $('#call_notes_'+taskID).val();
	 var productId = $( "#followup_products_"+taskID+" option:selected" ).val();
	 var latitude;
	  var longitude;
	  var call_sid_id;
	  console.log('date_time->'+date_time);

	  
	  var settings = {
			  "async": true,
			  "crossDomain": true,
			  "url": "https://sales.talentify.in:5050/istar/rest/sales_associate/217755/call_task/17210937",
			  "method": "POST",
			  "headers": {
			    "Content-Type": "application/x-www-form-urlencoded",
			    "cache-control": "no-cache"
			  },
			  "data": {
			    "call_details": "{\"follow_up_acton\":{\"type\":\"SALES_CALL_TASK\",\"sales_member_id\":217755,\"date_time\":\"2018-11-23\",\"time\":\"20:47\",\"is_follow_up\":true},\"call_rating\":4,\"call_notes\":\"this was my first call that got picked up\",\"productId\":369,\"latitude\":13.008896,\"longitude\":77.56922879999999,\"call_sid_id\":\"CAbbec8cf16b73cbbc68732b64bdf8e4c6\"}"
			  }
			}

			$.ajax(settings).done(function (response) {
			  console.log(response);
			});
  }
</script>
</html>