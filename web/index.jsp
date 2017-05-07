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
    <link rel="stylesheet" type="text/css" href="overall.css">
    <title>Water Data Management</title>
    <ul class="inlineList">
        <li><a href="index.jsp"><i class="menu-button"></i> Home</a></li>
        <li><a href="${pageContext.request.contextPath}/queries/searchPage.jsp"><i class="menu-button"></i> Search</a>
        </li>
        <li><a href="upload/upload_home.jsp"><i class="menu-button"></i> Upload </a></li>

    </ul>
    <hr class="row"/>
</head>

<body>
<style>
    h4 {
        display: inline;
    }
    p{
        margin-top: 0;
        margin-right: 30%;
    }
</style>

<h3>Welcome to your water data management website.</h3>
<h4>Purpose</h4>

<p>
    We've provided a way to input and analyze information about wells from around the country.
    Uploads can be performed via a file or manual input.
    Searches can be performed based on well, transducer (water sensor), or location information.
    Rainfall information can also be input so that it can be factored into water data analysis.
</p>

<h4>About</h4>

<p>
    This website was created with JSP and JDBC by Austin, Justin, and Alicia as a part of
    a database design course.
</p>
</body>
</html>