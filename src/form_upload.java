import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet("/form_upload")
@MultipartConfig
public class form_upload extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Boolean failed = false, success = false;
        String DB_URL = "jdbc:mysql://mama.c95cjqkvfcem.us-east-1.rds.amazonaws.com:3306";
        String USER = "ritSpaGee";
        String PASS = "geeterman";
        String message = "", failureMessage = "";
        PrintWriter out = response.getWriter();

        double wellID = -1;
        if(!request.getParameter("wellID").equals(""))
            wellID = Double.parseDouble(request.getParameter("wellID"));

        if (wellID == -1) {
            success = false;
            failureMessage += "\\nMust enter a WellID for well, owner, AND transducer insertions.";
            message = "<script language=\"Javascript\"> " +
                    "window.alert(\"Data not uploaded. Invalid for the following reason " + failureMessage + " \"); " +
                    "window.location = \"upload/form_upload/form_upload.jsp\"; </script>";
            out.println(message);
        }
        else {
            Connection conn = null;
            Statement stmt = null;
            try {

                String usage = request.getParameter("usage");
                usage = usage.toLowerCase();
                String aquafier_code = request.getParameter("aquafier_code");
                String type_code = request.getParameter("type_code");
                if(!type_code.equals(""))
                    type_code = type_code.toUpperCase();
                String comment = request.getParameter("comment");
                double bottom_depth = -1;
                if(!request.getParameter("bottom_depth").equals(""))
                    bottom_depth = Double.parseDouble(request.getParameter("bottom_depth"));
                double top_depth = -1;
                if(!request.getParameter("top_depth").equals(""))
                    top_depth = Double.parseDouble(request.getParameter("top_depth"));
                double depth = -1;
                if(!request.getParameter("depth").equals(""))
                    depth = Double.parseDouble(request.getParameter("depth"));
                double land_elevation = -1;
                if (!request.getParameter("land_elevation").equals(""))
                    land_elevation = Double.parseDouble(request.getParameter("land_elevation"));
                double water_level_elevation = -1;
                if(!request.getParameter("water_level_elevation").equals(""))
                    water_level_elevation = Double.parseDouble(request.getParameter("water_level_elevation"));
                double bottom_elevation = -1;
                if(!request.getParameter("bottom_elevation").equals(""))
                    bottom_elevation = Double.parseDouble(request.getParameter("bottom_elevation"));
                double diameter = -1;
                if(!request.getParameter("diameter").equals(""))
                    diameter = Double.parseDouble(request.getParameter("diameter"));
                double casingID = -1;
                if(!request.getParameter("casingID").equals(""))
                    casingID = Double.parseDouble(request.getParameter("casingID"));
                String pump_description = request.getParameter("pump_description");
                double latitude = -1;
                if (!request.getParameter("latitude").equals(""))
                    latitude = Double.parseDouble(request.getParameter("latitude"));
                double longitude = -1;
                if (!request.getParameter("longitude").equals(""))
                    longitude = Double.parseDouble(request.getParameter("longitude"));
                String state = request.getParameter("state");
                state = state.toLowerCase();
                String county = request.getParameter("county");
                county = county.toLowerCase();
                String owner_name = request.getParameter("owner_name");
                owner_name = owner_name.toLowerCase();
                String owner_type = request.getParameter("owner_type");
                owner_type = owner_type.toLowerCase();
                String transID = request.getParameter("transID");
                String trans_name = request.getParameter("trans_name");
                String trans_type = request.getParameter("trans_type");

                //STEP 2: Register JDBC driver
                Class.forName("com.mysql.jdbc.Driver");

                //STEP 3: Open a connection
                System.out.println("Connecting to database... ");
                conn = DriverManager.getConnection(DB_URL, USER, PASS);

                //STEP 4: Execute a query
                System.out.println("Creating statement... ");
                stmt = conn.createStatement();

                String sql = "";
                //Well input is present
                if (wellID != -1 && !state.equals("")) {
                    //check for valid data!
                    if( ((usage.equals("irrigation") || usage.equals("unused") || usage.equals("domestic") || usage.equals("stock")) && ((diameter >= 0) || (diameter == -1))
                            && (depth != -1) && (!aquafier_code.equals("")) && (land_elevation >= bottom_elevation) && (!state.equals("")) &&
                            (!county.equals("")) && (!type_code.equals("")) && (90 >= latitude) && (latitude >= -90) && (longitude >= -180)
                            && (180 >= longitude) && type_code.length() == 1) ){
                        sql = "INSERT INTO ritSpaGee.Well (wellID, usagee, aquafier_code, comment, type_code, top_depth, " +
                                "bottom_depth, depth, bottom_elevation, water_level_elevation, land_elevation, diameter, " +
                                "casingID, pump_description, state, county, latitude, longitude) VALUES (" + wellID + ',' +
                                "\"" + usage + "\"" + ',' + "\"" + aquafier_code + "\"" + ',' + "\"" + comment + "\"" + ',' + "\"" + type_code.charAt(0) + "\"" +
                                ',' + top_depth + ',' + bottom_depth + ',' + depth + ',' + bottom_elevation + ',' + water_level_elevation + ',' +
                                land_elevation + ',' + diameter + ',' + casingID + ',' + "\"" + pump_description + "\"" + ',' + "\"" + state +
                                "\"" + ',' + "\"" + county + "\"" + ',' + latitude + ',' + longitude + ");";

                        System.out.println(sql);
                        success = true;
                        stmt.addBatch(sql);
                    }
                    else {
                        //Series of error potentials.
                        if( !(usage.equals("irrigation") || usage.equals("unused") || usage.equals("domestic") || usage.equals("stock")) ) {
                            failureMessage += "\\nincorrect usage value: usage must be unused, domestic, irrigation, or stock. ";
                        }
                        if( !(diameter >= 0) || !(diameter == -1) ) {
                            failureMessage += "\\nincoherent diameter value -- must be greater than 0. ";
                        }
                        if( (depth != -1) ) {
                            failureMessage += "\\nDepth cannot be empty. ";
                        }
                        if( aquafier_code.equals("")) {
                            failureMessage += "\\naquifier code cannot be empty. ";
                        }
                        if( (land_elevation >= bottom_elevation) ) {
                            failureMessage += "\\nland elevation must have a larger value than bottom value. ";
                        }
                        if(state.equals("")) {
                            failureMessage += "\\nState cannot be empty. ";
                        }
                        if(county.equals("")) {
                            failureMessage += "\\nCountry cannot be empty. ";
                        }
                        if(latitude > 90 || latitude < -90) {
                            failureMessage += "\\nLatitude must be between -90 and 90. ";
                        }
                        if(longitude > 90 || longitude < -90) {
                            failureMessage += "\\nLongitude must be between -180 and 180. ";
                        }
                        if(type_code.equals("")) {
                            failureMessage += "\\ntype code cannot be empty. ";
                        } else if(type_code.length() != 1) {
                            failureMessage += "\\nType code must have a one character value";
                        }
                        failed = true;

                        System.out.println("Well upload has invalid data:" + failureMessage);
                        message = "<script language=\"Javascript\"> " +
                                "window.alert(\"Well data not uploaded. Invalid data as follows: " + failureMessage + " \"); \n" +
                                "window.location = \"upload/form_upload/form_upload.jsp\"; </script>";
                        out.println(message);
                    }
                }

                //Owner input present
                if (!owner_name.equals("") && !failed) {
                    sql = "INSERT INTO ritSpaGee.Owner (wellID, type, name) VALUES (" + wellID + ',' + "\"" + owner_type
                            + "\"" + ',' + "\"" + owner_name + "\"" + ");";
                    if (owner_type.equals("company") || owner_type.equals("government") || owner_type.equals("person") && wellID!= -1) {
                        System.out.println(sql);
                        success = true;
                        stmt.addBatch(sql);
                    }
                    else {
                        //error potentials
                        if(!(owner_type.equals("company") || owner_type.equals("government") || owner_type.equals("person")) ) {
                            failureMessage += "\\nowner type must be company, government, or person. ";
                        }
                        if(wellID == -1) {
                            failureMessage += "\\nwellID cannot be blank. ";
                        }

                        failed = true;
                        System.out.println("Owner upload has invalid data. " + failureMessage);
                        message = "<script language=\"Javascript\"> " +
                                "window.alert(\"Owner data not uploaded. Invalid data as follows:" + failureMessage + " \"); " +
                                "window.location = \"upload/form_upload/form_upload.jsp\"; </script>";
                        out.println(message);
                    }
                }

                //trans input present.
                if (!transID.equals("") && !failed) {
                    sql = "INSERT INTO ritSpaGee.Transducer (transID, wellID, type, name) VALUES (" + "\"" + transID
                            + "\"" + ',' + wellID + ',' + "\"" + trans_type + "\"" + ',' + "\"" + trans_name + "\"" + ");";
                    if(!trans_name.equals("") && !trans_type.equals("") && wellID != -1) {
                        System.out.println(sql);
                        success = true;
                        stmt.addBatch(sql);
                    }
                    else {
                        if(trans_name.equals("")) {
                            failureMessage += "\\nThe sensor or transducer name cannot be empty. ";
                        }
                        if(trans_type.equals("")) {
                            failureMessage += "\\nThe sensor or transducer type cannot be empty. ";
                        }
                        if(wellID == -1) {
                            failureMessage += "\\nThe wellID cannot be blank. ";
                        }

                        System.out.println("Transducer data not uploaded. Invalid data. " + failureMessage);
                        message = "<script language=\"Javascript\"> " +
                                "window.alert(\"Transducer or sensor data not uploaded. Invalid data as follows:" + failureMessage + " \"); " +
                                "window.location = \"upload/form_upload/form_upload.jsp\"; </script>";
                        out.println(message);
                    }

                }
                if(success && !failed) {
                    stmt.executeBatch();
                    message = "<script language=\"Javascript\"> " +
                            "window.alert(\"Data insertion successful! \"); \n" +
                            "window.location = \"upload/form_upload/form_upload.jsp\"; </script>";
                    out.println(message);
                }
            } catch (SQLException se) {
                //Handle errors for JDBC
                se.printStackTrace();
                message = "<script language=\"Javascript\"> " +
                        "window.alert(\"Data not uploaded. Invalid for the following reason  " + se + "); \n" +
                        "window.location = \"upload/form_upload/form_upload.jsp\"; </script>";
                out.println(message);
            } catch (Exception e) {
                //Handle errors for Class.forName
                e.printStackTrace();
                message = "<script language=\"Javascript\"> " +
                        "window.alert(\"Data not uploaded. Invalid for the following reason " + e + " \"); " +
                        "window.location = \"upload/form_upload/form_upload.jsp\"; </script>";
                out.println(message);
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
    }
}