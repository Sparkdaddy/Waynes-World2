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
    <title>Upload your forms here</title>
    <ul class="nav navbar-nav navbar-right">
        <li><a href="form_upload.jsp"><i class="menu-button"></i> form upload</a></li>
        <li><a href="../index.jsp"><i class="menu-button"></i> Home</a></li>
        <li><a href="../sql_search.jsp"><i class="fa fa-comment"></i> Query your mom</a></li>
    </ul>
</head>

<div class="container">
    <div class="row">
        <h3 class="text-center"> Insert all the data </h3>
    </div>
    <%--Note: action tells the form tag where to send the data once the submit button is clicked.--%>
    <form action="uploading.jsp" method="post">


        <hr class="row" />
        <br/>
        <div class="row">
            <table class="table table-hover">
                <tr>
                    <td><h4>wellID</h4></td>
                    <td><input name="wellID" type="text" class="form-control" placeholder="id"></td>
                </tr>
                <tr>
                    <td><h4>well usage</h4></td>
                    <td><input name="usage" type="text" class="form-control" placeholder="usage"></td>
                </tr>
                <tr>
                    <td><h4>aquafier code</h4></td>
                    <td><input name="aquafier_code" type="text" class="form-control" placeholder="code"></td>
                </tr>
                <tr>
                    <td><h4>type code</h4></td>
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
                    <td><h4>depth (ft)</h4></td>
                    <td><input name="depth" type="text" class="form-control" placeholder="5,5,5"></td>
                </tr>
                <tr>
                    <td><h4>water level elevation (ft)</h4></td>
                    <td><input name="water_level_elevation" type="text" class="form-control" placeholder="3,4,5"></td>
                </tr>
                <tr>
                    <td><h4>land elevation (ft)</h4></td>
                    <td><input name="land_elevation" type="text" class="form-control" placeholder="1,000"></td>
                </tr>
                <tr>
                    <td><h4>bottom elevation (ft)</h4></td>
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
                    <td><h4>latitude</h4></td>
                    <td><input name="latitude" type="text" class="form-control" placeholder="54.45"></td>
                </tr>
                <tr>
                    <td><h4>longitude</h4></td>
                    <td><input name="longitude" type="text" class="form-control" placeholder="45.54"></td>
                </tr>
                <tr>
                    <td><h4>State</h4></td>
                    <td><input name="state" type="text" class="form-control" placeholder="TX, MN?"></td>
                </tr>
                <tr>
                    <td><h4>Country</h4></td>
                    <td><input name="country" type="text" class="form-control" placeholder="country"></td>
                </tr>
                <tr>
                    <td><h4>OwnerID</h4></td>
                    <td><input name="ownerID" type="text" class="form-control" placeholder="9.5"></td>
                </tr>
                <tr>
                    <td><h4>Owner's name</h4></td>
                    <td><input name="owner_name" type="text" class="form-control" placeholder="owner_name"></td>
                </tr>
                <tr>
                    <td><h4>Owner type</h4></td>
                    <td><input name="owner_type" type="text" class="form-control" placeholder="gov't., company, or person?"></td>
                </tr>
                <tr>
                    <td><h4>Transducer ID</h4></td>
                    <td><input name="transID" type="text" class="form-control" placeholder="1234abcd"></td>
                    <td>be sure to enter the wellID that it is connected to</td>
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
        <input type="submit" name="button" value="Button" />
        <button onclick=goto() type="button" class="btn btn-primary btn-lg btn-block">Upload</button>


        <%--Function executing the post to the database.--%>
        <script language="JavaScript">
            function goto() {
                window.location = "uploading.jsp";
            }
        </script>

    </form>
</html>