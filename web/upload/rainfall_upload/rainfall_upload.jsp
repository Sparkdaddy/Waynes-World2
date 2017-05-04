<%@ page import="java.sql.*" %>
<%--<%@ page import="java.sql.DriverManager" %>--%>
<%--<%@ page import="java.sql.Connection" %>--%>
<%--<%@ page import="java.sql.ResultSet" %>--%>
<%--<%@ page import="java.sql.Statement" %>--%>
<%--
  Created by IntelliJ IDEA.
  User: Sparky
  Date: 4/27/17
  Time: 8:50 AM
  To change this template use File | Settings | File Templates.
--%>


<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <link rel="stylesheet" type="text/css" href="../../overall.css">
    <title>Upload your forms here</title>
    <ul class="inlineList">
        <li><a href="../../index.jsp"><i class="menu-button"></i> Home</a></li>
        <li><a href="../../queries/searchPage.jsp"><i class="menu-button"></i> Search</a></li>
        <li><a href="../upload_home.jsp"><i class="menu-button"></i> Upload </a> </li>
    </ul>
    <hr class="row" />
</head>

<h2>Select the table to search through</h2>
well upload:
<input type="button" name="table" onclick="gotoFormUpload()">
<br> file upload:
<input type="button" name="table" onclick="gotoFileUpload()">
<br>rainfall upload:
<input type="button" name="table" onclick="gotoRainfallUpload()">
<br/>

<body>
<div class="container" id="formDiv">
    <div class="row">
        <h3 class="text-center"> Insert all the data </h3>
    </div>
    <%--Note: action tells the form tag where to send the data once the submit button is clicked.--%>
    <form action="rainUploading.jsp" method="post">
        <div class="row">
            <table class="table table-hover">
                <tr>
                    <td><h3>WELL INFORMATION</h3></td>
                </tr>
                <tr>
                    <td><h4>Date *</h4></td>
                    <td><input name="date" type="text" class="form-control" placeholder="yyyy/MM/dd HH:mm:ss"></td>
                    <td>Note: format must be year/month/day hour:minute:seconds.</td>
                </tr>
                <tr>
                    <td><h4>latitude *</h4></td>
                    <td><input name="latitude" type="text" class="form-control" placeholder="latitude"></td>
                </tr>
                <tr>
                    <td><h4>longitude *</h4></td>
                    <td><input name="longitude" type="text" class="form-control" placeholder="code"></td>
                </tr>
                <tr>
                    <td><h4>actual_amount (in) *</h4></td>
                    <td><input name="actual_amount" type="text" class="form-control" placeholder="5ft?!"></td>
                </tr>
                <tr>
                    <td><h4>normal_amount (in) *</h4></td>
                    <td><input name="normal_amount" type="text" class="form-control" placeholder="2in..."></td>
                </tr>
            </table>
        </div>
        <input type="submit" name="button" value="Upload the info"/>
    </form>
</div>
</body>
</html>


<script language="JavaScript">
    function gotoFormUpload() {
        window.location="../form_upload/form_upload.jsp";
    }
    function gotoFileUpload() {
        window.location="../file_upload/file_upload.jsp";
    }
    function gotoRainfallUpload() {
        window.location="rainfall_upload.jsp";
    }
</script>