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
    Boolean success = true;
    String DB_URL = "jdbc:mysql://mama.c95cjqkvfcem.us-east-1.rds.amazonaws.com:3306";
    String USER = "ritSpaGee";
    String PASS = "geeterman";

    String date = "";
    double latitude = 190;
    double longitude = 190;
    double actual_amount = -4;
    double normal_amount = -4;

    date = request.getParameter("date");
    if(request.getParameter("latitude") != "")
        latitude = Double.parseDouble(request.getParameter("latitude"));
    if(request.getParameter("longitude") != "")
        longitude = Double.parseDouble(request.getParameter("longitude"));
    if(request.getParameter("actual_amount") != "")
        actual_amount = Double.parseDouble(request.getParameter("actual_amount"));
    if(request.getParameter("normal_amount") != "")
        normal_amount = Double.parseDouble(request.getParameter("normal_amount"));


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

        Integer testYear = Integer.parseInt(date.substring(0,4));

        String sql = "";
        if (!date.equals("") && (90 >= latitude) && (latitude >= -90) && (longitude >= -180) && (180 >= longitude)
                && (actual_amount != -4) && (normal_amount != -4) && (testYear >= 1900) && (testYear <= 2020) ) {
            sql = "INSERT INTO ritSpaGee.Rainfall (date, latitude, longitude, actual_amount, normal_amount) VALUES (" +
                    "\"" + date + "\"" + ',' + latitude + ',' + longitude + ',' + actual_amount + ',' + normal_amount + ");";

            System.out.println(sql);
            stmt.executeUpdate(sql);
        }
        else
            success = false;
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


    if(success) {
    %>
    <script language="Javascript">
        window.alert("Data insertion successful!");
        window.location = "rainfall_upload.jsp";
    </script>
    <%
    } else {
    %>
    <script language="JavaScript">
        window.alert("Data was not uploaded successfully. \nView log to see error statement from DB.")
        window.location="rainfall_upload.jsp";
    </script>
    <%
}
%>