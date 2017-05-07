<%--
  Created by IntelliJ IDEA.
  User: Justin Ritter
  Date: 5/4/2017
  Time: 1:22 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <div id="nav_bar">
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel="stylesheet" type="text/css" href="../../overall.css">
        <title>Water Management</title>
        <ul class="inlineList">
            <li><a href="../../index.jsp"><i class="menu-button"></i> Home</a></li>
            <li><a href="../searchPage.jsp"><i class="menu-button"></i> Search</a></li>
            <li><a href="../../upload/upload_home.jsp"><i class="menu-button"></i> Upload </a> </li>
        </ul>
        <hr class="row" />
    </div>
    <div id="searchPages">
        <h2>Select the search you would like to do</h2>
        <input id="wellchk" type="button" name="tables" value="well" onclick="goto('well_search.jsp')">
        <input id="transchk" type="button" name="tables" value="transducer" onclick="goto('../trans_search/trans_search.jsp')">
        <input id="analysis" type="button" name="tables" value="advanced transducer analysis" onclick="goto('../advTrans_search/advTrans_search.jsp')">
        <input id="locchk" type="button" name="tables" value="location" onclick="goto('../loc_search/loc_search.jsp')">
        <br/>
    </div>
</head>
<body>
    <div id="wellDiv">
        <br/>
        <h5>Enter the Well information</h5>
        <div id="input">
            <form action="wellSearch.jsp">
                <table class="table">
                    <tr>
                        <td>Unique WellID</td>
                        <td><input name="wellId" class="wellKeys" type="text" placeholder="id"></td>
                    </tr>
                    <tr>
                        <td>Aquifer Code</td>
                        <td><input name="aqua_Code" class="wellKeys" type="text" placeholder="code"></td>
                    </tr>
                    <tr>
                        <td>Type Code</td>
                        <td><input name="type_Code" class="wellKeys" type="text" placeholder="code"></td>
                    </tr>
                    <tr>
                        <td>Owner</td>
                        <td><input name="owner" class="wellKeys" type="text" placeholder="name"></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Submit"></td>
                    </tr>
                </table>
            </form>
        </div>
    </div>
</body>
</html>

<script>
    function goto(page) {
        window.location=page;
    }
</script>
