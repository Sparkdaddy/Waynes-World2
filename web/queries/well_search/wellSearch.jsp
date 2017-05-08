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
    <div id="alertDiv" class="alert" style="display: none">
        <span class="clsX" onclick="this.parentElement.style.display='none';">&times;</span>
        <strong>Error: </strong>
    </div>
    <div id="wellTable" class="tables">
        <h4 class="text-center"> Well Table</h4>
        <table class="table" border="1">
                <tr>
                    <td>wellID</td>
                    <td>usage</td>
                    <td>aquafier_code</td>
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
            <%
                try
                {
                    //gathering parameters from user
                    String sqlStmt,id,aquCode,typCode,owner;
                    int reqired = 0;
                    id = request.getParameter("wellId");
                    aquCode = request.getParameter("aqua_Code");
                    typCode = request.getParameter("type_Code");
                    owner = request.getParameter("owner");

                    //building sql statment
                    sqlStmt = "SELECT * from ritSpaGee.Well w, ritSpaGee.Owner o where ";
                    if(!id.isEmpty()) {
                        sqlStmt += "w.wellID=" + id + " and ";
                        reqired++;
                    }
                    if(!owner.isEmpty()) {
                        sqlStmt += "o.name=\"" + owner + "\" and w.wellID = o.wellID and ";
                        reqired++;
            %>
                    <td>owner</td>
            <%
                    }
                    else if (!id.isEmpty() && owner.isEmpty()) {
                        sqlStmt = "SELECT * FROM ritSpaGee.Well WHERE wellID=" + id + " and ";
                    }
                    if(!aquCode.isEmpty()) {
                        sqlStmt += "w.aquafier_code=\"" + aquCode + "\" and ";
                        reqired++;
                    }
                    if(!typCode.isEmpty()) {
                        sqlStmt += "w.type_code=\"" + typCode + "\"";
                        reqired++;
                    }
                    if(sqlStmt.endsWith("and ")) {
                        sqlStmt = sqlStmt.substring(0,sqlStmt.length()-4);
                    }
                    if(reqired < 1) {
                        throw new Exception("at least one parameter must be entered");
                    }
                System.out.println(sqlStmt);
            %>
                </tr>
            <%

                    //retieving
                    String DB_URL = "jdbc:mysql://mama.c95cjqkvfcem.us-east-1.rds.amazonaws.com:3306";
                    String USER = "ritSpaGee";
                    String PASS = "geeterman";
                    Connection conn = null;
                    PreparedStatement pstmt;
                    //STEP 2: Register JDBC driver
                    Class.forName("com.mysql.jdbc.Driver");
                    //STEP 3: Open a connection
                    System.out.println("Connecting to database...");
                    conn = DriverManager.getConnection(DB_URL,USER,PASS);
                    //STEP 4: Execute a query
                    System.out.println("Creating statement...");
                    pstmt = conn.prepareStatement(sqlStmt);
                    ResultSet rs = pstmt.executeQuery();

                    String wellID;
                    if(rs.isBeforeFirst()) {
                        while(rs.next())
                        {
                            wellID = rs.getString("wellID");
                        %>
                <tr>
                    <td><%=wellID%></td>
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
                            <%
                            if(!owner.isEmpty()) {
                            %>
                                <td><%=rs.getString("name")%></td>
                            <%
                                }
                            %>
                </tr>
                        <%
                        }
                    }
                    else {
                        //display input error
                        String idUsed = "";
                        if(!id.isEmpty()) {
                            idUsed += "wellID=" + id + ", ";
                        }
                        if(!owner.isEmpty()) {
                            idUsed += "owner=" +owner + ", ";
                        }
                        if(!aquCode.isEmpty()) {
                            idUsed += "aquifer_code=" + aquCode + ", ";
                        }
                        if(!typCode.isEmpty()) {
                            idUsed += "type_code=" + typCode;
                        }

                        //remove hanging comma
                        if(idUsed.endsWith(", ")) {
                            idUsed = idUsed.substring(0, idUsed.length()-2);
                        }
                        throw new Exception("No data " + idUsed);
                    }
                    rs.close();
                    pstmt.close();
                    conn.close();
                }
                catch(Exception e)
                {
                %>
        <script>
            document.getElementById('wellTable').style.display='none';
            document.getElementById('alertDiv').style.display='block';
            var node = document.createElement("A");
            var x = document.createTextNode("<%=e.getMessage()%>");
            node.appendChild(x);
            document.getElementById('alertDiv').appendChild(node);
        </script>
                <%
                }
            %>
        </table>
    </div>
</body>
</html>

<script>
    function goto(page) {
        window.location=page;
    }
</script>