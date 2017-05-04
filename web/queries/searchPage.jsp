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
    <div id="nav_bar">
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel="stylesheet" type="text/css" href="../overall.css">
        <title>This is my template now</title>
        <ul class="inlineList">
            <li><a href="../index.jsp"><i class="menu-button"></i> Home</a></li>
            <li><a href="searchPage.jsp"><i class="menu-button"></i> Search</a></li>
            <li><a href="../upload/upload_home.jsp"><i class="menu-button"></i> Upload </a> </li>
        </ul>
        <hr class="row" />
    </div>
    <div id="searchPages">
        <h2>Select the search you would like to do</h2>
        <input id="wellchk" type="button" name="tables" value="well" onclick="goto('well_search/well_search.jsp')">
        <input id="transchk" type="button" name="tables" value="transducer" onclick="goto('trans_search/trans_search.jsp')">
        <input id="analysis" type="button" name="tables" value="advanced transducer analysis" onclick="goto('advTrans_search/advTrans_search.jsp')">
        <input id="locchk" type="button" name="tables" value="location" onclick="goto('loc_search/loc_search.jsp')">
        <br/>
    </div>
</head>

<body>
    <div id="myDiv" style="display: none">
        <div id="wellDiv" style="display: none">
            <br/>
            <h5>Enter the Well information</h5>
            <div id="input">
                <form action="well_search/wellSearch.jsp">
                    <table class="table">
                        <tr>
                            <td>Unique WellID</td>
                            <td><input id="id" class="wellKeys" type="text" placeholder="id"></td>
                        </tr>
                        <tr>
                            <td>Aquifer Code</td>
                            <td><input id="aqua_Code" class="wellKeys" type="text" placeholder="code"></td>
                        </tr>
                        <tr>
                            <td>Type Code</td>
                            <td><input id="type_Code" class="wellKeys" type="text" placeholder="code"></td>
                        </tr>
                        <tr>
                            <td>Owner</td>
                            <td><input id="owner" class="wellKeys" type="text" placeholder="name"></td>
                        </tr>
                        <tr>
                            <td><input type="submit" value="wellTable"></td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
        <div id="transDiv" style="display: none">
            this is the transducer bit
        </div>
        <div id="anDiv" style="display: none">
            Transducer ID:
            <input type="text" name="transId">
            <input type="submit" name="submit" value="Submit" onclick="showTransSubmitDiv()">
            <div id="Submit" style="display: none">
                This is a test lol.
                <script language="JavaScript">
                    var id = document.getElementsByName('transId').value;
                </script>
            </div>
        </div>
        <div id="locDiv" style="display: none">
            this the location bit
        </div>
    </div>
</body>
</html>

<script>
    function goto(page) {
        window.location=page;
    }
</script>
