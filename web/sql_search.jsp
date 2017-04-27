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
    <title>Use me as a template</title>
    <ul class="nav navbar-nav navbar-right">
        <li><a href="form_upload.jsp"><i class="menu-button"></i> About</a></li>
        <li><a href="index.jsp"><i class="menu-button"></i> INDEX</a></li>
        <li><a href="sql_search.jsp"><i class="fa fa-comment"></i> Contact</a></li>
    </ul>
</head>

<div class="container">
    <div class="row">
        <h3 class="text-center"> First display table </h3>
    </div>
    <form method="post">

        <table class="table table-hover" border="1">
            <tr>
                <td>wellID</td>
                <td>aquafier</td>
                <td>state</td>
                <td>country</td>
            </tr>
            <%
                try
                {
                    String DB_URL = "jdbc:mysql://mama.c95cjqkvfcem.us-east-1.rds.amazonaws.com:3306";
                    String USER = "ritSpaGee";
                    String PASS = "geeterman";
                    Connection conn = null;
                    Statement stmt = null;
                    //STEP 2: Register JDBC driver
                    Class.forName("com.mysql.jdbc.Driver");
                    //STEP 3: Open a connection
                    System.out.println("Connecting to database...");
                    conn = DriverManager.getConnection(DB_URL,USER,PASS);
                    //STEP 4: Execute a query
                    System.out.println("Creating statement...");
                    stmt = conn.createStatement();
                    String sql;
                    sql = "SELECT * FROM ritSpaGee.Well";
                    ResultSet rs = stmt.executeQuery(sql);

                    while(rs.next())
                    {
            %>
            <tr>
                <td><%=rs.getInt("wellID")%></td>
                <td><%=rs.getString("aquafier_code")%></td>
                <td><%=rs.getString("state")%></td>
                <td><%=rs.getString("country")%></td>
            </tr>
            <%

                }
            %>
        </table>
        <%
                rs.close();
                stmt.close();
                conn.close();
            }
            catch(Exception e)
            {
                e.printStackTrace();
                out.println("<h1> error: "+ e.getMessage()+"</h1>");
            }

        %>

    </form>
</html>
</div>