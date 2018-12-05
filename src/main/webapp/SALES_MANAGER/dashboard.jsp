<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="/assets/css/team.css" />
    <link rel="stylesheet" type="text/css" href="/assets/css/header.css" />
    <script src="http://code.highcharts.com/highcharts.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
    <div class="main-header">
        <jsp:include page="/SALES_MANAGER/inc/navbar.jsp"></jsp:include>
    </div>
    <div class="head">
        <h3 class="heading">Teams</h3>
        <a class = "onclick" href = "create-team.html"><p>Create Team</p></a>
    </div>
    <div class="teamsContainer">
    </div>
</body>

</html>