<html>
<head>
<meta charset="utf-8">
<title>Sales Manager Talentify</title>
<base href="/">
<meta http-equiv="x-ua-compatible" content="IE=9">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="/assets/css/login.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script><script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

</head>
<body>
	<% if(request.getAttribute("MSG") != null) {
		%>
		<input type="hidden" id="server_message" name="server_message" value="<%=request.getAttribute("MSG").toString()%>"/>
		<%
	}
	%>
	<div class="main">
		<div class="login-container">
			<img class="img" src="./assets/logo.png">
			<h2 class="welcome">Welcome</h2>

			<form class="login-form" name="form" method="POST" action="/auth">
				<input type="hidden" name="method" value="AUTH" />
				<div class="field-container">
					<input class="field" type="email" name="email" placeholder="Enter Email" required pattern="^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$">
				</div>
				<div class="field-container">
					<input class="field" name="password" type="password" placeholder="Password" required pattern="^.{4,16}$" />

				</div>
				<button type="submit" class="btn" value="validate">Login</button>
			</form>
			<p class="company">ISTAR Skill Development Pvt. Ltd. &copy; 2018</p>
		</div>
	</div>
	<script src="http://parsleyjs.org/dist/parsley.min.js"></script>
	<script type="text/javascript">
		if($('#server_message').val() != undefined) {
			swal("Message from Server", $('#server_message').val(), "error");
		}
	
		$(function() {
			$('#demo-form').parsley().on('field:validated', function() {
				var ok = $('.parsley-error').length === 0;
				$('.bs-callout-info').toggleClass('hidden', !ok);
				$('.bs-callout-warning').toggleClass('hidden', ok);
			}).on('form:submit', function() {
				return false; // Don't submit form for this demo
			});
		});
	</script>

</body>
</html>