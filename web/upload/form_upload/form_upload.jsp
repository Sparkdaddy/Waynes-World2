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

  !!checkout this link!!
  https://www.w3schools.com/jsref/dom_obj_document.asp
--%>


<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <link rel="stylesheet" type="text/css" href="../../overall.css">
    <title>Water Management</title>
    <ul class="inlineList">
        <li><a href="../../index.jsp"><i class="menu-button"></i> Home</a></li>
        <li><a href="../../queries/searchPage.jsp"><i class="menu-button"></i> Search</a></li>
        <li><a href="../upload_home.jsp"><i class="menu-button"></i> Upload </a> </li>
    </ul>
    <hr class="row" />
</head>

<h2>Select the table to search through</h2>
<input type="button" name="table" value="well upload" onclick="gotoFormUpload()">
<input type="button" name="table" value="file upload" onclick="gotoFileUpload()">
<input type="button" name="table" value="rainfall upload" onclick="gotoRainfallUpload()">
<br/>

<body>
    <div class="container" id="formDiv">
        <div class="row">
            <h3 class="text-center"> Insert all the data </h3>
        </div>
        <%--Note: action tells the form tag where to send the data once the submit button is clicked.--%>
        <form action="${pageContext.request.contextPath}/form_upload" method="post" enctype="multipart/form-data">
            <div class="row">
                <table class="table table-hover">
                    <tr>
                        <td><h3>WELL INFORMATION</h3></td>
                    </tr>
                    <tr>
                        <td><h4>wellID *</h4></td>
                        <td><input name="wellID" type="text" class="form-control" placeholder="id"></td>
                    </tr>
                    <tr>
                        <td><h4>well usage *</h4></td>
                        <td><input name="usage" type="text" class="form-control" placeholder="usage"></td>
                        <td>irrigation, domestic, unused, or stock?</td>
                    </tr>
                    <tr>
                        <td><h4>aquafier code *</h4></td>
                        <td><input name="aquafier_code" type="text" class="form-control" placeholder="code"></td>
                    </tr>
                    <tr>
                        <td><h4>type code *</h4></td>
                        <td><input name="type_code" type="text" class="form-control" placeholder="type code"></td>
                        <td>one character only in type code!</td>
                    </tr>
                    <tr>
                        <td><h4>comment</h4></td>
                        <td><input name="comment" type="text" class="form-control" placeholder="..."></td>
                    </tr>
                    <tr>
                        <td><h4>top depth (ft)</h4></td>
                        <td><input name="top_depth" type="text" class="form-control" placeholder="6,7,8"></td>
                    </tr>
                    <tr>
                        <td><h4>bottom depth (ft)</h4></td>
                        <td><input name="bottom_depth" type="text" class="form-control" placeholder="1,2,3"></td>
                    </tr>
                    <tr>
                        <td><h4>depth * (ft)</h4></td>
                        <td><input name="depth" type="text" class="form-control" placeholder="5,5,5"></td>
                    </tr>
                    <tr>
                        <td><h4>water level elevation (ft)</h4></td>
                        <td><input name="water_level_elevation" type="text" class="form-control" placeholder="3,4,5"></td>
                    </tr>
                    <tr>
                        <td><h4>land elevation * (ft)</h4></td>
                        <td><input name="land_elevation" type="text" class="form-control" placeholder="1,000"></td>
                    </tr>
                    <tr>
                        <td><h4>bottom elevation * (ft)</h4></td>
                        <td><input name="bottom_elevation" type="text" class="form-control" placeholder="1,000"></td>
                    </tr>
                    <tr>
                        <td><h4>diameter (ft)</h4></td>
                        <td><input name="diameter" type="text" class="form-control" placeholder="-2"></td>
                    </tr>
                    <tr>
                        <td><h4>casing id</h4></td>
                        <td><input name="casingID" type="text" class="form-control" placeholder="12.13,123.2"></td>
                    </tr>
                    <tr>
                        <td><h4>pump description</h4></td>
                        <td><input name="pump_description" type="text" class="form-control" placeholder="pump is like what?"></td>
                    </tr>
                    <tr>
                        <td><h4>latitude *</h4></td>
                        <td><input name="latitude" type="text" class="form-control" placeholder="54.45"></td>
                    </tr>
                    <tr>
                        <td><h4>longitude *</h4></td>
                        <td><input name="longitude" type="text" class="form-control" placeholder="45.54"></td>
                    </tr>
                    <tr>
                        <td><h4>State *</h4></td>
                        <td><input name="state" type="text" class="form-control" placeholder="TX, MN?"></td>
                    </tr>
                    <tr>
                        <td><h4>County *</h4></td>
                        <td><input name="county" type="text" class="form-control" placeholder="county"></td>
                    </tr>
                    <tr>
                        <td><h3>OWNER INFORMATION</h3></td>
                    </tr>
                    <tr>
                        <td><h4>Owner's name</h4></td>
                        <td><input name="owner_name" type="text" class="form-control" placeholder="owner_name"></td>
                        <td>be sure to enter the wellID above that is owned</td>
                    </tr>
                    <tr>
                        <td><h4>Owner type</h4></td>
                        <td><input name="owner_type" type="text" class="form-control" placeholder="gov't., company, or person?"></td>
                        <td>government, person, or company</td>
                    </tr>
                    <tr>
                        <td><h3>TRANSDUCER INFORMATION</h3></td>
                    </tr>
                    <tr>
                        <td><h4>Transducer ID</h4></td>
                        <td><input name="transID" type="text" class="form-control" placeholder="1234abcd"></td>
                        <td>be sure to enter the wellID above that it is connected to</td>
                    </tr>
                    <tr>
                        <td><h4>Transducer name</h4></td>
                        <td><input name="trans_name" type="text" class="form-control" placeholder="Billy"></td>
                    </tr>
                    <tr>
                        <td><h4>Transducer type</h4></td>
                        <td><input name="trans_type" type="text" class="form-control" placeholder="transducer type"></td>
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
        window.location="form_upload.jsp";
    }
    function gotoFileUpload() {
        window.location="../file_upload/file_upload.jsp";
    }
    function gotoRainfallUpload() {
        window.location="../rainfall_upload/rainfall_upload.jsp";
    }
</script>