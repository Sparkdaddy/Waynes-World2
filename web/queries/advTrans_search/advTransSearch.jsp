<%--
  Created by IntelliJ IDEA.
  User: magee
  Date: 5/4/2017
  Time: 8:43 AM
--%>

<%@ page import="java.util.Vector" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Calendar" %>

<html>

<head>
    <!-- Navigation Bar -->
    <div id="nav_bar">
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link rel="stylesheet" type="text/css" href="../../overall.css">
        <title>Advanced Transducer Analysis</title>

        <ul class="inlineList">
            <li><a href="../../index.jsp"><i class="menu-button"></i> Home</a></li>
            <li><a href="../searchPage.jsp"><i class="menu-button"></i> Search</a></li>
            <li><a href="../../upload/upload_home.jsp"><i class="menu-button"></i> Upload </a></li>
        </ul>

        <hr class="row"/>
    </div>

    <!-- Search options -->
    <div id="searchPages">
        <h2>Search</h2>
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

<div id="correlation">
    <%!
        // Water class for storing transducer water data
        public class Water {
            public Vector<Timestamp> date;
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

            public Water() {
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

        // Gets the correlation coefficient for any two series of the same length
        public double getR(Vector<Double> a, Vector<Double> b) {
            double uA, uB, oA, oB, sum, c;
            uA = uB = oA = oB = sum = c = 0;

            if (a.size() == b.size()) {

                for (int i = 0; i < a.size(); i++) {
                    uA += a.elementAt(i);
                    uB += b.elementAt(i);
                }

                for (int i = 0; i < a.size(); i++) {
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
        try {
            Water waterData = new Water();

            Boolean onlyOne = false;
            Boolean finished;

            NumberFormat nf = NumberFormat.getInstance();
            nf.setMaximumFractionDigits(4);
            nf.setMinimumFractionDigits(1);

            String id = request.getParameter("transId");

            String DB_URL = "jdbc:mysql://mama.c95cjqkvfcem.us-east-1.rds.amazonaws.com:3306";
            String USER = "ritSpaGee";
            String PASS = "geeterman";

            Connection conn;
            PreparedStatement pstmt;

            // Register JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Connect to the database
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            // Get water data for the transducer specified by the user.
            pstmt = conn.prepareStatement("SELECT * FROM ritSpaGee.Water WHERE transID = ?");
            pstmt.setString(1, id);
            ResultSet rs = pstmt.executeQuery();

            Date tempD;
            Timestamp tempT;

            // Store all water data for this particular transducer
            while (rs.next()) {
                tempD = rs.getDate("timedate");
                tempT = new Timestamp(tempD.getTime());
                waterData.date.add(tempT);
                waterData.sal.add(rs.getDouble("salinity"));
                waterData.temp.add(rs.getDouble("temperature"));
                waterData.cond.add(rs.getDouble("conductivity"));
                waterData.press.add(rs.getDouble("pressure"));
                waterData.TDS.add(rs.getDouble("TDS"));

            }

            // Find pearson correlation coefficients for all pairs of
            // series of water attributes
            if (!waterData.sal.isEmpty()) {
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
            <td><%=nf.format(waterData.salTemp)%>
            </td>
            <td><%=nf.format(waterData.salCond)%>
            </td>
            <td><%=nf.format(waterData.salPress)%>
            </td>
            <td><%=nf.format(waterData.salTDS)%>
            </td>
        </tr>
        <tr>
            <td>Temperature</td>
            <td></td>
            <td><%=nf.format(waterData.tempCond)%>
            </td>
            <td><%=nf.format(waterData.tempPress)%>
            </td>
            <td><%=nf.format(waterData.tempTDS)%>
            </td>
        </tr>
        <tr>
            <td>Conductivity</td>
            <td></td>
            <td></td>
            <td><%=nf.format(waterData.condPress)%>
            </td>
            <td><%=nf.format(waterData.condTDS)%>
            </td>
        </tr>
        <tr>
            <td>Pressure</td>
            <td></td>
            <td></td>
            <td></td>
            <td><%=nf.format(waterData.pressTDS)%>
            </td>
        </tr>

    </table>
    <%
    } else {
    %>
    No water data is available for transducer <%=id%>.
    <%
        }

        rs.close();
        pstmt.close();

        // Find the transducer's corresponding well
        pstmt = conn.prepareStatement("SELECT wellID FROM ritSpaGee.Transducer WHERE transID = ?");
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();
        rs.next();
        String wellID = rs.getString("wellID");

        pstmt.close();
        rs.close();

        // Find the well's latitude and longitude
        pstmt = conn.prepareStatement("SELECT latitude, longitude FROM ritSpaGee.Well WHERE wellID = ?");
        pstmt.setString(1, wellID);
        rs = pstmt.executeQuery();

        rs.next();
        Double la, lo;

        la = rs.getDouble("latitude");
        lo = rs.getDouble("longitude");

        pstmt.close();
        rs.close();

        // Find rainfall data near that latitude and longitude
        pstmt = conn.prepareStatement("SELECT date " +
                "FROM ritSpaGee.Rainfall " +
                "WHERE latitude < ? + 0.1 AND latitude > ? - 0.1 " +
                "AND longitude < ? + 0.1 AND longitude > ? - 0.1 " +
                "ORDER BY date");
        pstmt.setDouble(1, la);
        pstmt.setDouble(2, la);
        pstmt.setDouble(3, lo);
        pstmt.setDouble(4, lo);

        rs = pstmt.executeQuery();

        Timestamp ts;
        java.util.Date date;
        java.util.Calendar first = Calendar.getInstance();
        java.util.Calendar temp = Calendar.getInstance();
        java.util.Calendar last = Calendar.getInstance();

        PreparedStatement p2;
        ResultSet r2;

        Water w = new Water();
        Double dS, dT, dC, dP, dTDS;

    %>
    <br>
    <h3>Transducer Data from Days with Rain</h3>

    <%


        // For all the info
        while (rs.next()) {

            // Set finished to false because we're not finished yet
            finished = false;

            // Get the first timestamp
            ts = rs.getTimestamp("date");
            date = ts;
            // Set the time of the first and last consecutive days with rain
            first.setTime(date);
            last.setTime(date);

            // If there are more days with rain
            if (rs.next()) {

                // Get the timestamp of the next day with rain
                ts = rs.getTimestamp("date");
                date = ts;

                // Store that timestamp in temp
                temp.setTime(date);

                // Increment last to the following calendar day
                last.add(Calendar.DAY_OF_MONTH, 1);

                // If the following calendar day equals the next day with rain
                if (last.get(Calendar.DAY_OF_MONTH) == temp.get(Calendar.DAY_OF_MONTH)) {

                    // While the following calendar day equals the next day with rain
                    while (last.get(Calendar.DAY_OF_MONTH) == temp.get(Calendar.DAY_OF_MONTH) && !finished) {

                        // Set last to temp
                        last.setTime(temp.getTime());

                        // If there is still more rain data
                        if (rs.next()) {

                            // Get the timestamp of the next day with rain
                            ts = rs.getTimestamp("date");
                            date = ts;

                            // Set temp to the next day with rain
                            temp.setTime(date);
                        }
                        // If there isn't more rain data, we're finished with this segment
                        else {
                            finished = true;
                        }
                    }

                    // Set last to the day after the last consecutive day with rain
                    last.add(Calendar.DAY_OF_MONTH, 1);
                }
            }
            // If there aren't more days with rain
            else {
                // Set last to the day after the last consecutive day with rain
                last.add(Calendar.DAY_OF_MONTH, 1);

                // Indicate that there was only one day with rain
                onlyOne = true;
            }

            // Give last the time of midnight (end of the last consecutive day with rain)
            last.set(last.get(Calendar.YEAR), last.get(Calendar.MONTH), last.get(Calendar.DAY_OF_MONTH), 0, 0, 0);

            // Create timestamps from the first and last dates
            date = first.getTime();
            Timestamp t1 = new Timestamp(date.getTime());
            date = last.getTime();
            Timestamp t2 = new Timestamp(date.getTime());

    %>

    <!-- Dates for rainfall table -->
    <h4 class="text-center"><%=t1.toString()%> - <%=t2.toString()%>
    </h4>
    <%

        // Find transducer data for the consecutive days with rain
        p2 = conn.prepareStatement("SELECT * " +
                "FROM ritSpaGee.Water " +
                "WHERE transID = ? AND timedate >= ? AND timedate < ? " +
                "ORDER BY timedate");
        p2.setString(1, id);
        p2.setTimestamp(2, t1);
        p2.setTimestamp(3, t2);

        r2 = p2.executeQuery();

        // While there is still transducer data
        while (r2.next()) {

            // Store the data in w
            Timestamp time = r2.getTimestamp("timedate");
            w.date.add(time);
            w.sal.add(r2.getDouble("salinity"));
            w.temp.add(r2.getDouble("temperature"));
            w.cond.add(r2.getDouble("conductivity"));
            w.press.add(r2.getDouble("pressure"));
            w.TDS.add(r2.getDouble("TDS"));
        }

        // If there is data, calculate correlation coefficients
        if (!w.sal.isEmpty()) {
            w.salTemp = getR(w.sal, w.temp);
            w.salCond = getR(w.sal, w.cond);
            w.salPress = getR(w.sal, w.press);
            w.salTDS = getR(w.sal, w.TDS);
            w.tempCond = getR(w.temp, w.cond);
            w.tempPress = getR(w.temp, w.press);
            w.tempTDS = getR(w.temp, w.TDS);
            w.condPress = getR(w.cond, w.press);
            w.condTDS = getR(w.cond, w.TDS);
            w.pressTDS = getR(w.press, w.TDS);
    %>

    <!-- Correlation Coefficients -->
    <table class="table" border="1">
        <tr>
            <td></td>
            <td>Temperature</td>
            <td>Conductivity</td>
            <td>Pressure</td>
            <td>TDS</td>
        </tr>
        <tr>
            <td>Salinity</td>
            <td><%=nf.format(w.salTemp)%>
            </td>
            <td><%=nf.format(w.salCond)%>
            </td>
            <td><%=nf.format(w.salPress)%>
            </td>
            <td><%=nf.format(w.salTDS)%>
            </td>
        </tr>
        <tr>
            <td>Temperature</td>
            <td></td>
            <td><%=nf.format(w.tempCond)%>
            </td>
            <td><%=nf.format(w.tempPress)%>
            </td>
            <td><%=nf.format(w.tempTDS)%>
            </td>
        </tr>
        <tr>
            <td>Conductivity</td>
            <td></td>
            <td></td>
            <td><%=nf.format(w.condPress)%>
            </td>
            <td><%=nf.format(w.condTDS)%>
            </td>
        </tr>
        <tr>
            <td>Pressure</td>
            <td></td>
            <td></td>
            <td></td>
            <td><%=nf.format(w.pressTDS)%>
            </td>
        </tr>

    </table>

    <br>

    <!-- Transducer Data with Difference Values -->
    <table border="1">
        <tr>
            <td>Date</td>
            <td>Salinity</td>
            <td>S change</td>
            <td>Temperature</td>
            <td>T change</td>
            <td>Conductivity</td>
            <td>C Change</td>
            <td>Pressure</td>
            <td>P Change</td>
            <td>TDS</td>
            <td>TDS Change</td>
        </tr>

        <tr>
            <td><%=w.date.elementAt(0).toString()%>
            </td>
            <td><%=w.sal.elementAt(0)%>
            </td>
            <td></td>
            <td><%=w.temp.elementAt(0)%>
            </td>
            <td></td>
            <td><%=w.cond.elementAt(0)%>
            </td>
            <td></td>
            <td><%=w.press.elementAt(0)%>
            </td>
            <td></td>
            <td><%=w.TDS.elementAt(0)%>
            </td>
            <td></td>
        </tr>
        <%

            // Calculate changes between each reading
            for (int i = 1; i < w.sal.size(); i++) {
                dS = w.sal.elementAt(i) - w.sal.elementAt(i - 1);
                dT = w.temp.elementAt(i) - w.temp.elementAt(i - 1);
                dC = w.cond.elementAt(i) - w.cond.elementAt(i - 1);
                dP = w.press.elementAt(i) - w.press.elementAt(i - 1);
                dTDS = w.TDS.elementAt(i) - w.TDS.elementAt(i - 1);

                // If changes are negligable, set to 0
                if (Math.abs(dS) < 0.0001) {
                    dS = 0.0;
                }
                if (Math.abs(dT) < 0.0001) {
                    dT = 0.0;
                }
                if (Math.abs(dC) < 0.0001) {
                    dC = 0.0;
                }
                if (Math.abs(dP) < 0.0001) {
                    dP = 0.0;
                }
                if (Math.abs(dTDS) < 0.0001) {
                    dTDS = 0.0;
                }
        %>
        <tr>
            <td><%=w.date.elementAt(i).toString()%>
            </td>
            <td><%=w.sal.elementAt(i)%>
            </td>
            <td><%=nf.format(dS)%>
            </td>
            <td><%=w.temp.elementAt(i)%>
            </td>
            <td><%=nf.format(dT)%>
            </td>
            <td><%=w.cond.elementAt(i)%>
            </td>
            <td><%=nf.format(dC)%>
            </td>
            <td><%=w.press.elementAt(i)%>
            </td>
            <td><%=nf.format(dP)%>
            </td>
            <td><%=w.TDS.elementAt(i)%>
            </td>
            <td><%=nf.format(dTDS)%>
            </td>
        </tr>
        <%
            }
        %>
    </table>
    <br>
    <%
    } else {
    %>
    No transducer data during this date range.
    <%
                }

                // Close the statements
                p2.close();
                r2.close();

                // If there wasn't only one value, go back to the previous value
                // so that first is set to the correct value next time
                if (!onlyOne) {
                    rs.previous();
                }
            }

            // Close the statements, result set, and connection
            pstmt.close();
            rs.close();
            conn.close();
        }
        catch (Exception e) {
            e.printStackTrace();
            //out.println("<h1> error: "+ e.getMessage()+"</h1>");
        }

    %>
</div>
</body>
</html>

<script>
    function goto(page) {
        window.location = page;
    }
</script>
