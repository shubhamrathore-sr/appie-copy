<%@page import="ai.talentify.servlet.AuthenticationServlet.AuthenticationServletMethods"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header>
	<%
		HashMap<String, String> userData = (HashMap<String, String>) request.getSession().getAttribute("user");
	%>
	<div class="talentify">
		<h3><a href='/SALES_ASSOCIATE/dashboard.jsp'> Talentify</a></h3>
	</div>
	<div class="linked">
		<% if(request.getRequestURL().toString().endsWith("dashboard.jsp")) { %>
			<a class="a_tag highlight_navbar" href="/SALES_ASSOCIATE/dashboard.jsp">Dashboard</a>
		<% } else { %>
			<a class="a_tag" href="/SALES_ASSOCIATE/dashboard.jsp">Dashboard</a>
		<% }%>
		<% if(request.getRequestURL().toString().endsWith("product.jsp")) { %>
		<a class="a_tag highlight_navbar" href="/SALES_ASSOCIATE/product.jsp">Product</a>
		<% } else { %>
		<a class="a_tag" href="/SALES_ASSOCIATE/product.jsp">Product</a>
		<% }%>
		<% if(request.getRequestURL().toString().endsWith("leads.jsp")) { %>
		<a class="a_tag highlight_navbar" href="/SALES_ASSOCIATE/leads.jsp">Leads</a>
		<% } else { %>
		<a class="a_tag" href="/SALES_ASSOCIATE/leads.jsp">Leads</a>
		<% }%>
	</div>
	<div class="right">
		<div style="display: flex; align-items: center" onclick="showMenu()">
			<a><%=userData.get("name")%></a> <i class="fa fa-caret-down"></i>
		</div>
	</div>

	<div class="profile_navbar">
		<div>
			<img class="profile_navbar_image" src="https://business.talentify.in/<%=userData.get("picture")%>">
		</div>
		<div class="profile_navbar_menu_links">
			<p class="profile_navbar_name"><%=userData.get("name")%></p>
			<p class="profile_navbar_email"><%=userData.get("email")%></p>
			<p class="profile_navbar_email"><%=userData.get("mobile")%></p>
			<div class="profile_navbar_account">
				<a class="profile_navbar_acc_btn" href="/SALES_ASSOCIATE/profile.jsp">My Account</a> 
				<a class="profile_navbar_acc_btn" href="/auth?method=<%=AuthenticationServletMethods.LOGOUT.toString()%>">Logout</a>
			</div>
		</div>

	</div>
</header>
<script>
	var show = "hide";

	function showMenu() {

		if (show == "hide") {
			document.getElementsByClassName("profile_navbar")[0].style = "display:flex";
			document.getElementsByClassName("profile_navbar")[0].classList
					.add("show");
			show = "show";
		} else {
			document.getElementsByClassName("profile_navbar")[0].style = "display:none";
			show = "hide";
		}
	}
</script>