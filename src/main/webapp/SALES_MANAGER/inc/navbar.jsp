<%@page
	import="ai.talentify.servlet.AuthenticationServlet.AuthenticationServletMethods"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<header>
	<%
		HashMap<String, String> userData = (HashMap<String, String>) request.getSession().getAttribute("user");
	%>
	<div class="talentify">
		<h3>Talentify</h3>
	</div>
	<div class="linked">
		<a class="a_tag" href="/SALES_MANAGER/dashboard.jsp">Dashboard</a> <a
			class="a_tag" href="/SALES_MANAGER/pipeline.jsp">Pipeline</a> <a
			class="a_tag" href="/SALES_MANAGER/teams.jsp">Teams</a> <a
			class="a_tag" href="/SALES_MANAGER/product.jsp">Product</a> <a
			class="a_tag" href="/SALES_MANAGER/leads.jsp">Leads</a>
	</div>
	<div class="right">
		<div style="display: flex; align-items: center" onclick="showMenu()">
			<a><%=userData.get("name")%></a> <i class="fa fa-caret-down"></i>
		</div>
	</div>

	<div class="profile_navbar">
		<div>
			<img class="profile_navbar_image" src="https://business.talentify.in<%=userData.get("picture")%>">
		</div>
		<div class="profile_navbar_menu_links">
			<p class="profile_navbar_name"><%=userData.get("name")%></p>
			<p class="profile_navbar_email"><%=userData.get("email")%></p>
			<p class="profile_navbar_email"><%=userData.get("mobile")%></p>
			<div class="profile_navbar_account">
				<a class="profile_navbar_acc_btn" href="/SALES_MANAGER/profile.jsp">My Account</a> <a
					class="profile_navbar_acc_btn"
					href="/auth?method=<%=AuthenticationServletMethods.LOGOUT.toString()%>">Logout</a>
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