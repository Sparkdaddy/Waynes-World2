<%--
  Created by IntelliJ IDEA.
  User: Sparky
  Date: 4/28/17
  Time: 2:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    Boolean success = false;
    String DB_URL = "jdbc:mysql://mama.c95cjqkvfcem.us-east-1.rds.amazonaws.com:3306";
    String USER = "ritSpaGee";
    String PASS = "geeterman";

    String usage = request.getParameter("usage");
    usage = usage.toLowerCase();
    double wellID = 0;
    if(request.getParameter("wellID") != "")
        wellID = Double.parseDouble(request.getParameter("wellID"));
    String aquafier_code = request.getParameter("aquafier_code");
    String type_code = request.getParameter("type_code");
    if(type_code != "")
        type_code = type_code.toUpperCase();
    String comment = request.getParameter("comment");
    double bottom_depth = 0;
    if(request.getParameter("bottom_depth") != "")
        bottom_depth = Double.parseDouble(request.getParameter("bottom_depth"));
    double top_depth = 0;
    if(request.getParameter("top_depth") != "")
        top_depth = Double.parseDouble(request.getParameter("top_depth"));
    double depth = 0;
    if(request.getParameter("depth") != "")
        depth = Double.parseDouble(request.getParameter("depth"));
    double land_elevation = 0;
    if (request.getParameter("land_elevation") != "")
        land_elevation = Double.parseDouble(request.getParameter("land_elevation"));
    double water_level_elevation = 0;
    if(request.getParameter("water_level_elevation") != "")
        water_level_elevation = Double.parseDouble(request.getParameter("water_level_elevation"));
    double bottom_elevation = 0;
    if(request.getParameter("bottom_elevation") != "")
        bottom_elevation = Double.parseDouble(request.getParameter("bottom_elevation"));
    double diameter = 0;
    if(request.getParameter("diameter") != "")
        diameter = Double.parseDouble(request.getParameter("diameter"));
    double casingID = 0;
    if(request.getParameter("casingID") != "")
        casingID = Double.parseDouble(request.getParameter("casingID"));
    String pump_description = request.getParameter("pump_description");
    double latitude = 0;
    if (request.getParameter("latitude") != "")
        latitude = Double.parseDouble(request.getParameter("latitude"));
    double longitude = 0;
    if(request.getParameter("longitude") != "")
        longitude = Double.parseDouble(request.getParameter("longitude"));
    String state = request.getParameter("state");
    state = state.toLowerCase();
    String county = request.getParameter("county");
    county = county.toLowerCase();
    String owner_name = request.getParameter("owner_name");
    owner_name = owner_name.toLowerCase();
    String owner_type = request.getParameter("owner_type");
    owner_type = owner_type.toLowerCase();
    //Is transID a string??
    String transID = request.getParameter("transID");
    String trans_name = request.getParameter("trans_name");
    String trans_type = request.getParameter("trans_type");


    //double (and other primitive types) evaluate to zero if null.
    if (wellID == 0 && owner_name == "" && transID == "") { }
    else {
        Connection conn = null;
        Statement stmt = null;
        try {
            //STEP 2: Register JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            //STEP 3: Open a connection
            System.out.println("Connecting to database...");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);

            //STEP 4: Execute a query
            System.out.println("Creating statement...");
            stmt = conn.createStatement();

            String sql = "";
            //Well input is present
            if (wellID != 0 && state != "") {
                //check for valid data!
                sql = "INSERT INTO ritSpaGee.Well (wellID, usagee, aquafier_code, comment, type_code, top_depth, " +
                        "bottom_depth, depth, bottom_elevation, water_level_elevation, land_elevation, diameter, " +
                        "casingID, pump_description, state, county, latitude, longitude) VALUES (" + wellID + ',' +
                        "\"" + usage + "\"" + ',' + "\"" + aquafier_code + "\"" + ',' + "\"" + comment + "\"" + ',' + "\"" + type_code.charAt(0) + "\"" +
                        ',' + top_depth + ',' + bottom_depth + ',' + depth + ',' + bottom_elevation + ',' + water_level_elevation + ',' +
                        land_elevation + ',' + diameter + ',' + casingID + ',' + "\"" + pump_description + "\"" + ',' + "\"" + state +
                        "\"" + ',' + "\"" + county + "\"" + ',' + latitude + ',' + longitude + ");";
                if( ((usage.equals("irrigation") || usage.equals("unused") || usage.equals("domestic") || usage.equals("stock")) && ((diameter >= 0) || (diameter == -1))
                        && (depth != -1) && (!aquafier_code.equals("")) && (land_elevation >= bottom_elevation) && (!state.equals("")) &&
                        (!county.equals("")) && (!type_code.equals("")) && (90 >= latitude) && (latitude >= -90) && (longitude >= -180)
                        && (180 >= longitude) && type_code.length() == 1) ){

                    System.out.println(sql);
                    stmt.executeUpdate(sql);
                    success = true;
                }
                else {
                    System.out.println("Well upload has invalid data. \n" + sql);
                    %>
                    <script language="Javascript">
                        window.alert("Well data not uploaded. Invalid data.");
                    </script>
                    <%
                }
            }

            //Owner input present
            if (owner_name != "") {
                sql = "INSERT INTO ritSpaGee.Owner (wellID, type, name) VALUES (" + wellID + ',' + "\"" + owner_type
                        + "\"" + ',' + "\"" + owner_name + "\"" + ");";
                if (owner_type.equals("company") || owner_type.equals("government") || owner_type.equals("person") ) {
                    System.out.println(sql);
                    stmt.executeUpdate(sql);
                    success = true;
                }
                else {
                    System.out.println("Owner upload has invalid data. \n" + sql);
                    %>
                    <script language="Javascript">
                        window.alert("Owner data not uploaded. Invalid data.");
                    </script>
                    <%
                }
            }

            //trans input present.
            if (transID != "") {
                sql = "INSERT INTO ritSpaGee.Transducer (transID, wellID, type, name) VALUES (" + "\"" + transID
                        + "\"" + ',' + wellID + ',' + "\"" + trans_type + "\"" + ',' + "\"" + trans_name + "\"" + ");";
                if(trans_name != "" && trans_type != "") {
                    System.out.println(sql);
                    stmt.executeUpdate(sql);
                    success = true;
                }
                else {
                    System.out.println("Transducer data not uploaded. Invalid data. \n" + sql);
                    %>
                    <script language="Javascript">
                        window.alert("Transducer data not uploaded. Invalid data.");
                    </script>
                    <%
                }

            }
        } catch (SQLException se) {
            //Handle errors for JDBC
            success = false;
            se.printStackTrace();
        } catch (Exception e) {
            //Handle errors for Class.forName
            success = false;
            e.printStackTrace();
        } finally {
            //finally block used to close resources
            try {
                if (stmt != null)
                    stmt.close();
            } catch (SQLException se2) {
            }// nothing we can do
            try {
                if (conn != null)
                    conn.close();
            } catch (SQLException se) {
                se.printStackTrace();
            }//end finally try
        }//end try
    }

        if(success) {
        %>
        <script language="Javascript">
            window.alert("Data insertion successful!");
            window.location = "form_upload.jsp";
        </script>
        <%
        }
        else {
        %>
            <script language="JavaScript">
            window.alert("Data was not uploaded successfully. \nView log to see error statement from DB.")
            window.location="form_upload.jsp";
            </script>
        <%
        }
        %>