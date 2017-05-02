<%--
  Created by IntelliJ IDEA.
  User: Sparky
  Date: 4/30/17
  Time: 5:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Upload your forms here</title>
    <ul class="nav navbar-nav navbar-right">
        <li><a href="file_upload.jsp"> file upload</a> </li>
        <li><a href="../form_upload/form_upload.jsp"><i class="menu-button"></i> form upload</a></li>
        <li><a href="../index.jsp"><i class="menu-button"></i> Home</a></li>
        <li><a href="../sql_search.jsp"><i class="fa fa-comment"></i> Query your mom</a></li>
    </ul>
</head>

<div class="container">
    <div class="row">
        <h3 class="text-center"> Select a file </h3>
        <p>Note: Do not have commas in upload files, e.g. a comma in the comments/remarks section.</p>
    </div>
    <%--Note: action tells the form tag where to send the data once the submit button is clicked.--%>
    <form action="/file_upload" method="post" enctype="multipart/form-data">
        <div class="row">
            <table class="table table-hover">
                <tr>
                    <td>Well file</td>
                    <td><input type="checkbox" name="isFile" value="well"/></td>
                </tr>
                <tr>
                    <td>Sensor file</td>
                    <td><input type="checkbox" name="isFile" value="sensor"/> </td>
                </tr>
                <tr>
                    <td>Sensor being used</td>
                    <td><input type="text" name="sensor" placeholder="sensor with info" /> </td>
                </tr>
                <tr>
                    <td style="padding-top: 5px;"> <input type="file" name="file" value="select the file" accept="*/.(csv|txt)"> </td>
                </tr>
                <tr>
                    <td style="padding-top: 25px;"><h3>Field information</h3></td>
                </tr>

                <tr>
                    <td><h4>column 1</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 2</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 3</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 4</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 5</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 6</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 7</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 8</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 9</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 10</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 11</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 12</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 13</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 14</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 15</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 16</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 17</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 18</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 19</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 20</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 21</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 22</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 23</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 24</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><h4>column 25</h4></td>
                    <td>
                        <select name="field1">
                            <option value="wellID">wellID</option>
                            <option value="Latitude">Latitude</option>
                            <option value="Longitude">Longitude</option>
                            <option value="county">county</option>
                            <option value="state">state</option>
                            <option value="Aquifercode">Aquifercode</option>
                            <option value="wellTypeCode">wellTypeCode</option>
                            <option value="wellDepth">wellDepth</option>
                            <option value="casingID">casingID</option>
                            <option value="diameter">diameter</option>
                            <option value="topDepth">topDepth</option>
                            <option value="bottomDepth">bottomDepth</option>
                            <option value="bottomElevation">bottom elevation</option>
                            <option value="landSurfaceElevation">landsurfaceElevation</option>
                            <option value="WaterElevation">WaterElevation</option>
                            <option value="pump">pump</option>
                            <option value="WellUse">WellUse</option>
                            <option value="comments">comments</option>
                            <option value="other" selected>other</option>
                        </select>
                    </td>
                </tr>
            </table>
            <input type="submit" name="button" value="Upload file"/>
        </div>
    </form>

</html>
