<%--
  Created by IntelliJ IDEA.
  User: magee
  Date: 5/4/2017
  Time: 8:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.util.Vector" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>

<html>

<head>
    <div id="nav_bar">
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel="stylesheet" type="text/css" href="../../overall.css">
        <title>Advanced Transducer Analysis</title>
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
        <input id="transchk" type="button" name="tables" value="transducer" onclick="goto('../trans_search/trans_search.jsp')">
        <input id="analysis" type="button" name="tables" value="advanced transducer analysis" onclick="goto('advTrans_search.jsp')">
        <input id="locchk" type="button" name="tables" value="location" onclick="goto('../loc_search/loc_search.jsp')">
        <br/>
    </div>

</head>

<body>

<div id="correlation">
    <%!
        public class Water {
            public Vector<Integer> date;
            public Vector<Double> sal;
            public Vector<Double> temp;
            public Vector<Double> cond;
            public Vector<Double> press;
            public Vector<Double> TDS;
            public double salTemp;
            public double salCond;
            public double salPress;
            public double salTDS;
            public double tempCond;
            public double tempPress;
            public double tempTDS;
            public double condPress;
            public double condTDS;
            public double pressTDS;

            public Water(){
                date = new Vector<>();
                sal = new Vector<>();
                temp = new Vector<>();
                cond = new Vector<>();
                press = new Vector<>();
                TDS = new Vector<>();
                salTemp = 0;
                salCond = 0;
                salPress = 0;
                salTDS = 0;
                tempCond = 0;
                tempPress = 0;
                tempTDS = 0;
                condPress = 0;
                condTDS = 0;
                pressTDS = 0;
            }
        }

        public double getR(Vector<Double> a, Vector<Double> b){
            double uA, uB, oA, oB, sum, c;
            uA = uB = oA = oB = sum = c = 0;

            if(a.size() == b.size()){

                for(int i = 0; i < a.size(); i++){
                    uA += a.elementAt(i);
                    uB += b.elementAt(i);
                }

                for(int i = 0; i < a.size(); i++){
                    oA += Math.pow((a.elementAt(i) - uA), 2.0);
                    oB += Math.pow((b.elementAt(i) - uB), 2.0);
                    sum += (a.elementAt(i) - uA) * (b.elementAt(i) - uB);
                }

                oA = Math.sqrt(oA / a.size());
                oB = Math.sqrt(oB / a.size());

                c = sum / a.size() / (oA * oB);

            }
            return c;
        }
    %>
    <%
        try
        {
            Water waterData = new Water();

            NumberFormat nf = NumberFormat.getInstance();
            nf.setMaximumFractionDigits(3);
            nf.setMinimumFractionDigits(3);

            String id = request.getParameter("transId");

            String DB_URL = "jdbc:mysql://mama.c95cjqkvfcem.us-east-1.rds.amazonaws.com:3306";
            String USER = "ritSpaGee";
            String PASS = "geeterman";

            Connection conn;
            PreparedStatement pstmt;

            // Register JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Connect to the database
            conn = DriverManager.getConnection(DB_URL,USER,PASS);

            // Get water data for the transducer specified by the user.
            pstmt = conn.prepareStatement("SELECT * FROM ritSpaGee.Water WHERE transID = ?");
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();

            // Store all water data for this particular transducer
            while(rs.next())
            {
                waterData.date.add(rs.getInt("timeDate"));
                waterData.sal.add(rs.getDouble("salinity"));
                waterData.temp.add(rs.getDouble("temperature"));
                waterData.cond.add(rs.getDouble("conductivity"));
                waterData.press.add(rs.getDouble("pressure"));
                waterData.TDS.add(rs.getDouble("TDS"));

            }

            // Find pearson correlation coefficients for all pairs of
            // series of water attributes
            if(!waterData.sal.isEmpty()) {
                waterData.salTemp = getR(waterData.sal, waterData.temp);
                waterData.salCond = getR(waterData.sal, waterData.cond);
                waterData.salPress = getR(waterData.sal, waterData.press);
                waterData.salTDS = getR(waterData.sal, waterData.TDS);
                waterData.tempCond = getR(waterData.temp, waterData.cond);
                waterData.tempPress = getR(waterData.temp, waterData.press);
                waterData.tempTDS = getR(waterData.temp, waterData.TDS);
                waterData.condPress = getR(waterData.cond, waterData.press);
                waterData.condTDS = getR(waterData.cond, waterData.TDS);
                waterData.pressTDS = getR(waterData.press, waterData.TDS);
                %>

                <table class="table" border="1">
                    <h4 class="text-center"> Pearson Correlation Coefficients</h4>
                    <tr>
                        <td></td>
                        <td>Temperature</td>
                        <td>Conductivity</td>
                        <td>Pressure</td>
                        <td>TDS</td>
                    </tr>
                    <tr>
                        <td>Salinity</td>
                        <td><%=nf.format(waterData.salTemp)%></td>
                        <td><%=nf.format(waterData.salCond)%></td>
                        <td><%=nf.format(waterData.salPress)%></td>
                        <td><%=nf.format(waterData.salTDS)%></td>
                    </tr>
                    <tr>
                        <td>Temperature</td>
                        <td></td>
                        <td><%=nf.format(waterData.tempCond)%></td>
                        <td><%=nf.format(waterData.tempPress)%></td>
                        <td><%=nf.format(waterData.tempTDS)%></td>
                    </tr>
                    <tr>
                        <td>Conductivity</td>
                        <td></td>
                        <td></td>
                        <td><%=nf.format(waterData.condPress)%></td>
                        <td><%=nf.format(waterData.condTDS)%></td>
                    </tr>
                    <tr>
                        <td>Pressure</td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td><%=nf.format(waterData.pressTDS)%></td>
                    </tr>

                </table>
        <%
            }
            else{
        %>
                No water data is available for transducer <%=id%>.
        <%
            }

            rs.close();
            pstmt.close();
            conn.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
            System.out.println("<h1> error: "+ e.getMessage()+"</h1>");
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
