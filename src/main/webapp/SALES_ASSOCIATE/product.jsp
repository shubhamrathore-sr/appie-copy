<%@page import="ai.talentify.ui.utils.StringUtils"%>
<%@page import="ai.talentify.services.ProductService"%>
<%@page import="java.util.*"%>
<%@page import="ai.talentify.services.TeamService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head><title>Sales Associate Product List - Talentify</title>
<link rel="stylesheet" type="text/css" href="/assets/css/products_ass.css">
<link rel="stylesheet" type="text/css" href="/assets/css/header.css" />
<style>
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>

<%
	// Give me a list of teams 
	HashMap<String, String> userData = (HashMap<String, String>) request.getSession().getAttribute("user");
	String managerID = userData.get("id");
	ProductService service = new ProductService();
	ArrayList<HashMap<String, String>> products = service.getProducts(Integer.parseInt(managerID));
%>
<body>
	<div class="main-header">
		<jsp:include page="/SALES_ASSOCIATE/inc/navbar.jsp"></jsp:include>
	</div>

	<div class="main">
		<div class="container">
			<div class="head">
				<div>
					<h1 style="color: rgb(98, 96, 96); font-weight: normal;">Products</h1>
				</div>
				<div class="action-container">
					<select class="select" id="product_selector">
						<option value="-1">ALL</option>
						<%
							for (HashMap<String, String> row : products) {
						%>
						<option value="<%=row.get("id")%>"><%=row.get("name")%></option>
						<%
							}
						%>
					</select>
				</div>
			</div>
			<div class="heading">
				<h3 class="content-heading" style="width: 25%">PRODUCT NAME</h3>
				<h3 class="content-heading" style="width: 75%">DOCUMENTS</h3>
			</div>
			<%
				for (HashMap<String, String> row : products) {
			%>
			<div class="content-detail" id="product_<%=row.get("id")%>">
				<p class="names"><%=row.get("name")%></p>
				<div class="documents" id="doc_<%=row.get("id")%>">
					<%
						ArrayList<HashMap<String, String>> documents = service
									.getProductDocuments(Integer.parseInt(row.get("id")));
							int max_list = Math.min(documents.size(), 6);
							for (int i = 0; i < max_list; i++) {
								HashMap<String, String> document = documents.get(i);
					%>
					<div class="doc">
						<a href='<%=document.get("asset_url").toString()%>'><img class="img" style="width: 40px; height: 40px;" src="/assets/images/<%=document.get("asset_type")%>.png" alt="<%=document.get("asset_name").toString()%>"></a>
						<p title="<%=document.get("asset_name").toString()%>"><%=StringUtils.substring(document.get("asset_name").toString(), 30)%></p>
					</div>
					<%
						}
					%>

					<p class="add-btn-assets" id="productExpand_<%=row.get("id")%>" onclick="expand(<%=row.get("id")%>)">+</p>
				</div>

				
				

			</div>
			<div id="productContent_<%=row.get("id")%>" class="accordion-content">
				<div style="display: flex;">
					<p class="names"><%=row.get("name")%></p>
					<div class="expanded-documents">
						<%
							for (HashMap<String, String> doc : documents) {
						%>
						<div class="expanded-doc">
							<img class="img" style="width: 40px; height: 40px;" src="/assets/images/<%=doc.get("asset_type")%>.png" alt="<%=doc.get("asset_name").toString()%>">
							<div class="names_expanded" title="<%=doc.get("asset_name").toString()%>"><%=doc.get("asset_name").toString()%></div>
						</div>
						<%
							}
						%>
					</div>
					
				</div>

			</div>
			<%
				}
			%>
		</div>
	</div>
</body>
<script>
function expand(row) {
	var accordian=document.getElementById("productContent_"+row);
	accordian.classList.toggle('active');
	var product=document.getElementById("product_"+row)
	product.classList.toggle('display-none')
}

$( "#product_selector" ) .change(function () {    
	var optionSelected = $("option:selected", this);
	console.log(this.value);
	if(this.value != -1 ) {
		$('.content-detail').hide();
		$('#product_'+this.value).show();
	} else {
		$('.content-detail').show();
	}
});

$(".delete-btn").click(function(){
	var currentElement = $(this).attr("id");
	$.get("/product?method=DELETE&productID="
			+ currentElement, function(data) {
				 window.location.href='/SALES_MANAGER/product.jsp';
	});
});
	
	$(".edit-btn").click(function() {
		var currentElement = $(this).attr("id");
		window.location.href = '/SALES_MANAGER/create_product.jsp?product_id='+currentElement;

	});

</script>

</html>