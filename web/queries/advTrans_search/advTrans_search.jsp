<%--
  Created by IntelliJ IDEA.
  User: Justin Ritter
  Date: 5/4/2017
  Time: 1:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <!-- Navigation Bar -->
    <div id="nav_bar">
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel="stylesheet" type="text/css" href="../../overall.css">
        <title>Water Management</title>
        <ul class="inlineList">
            <li><a href="../../index.jsp"><i class="menu-button"></i> Home</a></li>
            <li><a href="../searchPage.jsp"><i class="menu-button"></i> Search</a></li>
            <li><a href="../../upload/upload_home.jsp"><i class="menu-button"></i> Upload </a></li>
        </ul>
        <hr class="row"/>
    </div>

    <!-- Search Options -->
    <div id="searchPages">
        <h2>Select the search you would like to do</h2>
        <input id="wellchk" type="button" name="tables" value="well" onclick="goto('../well_search/well_search.jsp')">
        <input id="transchk" type="button" name="tables" value="transducer"
               onclick="goto('../trans_search/trans_search.jsp')">
        <input id="analysis" type="button" name="tables" value="advanced transducer analysis"
               onclick="goto('advTrans_search.jsp')">
        <input id="locchk" type="button" name="tables" value="location" onclick="goto('../loc_search/loc_search.jsp')">
        <br/>
    </div>

</head>

<body>

<!-- Transducer ID Text Box and Submit Button -->
<form name="trans" method="get" action="advTransSearch.jsp">
    Transducer ID:
    <input type="text" name="transId" id="transId">
    <input type="submit" value="Search">
</form>
</body>
</html>

<script>
    function goto(page) {
        window.location = page;
    }
</script>