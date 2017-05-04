<%--
  Created by IntelliJ IDEA.
  User: Sparky
  Date: 5/3/17
  Time: 9:51 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <link rel="stylesheet" type="text/css" href="../../overall.css">
    <title>Upload your forms here</title>
    <ul class="inlineList">
        <li><a href="../../index.jsp"><i class="menu-button"></i> Home</a></li>
        <li><a href="../../queries/sql_search.jsp"><i class="menu-button"></i> Search</a></li>
        <li><a href="upload_home.jsp"><i class="menu-button"></i> Upload </a> </li>
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

</body>
</html>

<script language="JavaScript">
    function gotoFormUpload() {
        window.location="form_upload/form_upload.jsp";
    }
    function gotoFileUpload() {
        window.location="file_upload/file_upload.jsp";
    }
    function gotoRainfallUpload() {
        window.location="rainfall_upload/rainfall_upload.jsp";
    }
</script>
