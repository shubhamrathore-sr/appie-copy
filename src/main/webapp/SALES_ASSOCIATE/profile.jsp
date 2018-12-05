<%@page import="ai.talentify.services.UserProfileService"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Currency"%>



<%@page import="ai.talentify.db.utils.DBUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/assets/css/profile.css" />
<link rel="stylesheet" type="text/css" href="/assets/css/header.css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="../assets/js/showMenu.js">
</script><script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<head>
<body>

	<div class="main-header">
		<jsp:include page="/SALES_ASSOCIATE/inc/navbar.jsp"></jsp:include>
	</div>
	<%
		// Give me a list of teams 
		HashMap<String, String> userData = (HashMap<String, String>) request.getSession().getAttribute("user");
		String managerID = userData.get("id");
		UserProfileService service = new UserProfileService();
		HashMap<String, String> data = service.getProfile(Integer.parseInt(managerID));
	%>
	<div class="main">
		<div class="container">
			<div class="nav-links">
				<a class="acc-link unactive-link"> Account </a> <a
					class="acc-link active-link"> Profile </a>
			</div>
			<div style="width: 80%;">
				<h3>Your Personal Settings</h3>
				<div class=container-1>
						<input type="hidden" value=<%=data.get("id")%> id="managerId">
						<div class="group-desc">
							<div class="desc">
								<label class="heading">Your Name</label> <input type="text"
									name="username" id="username" class="data-field"
									value="<%=data.get("name")%>">
							</div>
						</div>

						<div class="group-desc">
							<div class="desc">
								<label class="heading">Email</label> <input
									class="disable-field data-field" type="text" disabled
									value="<%=data.get("email")%>">
							</div>
						</div>

						<div class="group-desc">
							<div class="desc">
								<label class="heading">Mobile</label> <input
									class="disable-field data-field" type="number" disabled
									value="<%=data.get("mobile")%>">
							</div>
						</div>

						<div class="group-desc">
							<div class="desc">
								<label class="heading">Picture</label>
								<div class="choose-field">
									<% if(data.get("profile_image").startsWith("http://") || data.get("profile_image").startsWith("https://")) { %>
									<img class='profile_image_mini' src='<%=data.get("profile_image")%>'>
									<% } else { %>
									<img class='profile_image_mini'  src='https://business.talentify.in<%=data.get("profile_image")%>'>
									 <% }  %>
									<input id='upload_image' style="margin-left: 52px;" class="choose-file" type="file" accept="image/*">
								</div>
							</div>
						</div>

						<div class="group-desc">
							<div class="desc">
								<label class="heading">Time Zone</label>
								<%
									String[] TimeZoneids = TimeZone.getAvailableIDs();
								%>
								<select class="select" name="timezone" id="timezone">
									<%
										for (String id : TimeZoneids) {
											if (id.equalsIgnoreCase(data.get("timezone"))) {
									%>
									<option value="<%=TimeZone.getTimeZone(id).getID()%>"
										selected="selected">

										<%=TimeZone.getTimeZone(id).getID()%>
									</option>

									<%
										} else {
									%>

									<option value="<%=TimeZone.getTimeZone(id).getID()%>">
										<%=TimeZone.getTimeZone(id).getID()%>
									</option>
									<%
										}
										}
									%>
								</select>
							</div>
						</div>

						<div class="group-desc">
							<div class="desc">
								<label class="heading">Location</label>
								<%
									String[] countryCodes = Locale.getISOCountries();
								%>
								<select class="select" name="location" id="location">
									<%
										for (String countryCode : countryCodes) {
											Locale obj = new Locale("", countryCode);
											if (obj.getCountry().equalsIgnoreCase(data.get("location"))) {
									%>
									<option value="<%=obj.getCountry()%>" selected><%=obj.getDisplayCountry()%>(<%=obj.getCountry()%>)
									</option>
									<%
										} else {
									%>
									<option value="<%=obj.getCountry()%>"><%=obj.getDisplayCountry()%>(<%=obj.getCountry()%>)
									</option>

									<%
										}
										}
									%>

								</select>
							</div>
						</div>

						<div class="group-desc">
							<div class="desc">
								<label class="heading">Language</label>
								<%
									String[] languages = Locale.getISOLanguages();
								%>
								<select class="select" name="language" id="language">
									<%
										for (int i = 0; i < languages.length; i++) {
											Locale loc = new Locale(languages[i]);
											if (loc.getLanguage().equalsIgnoreCase(data.get("language"))) {
									%>

									<option value="<%=loc.getLanguage()%>" selected><%=loc.getDisplayLanguage()%>(<%=loc.getLanguage()%>)
									</option>
									<%
										} else {
									%>
									<option value="<%=loc.getLanguage()%>"><%=loc.getDisplayLanguage()%>(<%=loc.getLanguage()%>)
									</option>
									<%
										}
										}
									%>

								</select>
							</div>
						</div>

						<div class="group-desc">
							<div class="desc">
								<%
									Locale[] locs = Locale.getAvailableLocales();
								%>
								<label class="heading">Default Currency</label> <select
									class="select" name="currency" id="currency">
									<%
										for (Locale loc : locs) {
											try {
												Currency currency = Currency.getInstance(loc);
												if (currency != null) {
													if (currency.toString().equalsIgnoreCase(data.get("currency"))) {
									%>
									<option value="<%=currency.toString()%>" selected><%=loc.getDisplayCountry()%>(<%=currency.toString()%>)
									</option>

									<%
										} else {
									%>
									<option value="<%=currency.toString()%>"><%=loc.getDisplayCountry()%>(<%=currency%>)

										<%
										}
												}
											} catch (Exception exc) {

											}
										}
									%>
									
								</select>
							</div>
						</div>
						<div class="buttons">
							<button class="create btn" id='save_profile'>Save</button>
						</div>
					
				</div>
			</div>
		</div>

	</div>
</body>
<script>
$('#save_profile').click(
	
		function(event) {
			var img=$('.profile_image_mini').attr('src');
			
			  $.post('/auth?method=UPDATE_PROFILE&manager_id='
					+ $('#managerId').val(), 'name=' + $('#username').val()
					+ '&timezone=' + $('#timezone').val() +'&picture='+$('.profile_image_mini').attr('src')+ '&location='
					+ $('#location').val() + '&language=' + $('#language').val()
					+ '&currency=' + $('#currency').val(), function(result) {
						console.log(result);
						swal("Good job!", "You just updated you profile.", "success").then(function(value) {
							 // redirect to edit team page
							/// window.location.href='/SALES_MANAGER/create_team.jsp?team_id='+result;
						});;
			});  
		});

$('#upload_image').on('change', prepareUpload);

//Grab the files and set them to our variable
function prepareUpload(event)
{
	var files;
	files = event.target.files;
	console.log(files);
	
	 var data = new FormData();
	    $.each(files, function(key, value)
	    {
	        data.append("file", value);
	    });
	    
	    $.ajax({
	        url: '/upload',
	        type: 'POST',
	        data: data,
	        cache: false,
	        
	        processData: false, // Don't process the files
	        contentType: false, // Set content type to false as jQuery will tell the server its a query string request
	        success: function(data, textStatus, jqXHR)
	        {
	            console.log(data);
	            $(".profile_image_mini").attr("src",data);
	        },
	        error: function(jqXHR, textStatus, errorThrown)
	        {
	            // Handle errors here
	            console.log('ERRORS: ' + textStatus);
	            // STOP LOADING SPINNER
	        }
	    });
}

	
</script>
</html>