<%--
  Created by IntelliJ IDEA.
  User: Justin Ritter
  Date: 5/3/2017
  Time: 5:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <div id="nav_bar">
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel="stylesheet" type="text/css" href="../../overall.css">
        <title>This is my template now</title>
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
    <div id="wellTable" class="tables">
        <h4 class="text-center"> Well Table</h4>
        <table class="table" border="1">
            <tr>
                <td>wellID</td>
                <td>usage</td>
                <td>aquafier</td>
                <td>type_code</td>
                <td>comment</td>
                <td>top_depth</td>
                <td>bottom_depth</td>
                <td>depth</td>
                <td>bottom_elevation</td>
                <td>water_level</td>
                <td>land_elevation</td>
                <td>diameter</td>
                <td>casing</td>
                <td>pump_description</td>
                <td>state</td>
                <td>county</td>
                <td>latitude</td>
                <td>longitude</td>
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

                    sql = "SELECT * from ritSpaGee.Well";
                    ResultSet rs = stmt.executeQuery(sql);

                    while(rs.next())
                    {
            %>
            <tr>
                <td><%=rs.getInt("wellID")%></td>
                <td><%=rs.getString("usagee")%></td>
                <td><%=rs.getString("aquafier_code")%></td>
                <td><%=rs.getString("type_code")%></td>
                <td><%=rs.getString("comment")%></td>
                <td><%=rs.getString("top_depth")%></td>
                <td><%=rs.getString("bottom_depth")%></td>
                <td><%=rs.getString("depth")%></td>
                <td><%=rs.getString("bottom_elevation")%></td>
                <td><%=rs.getString("water_level_elevation")%></td>
                <td><%=rs.getString("land_elevation")%></td>
                <td><%=rs.getString("diameter")%></td>
                <td><%=rs.getString("casingID")%></td>
                <td><%=rs.getString("pump_description")%></td>
                <td><%=rs.getString("state")%></td>
                <td><%=rs.getString("county")%></td>
                <td><%=rs.getString("latitude")%></td>
                <td><%=rs.getString("longitude")%></td>
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
    </div>
</body>
</html>

<script>
    function goto(page) {
        window.location=page;
    }
</script>