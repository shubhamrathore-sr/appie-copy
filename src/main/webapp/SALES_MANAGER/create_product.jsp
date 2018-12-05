<!DOCTYPE html><%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>
<%@page import="java.util.ArrayList"%>
<%@page import="ai.talentify.services.ProductService"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title>Add Products</title>
<meta charset="UTF-8">
<meta name="keywords" content="HTML,CSS,XML,JavaScript">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="/assets/css/addProduct.css">
<link rel="stylesheet" type="text/css" href="/assets/css/header.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>

<body>
	<div class="main-header">
		<jsp:include page="/SALES_MANAGER/inc/navbar.jsp"></jsp:include>
	</div>
	<%
		final Logger logger = LogManager.getLogger(this.getClass().getName());
		String productID = request.getParameter("product_id");
		HashMap<String, String> product = new ProductService().getProduct(productID);
		logger.info(product.get("image"));
		if (productID != null) {
	%>
	<div class="container">
		<div class="btn-container">
			<div style="width: 100%">
				<a href="product.jsp"><i class="material-icons arrow-back"> arrow_back </i></a>
			</div>
		</div>

		<div class="nav-tabs">
			<a href="#" rel="product-details" class="tab active">Product Details</a> <a href="#" rel="documents" class="tab">Documents</a> <a href="#" rel="signals" class="tab">Signals</a>
		</div>
		<div class="content">
			<div id="product-details">
				<div class="upload">
					<div class="upload-img">
						<%
							if (product.get("image") != null) {
						%>
						<img class="masthead" src="<%=product.get("image")%>" style="max-width: 100%;">

						<%
							} else {
						%>
						<i class="material-icons imgae-cloudicon cloud font-36"> cloud_upload </i>
						<%
							}
						%>
					</div>
					<input type="file">
				</div>
				<div class="text-field">
					<div class="desc">
						<label class="heading">Name</label> <input type="text" class="data-field name-input" value="<%=product.get("name")%>">
					</div>
					<div class="desc">
						<label class="heading">Description</label>
						<textarea class="data-field desc-input"><%=product.get("description")%></textarea>
					</div>
				</div>
				<div class="buttons file-next">
					<div></div>
					<a href="#" rel="documents" class="next navigation_button " id='save_product_details'>Next</a>
				</div>
			</div>
			<div id="documents">
				<div class="list-documents">
					<%
						ArrayList<HashMap<String, String>> documents = new ProductService()
									.getProductDocuments(Integer.parseInt(product.get("id")));
							for (HashMap<String, String> document : documents) {
					%>
					<div class="document">
						<div class="file-holder">
							<div class="file-list">
								<div class="file">
									<div class="choose">
										<button class="choose-btn">Choose File</button>
										<input type="file">
									</div>
									<div><%=document.get("asset_name")%></div>
									<div>
										<i class="material-icons remove delete-document-icon pointer"> close </i>
									</div>
								</div>
							</div>
							<div class="add-btn">
								<i class="material-icons add font-36 add-document-input pointer" ngbtooltip="Add Document(s)"> add_circle </i>
							</div>
						</div>
					</div>
					<%
						}
					%>
				</div>
				<div class="buttons documents">
					<a href="#" rel="product-details" class="next navigation_button">Previous </a> <a href="#" rel="signals" class="next navigation_button">Next </a>

				</div>
			</div>
			<div id="signals" class="signal-container">
				<div class="list-signals">
					<%
						ArrayList<HashMap<String, String>> signals = new ProductService()
									.getProductSignals(Integer.parseInt(product.get("id")));
							for (HashMap<String, String> signal : signals) {
					%>

					<div class="file-holder">
						<div class="signal-list">
							<div class="signal-row">
								<!-- <div class="choose"> -->
								<input class="input-field" type="text" placeholder="Enter Signal Script..." value="<%=signal.get("value")%>"> <select class="input-field select-field">
									<option>Lead Validation</option>
								</select> <select class="input-field select-field">
									<option>Long Phrase Match</option>
								</select>
								<button class="color-button"></button>
								<!-- </div> -->
								<div>
									<i class="material-icons remove delete-document-icon pointer" onclick="remove(this)"> close </i>
								</div>
							</div>
						</div>
						<div class="add-btn">
							<i onclick="addSignalRow()" class="material-icons add font-36 add-document-input pointer" ngbtooltip="Add Document(s)"> add_circle </i>
						</div>
					</div>
					<%
						}
					%>
				</div>



				<div class="buttons  btn-postion">
					<a href="#" rel="documents" class="next navigation_button">Previous </a>

					<button class="next navigation_button">Submit</button>
				</div>
			</div>
		</div>
	</div>
	<%
		} else {
	%>
	<div class="container">
		<div class="btn-container">
			<div style="width: 100%">
				<a href="product.jsp"><i class="material-icons arrow-back"> arrow_back </i></a>
			</div>
		</div>

		<div class="nav-tabs">
			<a href="#" rel="product-details" class="tab active">Product Details</a> <a href="#" rel="documents" class="tab">Documents</a> <a href="#" rel="signals" class="tab">Signals</a>
		</div>
		<div class="content">
			<div id="product-details">
				<div class="upload">
					<div class="upload-img">
						<%
							if (product.get("image") != null) {
						%>
						<img class="masthead" src="<%=product.get("image")%>" style="max-width: 100%;">

						<%
							} else {
						%>
						<i class="material-icons imgae-cloudicon cloud font-36"> cloud_upload </i>
						<%
							}
						%>
					</div>
					<input type="file">
				</div>
				<div class="text-field">
					<div class="desc">
						<label class="heading">Name</label> <input type="text" class="data-field name-input" value="<%=product.get("name")%>">
					</div>
					<div class="desc">
						<label class="heading">Description</label>
						<textarea class="data-field desc-input"><%=product.get("description")%></textarea>
					</div>
				</div>
				<div class="buttons file-next">
					<div></div>
					<a href="#" rel="documents" class="next">Next </a>
				</div>
			</div>
			<div id="documents">
				<div class="file-holder">
					<div class="file-list">
						<div class="file">
							<div class="choose">
								<button class="choose-btn">Choose File</button>
								<input type="file">
							</div>
							<div>
								<i class="material-icons remove delete-document-icon pointer"> close </i>
							</div>
						</div>
					</div>
					<div class="add-btn">
						<i class="material-icons add font-36 add-document-input pointer" ngbtooltip="Add Document(s)"> add_circle </i>
					</div>
				</div>
				<div class="buttons">
					<a href="#" rel="product-details" class="next">Previous </a> <a href="#" rel="signals" class="next">Next </a>

				</div>
			</div>
			<div id="signals">
				<div class="file-holder">
					<div class="signal-list">
						<div class="signal-row">
							<!-- <div class="choose"> -->
							<input class="input-field" type="text" placeholder="Enter Signal Script..."> <select class="input-field select-field">
								<option>Lead Validation</option>
							</select> <select class="input-field select-field">
								<option>Long Phrase Match</option>
							</select>
							<button class="color-button"></button>
							<!-- </div> -->
							<div>
								<i class="material-icons remove delete-document-icon pointer" onclick="remove(this)"> close </i>
							</div>
						</div>
					</div>
					<div class="add-btn">
						<i onclick="addSignalRow()" class="material-icons add font-36 add-document-input pointer" ngbtooltip="Add Document(s)"> add_circle </i>
					</div>
				</div>
				<div class="buttons  btn-postion">
					<a href="#" rel="documents" class="next">Previous </a>

					<button class="next">Submit</button>
				</div>
			</div>
		</div>
	</div>
	<%
		}
	%>
</body>

<script type="text/javascript">
	// This is to handle next and prev buttons
	$('.navigation_button').on('click', function() {
		//    $(this).addClass('active');
		//    $(this).siblings('a').removeClass('active');
		//    let target = $(this).attr('rel');
		//    $("#" + target).show().siblings('div').hide();
	});

	$('#save_product_details').on('click', function() {
		// collect 
	});
</script>
</html>