<%--
  Created by IntelliJ IDEA.
  User: Justin Ritter
  Date: 5/3/2017
  Time: 11:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="javax.swing.text.StyledEditorKit" %>
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
        <input id="wellchk" type="button" name="tables" value="well" onclick="goto('../well_search/well_search.jsp')">
        <input id="transchk" type="button" name="tables" value="transducer" onclick="goto('trans_search.jsp')">
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
    <div id="topTable" class="tables">
        <%
            try
            {
                //gathering parameters from user
                String sqlStmt,sqlStmt2,sensID,wID,tStart,tEnd,rain;


                sqlStmt = "SELECT * FROM ritSpaGee.Well w, ritSpaGee.Transducer t WHERE w.wellID = t.wellID AND ";
                sqlStmt2 = "SELECT * FROM ritSpaGee.Water w, ritSpaGee.Transducer t WHERE t.transID = w.transID";
                int required = 0;

                sensID = request.getParameter("sensID");
                wID = request.getParameter("wellID");
                tStart = request.getParameter("tStart");
                tEnd = request.getParameter("tEnd");
                rain = request.getParameter("rain");

                if(!sensID.isEmpty()) {
                    sqlStmt += "t.transID = \"" + sensID + "\" AND ";
                    required++;
                }
                if(!wID.isEmpty()) {
                    sqlStmt += "w.wellID = " + wID;
                    required++;
                }
                if(!tStart.isEmpty() ) {
                    if(!sensID.isEmpty()) {
                        sqlStmt2 += " AND t.transID = \"" + sensID + "\" AND w.timedate >= \"" + tStart + "\" AND ";
                        required++;
                    }
                    else {
                        throw new Exception("the sensor id must be entered to search with time");
                    }
                }
                if(!tEnd.isEmpty()) {
                    if(!sensID.isEmpty()) {
                        sqlStmt2 += "w.timedate <= \"" + tEnd + "\"";
                        required++;
                    }
                    else {
                        throw new Exception("the sensor id must be entered to search with time");
                    }
                }
                else if (tEnd.isEmpty() && !tStart.isEmpty()){
                    throw new Exception("both start and end times are needed");
                }
                if(sqlStmt.endsWith("AND ")) {
                    sqlStmt = sqlStmt.substring(0,sqlStmt.length()-5);
                }
                if (required < 1){
                    throw new Exception("at least one parameter must be entered");
                }
                System.out.println(sqlStmt);
                System.out.println(sqlStmt2);

                //connect to database
                String DB_URL = "jdbc:mysql://mama.c95cjqkvfcem.us-east-1.rds.amazonaws.com:3306";
                String USER = "ritSpaGee";
                String PASS = "geeterman";
                Connection conn = null;
                Statement stmt = null;
                Statement stmt2 = null;
                //STEP 2: Register JDBC driver
                Class.forName("com.mysql.jdbc.Driver");
                //STEP 3: Open a connection
                System.out.println("Connecting to database...");
                conn = DriverManager.getConnection(DB_URL,USER,PASS);
                //STEP 4: Execute a query
                System.out.println("Creating statement...");
                stmt = conn.createStatement();
                stmt2 = conn.createStatement();

                ResultSet rs = stmt.executeQuery(sqlStmt);

        %>
        <ul class="list">
            <li><div id="transTable" class="tables">
                <h4 class="text-center"> Transducer Table</h4>
                <table class="table" border="1">
                    <tr>
                        <td>wellID</td>
                        <td>transducerID</td>
                    </tr>
                    <%

                        if(rs.isBeforeFirst()) {
                            while(rs.next())
                            {
                                String id = rs.getString("w.wellID");
                    %>
                    <tr>
                        <td><%=id%></td>
                        <td><%=rs.getString("t.transID")%></td>
                    </tr>
                    <%
                            }
                        }
                        else {
                            throw new Exception("No data");
                        }
                    %>
                </table>
            </div></li>
            <li><div id="timeTable" class="tables">
                <%
                    List<String> csvList = new ArrayList<>();
                    rs = stmt.executeQuery(sqlStmt2);
                    if(rs.isBeforeFirst()) {
                        while(rs.next()) {
                            csvList.add(rs.getString("wellID"));
                            csvList.add(rs.getString("timedate"));
                            csvList.add(rs.getString("salinity"));
                            csvList.add(rs.getString("temperature"));
                            csvList.add(rs.getString("conductivity"));
                            csvList.add(rs.getString("pressure"));
                            csvList.add(rs.getString("TDS"));
                        }
                    }
                    else {
                        throw new Exception("No data");
                    }

                    String result = "[";
                    for(int i = 0; i < csvList.size(); i++) {
                        result += "\"" + csvList.get(i) + "\"";
                        if(i < csvList.size() - 1) {
                            result += ", ";
                        }
                    }
                    result += "]";
                %>
                <script>
                    function download_csv() {
                        var data;
                        data = new Array(<%=result%>);
                        var csv = 'Time,Salinity,Temperature,Conductivity,Pressure,TDS\n';
                        csv += data;
                        csv += "\n";

                        console.log(data);
                        console.log(csv);
                        var action = document.createElement('a');
                        action.href = 'data:text/csv:charset=utf-8,' + encodeURI(csv);
                        action.target = '_blank';
                        action.download = 'timeTable.csv';
                        action.click();
                    }
                </script>

                <h4 class="text-center">Time/Rain Table</h4>
                <button onclick="download_csv()">Download CSV</button>
                <table class="table" border="1">
                    <tr>
                        <td>wellID</td>
                        <td>time</td>
                        <td>salinity</td>
                        <td>temperature</td>
                        <td>conductivity</td>
                        <td>pressure</td>
                        <td>TDS</td>
                        <td>latitude</td>
                        <td>longitude</td>
                        <td>actual Rain amount</td>
                        <td>normal Rain amount</td>
                    </tr>
                <%
                    String sqlStmtRain = "SELECT r.latitude,r.longitude,r.actual_amount,r.normal_amount " +
                            "FROM ritSpaGee.Well w,ritSpaGee.Rainfall r " +
                            "WHERE w.wellID =\"" + wID + "\" AND w.latitude = r.latitude AND w.longitude = r.longitude";
                    ResultSet rsRain = stmt2.executeQuery(sqlStmtRain);
                    rs = stmt.executeQuery(sqlStmt2);
                    if(rs.isBeforeFirst()) {
                        while(rs.next())
                        {
                %>
                    <tr>
                        <td><%=rs.getString("wellID")%></td>
                        <td><%=rs.getString("timedate")%></td>
                        <td><%=rs.getString("salinity")%></td>
                        <td><%=rs.getString("temperature")%></td>
                        <td><%=rs.getString("conductivity")%></td>
                        <td><%=rs.getString("pressure")%></td>
                        <td><%=rs.getString("TDS")%></td>
                <%
                            if(rsRain.next()) {
                                if(!rain.isEmpty()) {
                                %>

                        <td><%=rsRain.getString("r.latitude")%></td>
                        <td><%=rsRain.getString("r.longitude")%></td>
                        <td><%=rsRain.getString("r.actual_amount")%></td>
                        <td><%=rsRain.getString("r.normal_amount")%></td>
                        <%
                                }
                            }
                            else {
                                System.out.println("No rainfall data");
                            }
                %>
                    </tr>
                <%
                        }
                    }
                    else {
                        throw new Exception("No data");
                    }
                %>
                </table>
            </div></li>
        </ul>

        <%
            rs.close();
            stmt.close();
            conn.close();
        }
        catch(Exception e)
        {
        %>
        <script>
            document.getElementById('topTable').style.display='none';
            document.getElementById('alertDiv').style.display='block';
            var node = document.createElement("A");
            var x = document.createTextNode("<%=e.getMessage()%>");
            node.appendChild(x);
            document.getElementById('alertDiv').appendChild(node);
        </script>
        <%
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
