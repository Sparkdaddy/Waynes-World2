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
    <link rel="stylesheet" type="text/css" href="../overall.css">
    <title>This is my template now</title>
    <ul class="inlineList">
        <li><a href="../index.jsp"><i class="menu-button"></i> Home</a></li>
        <li><a href="sql_search.jsp"><i class="menu-button"></i> Search</a></li>
        <li><a href="../upload/upload_home.jsp"><i class="menu-button"></i> Upload </a> </li>
    </ul>
    <hr class="row" />
</head>
<br/>
<body>
    <h2>Select the table to search through</h2>
    well:
    <input id="wellchk" type="radio" name="tables" value="wellDiv" onclick="showDivOnclick()" ondblclick="uncheck('wellchk')">
    transducer:
    <input id="transchk" type="radio" name="tables" value="transDiv" onclick="showDivOnclick()" ondblclick="uncheck('transchk')">
    location:
    <input id="locchk" type="radio" name="tables" value="locDiv" onclick="showDivOnclick()" ondblclick="uncheck('locchk')">
    <br/>

    <div id="myDiv">
        This is my DIV element.
        <div id="wellDiv" style="display: none">
            this is the well bit
            <div class="row">
                <h4 class="text-center"> Well Table</h4>
            </div>
            <form action="searching.jsp" method="post">
                <table class="table table-hover" border="1">
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

            </form>
        </div>
        <div id="transDiv" style="display: none">
            this is the transducer bit
        </div>
        <div id="locDiv" style="display: none">
            this the location bit
        </div>
    </div>

    <div class="container">


    </div>

    <script>
        function showDivOnclick() {
            var x;
            var check = document.getElementsByName('tables');
            for(var i=0; i < check.length; i++)
            {
                x = document.getElementById(check[i].value);
                if (check[i].checked) {
                    x.style.display = 'block';
                } else {
                    x.style.display = 'none';
                }
            }
        }

        function uncheck(val) {
            var x = document.getElementById(val);
            x.checked = false;
            document.getElementById(x.value).style.display = 'none';
        }
    </script>
</body>
</html>
