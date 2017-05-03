import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/file_upload")
@MultipartConfig
public class UploadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //String description = request.getParameter("description"); // Retrieves <input type="text" name="description">
        Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">
        InputStream fileContentIS = filePart.getInputStream();

        String fileContent;
        try (BufferedReader buffer = new BufferedReader(new InputStreamReader(fileContentIS))) {
             fileContent = buffer.lines().collect(Collectors.joining("\n"));
        }
        String[] parts = fileContent.split("\\,|\\n|\\t");

        Boolean success = true;
        String DB_URL = "jdbc:mysql://mama.c95cjqkvfcem.us-east-1.rds.amazonaws.com:3306";
        String USER = "ritSpaGee";
        String PASS = "geeterman";
        double wellID;
        //Messages to be displayed when upload is completed.
        PrintWriter out = response.getWriter();
        String noEndOnForm = "<script language=\"Javascript\"> window.alert(\"The end column was not set. Please try again\"); \n" +
                "window.location = \"file_upload/file_upload.jsp\"; </script>;";
        String successfulUpload = "<script language=\"Javascript\"> window.alert(\"Data insertion successful!\"); \n" +
                "window.location = \"file_upload/file_upload.jsp\"; </script>;";
        String failedUpload = "<script language=\"Javascript\"> window.alert(\"Data was not uploaded correctly. Check for commas in the upload form.\");\n " +
                "window.location = \"file_upload/file_upload.jsp\"; </script>;";

        Connection conn;
        Statement stmt;
        String temp;

        String fileType = request.getParameter("isFile");
        switch (fileType) {

            case "well":
                String usage;
                String aquafier_code;
                String type_code;
                String comment;
                double bottom_depth;
                double top_depth;
                double depth;
                double land_elevation;
                double water_level_elevation;
                double bottom_elevation;
                double diameter;
                double casingID;
                String pump_description;
                double latitude;
                double longitude;
                String state;
                String county;
                String owner_name;
                String owner_type;

                Map<Integer, String> fieldStringMap = new HashMap<>();
                int end = -1;
                //Mapping the column locations to the relevant variables.
                for (int i = 1; i < 35; i++) {
                    String value;
                    temp = "field" + i;
                    value = request.getParameter(temp);

                    if (!value.isEmpty()) {
                        if (value.equals("wellID")) {
                            fieldStringMap.put(i-1, "wellID");
                        } else if (value.equals("Latitude")) {
                            fieldStringMap.put(i-1, "latitude");
                        } else if (value.equals("Longitude")) {
                            fieldStringMap.put(i-1, "longitude");
                        } else if (value.equals("county")) {
                            fieldStringMap.put(i-1, "county");
                        } else if (value.equals("Aquifercode")) {
                            fieldStringMap.put(i-1, "aquafier_code");
                        } else if (value.equals("state") ) {
                            fieldStringMap.put(i-1, "state");
                        } else if (value.equals("wellTypeCode")) {
                            fieldStringMap.put(i-1, "type_code");
                        } else if (value.equals("wellDepth") ) {
                            fieldStringMap.put(i-1, "depth");
                        } else if (value.equals("casingID") ) {
                            fieldStringMap.put(i-1, "casingID");
                        } else if (value.equals("landSurfaceElevation")) {
                            fieldStringMap.put(i-1, "land_elevation");
                        } else if (value.equals("WaterElevation")) {
                            fieldStringMap.put(i-1, "water_level_elevation");
                        } else if (value.equals("bottomElevation")) {
                            fieldStringMap.put(i-1, "bottom_elevation");
                        } else if (value.equals("WellUse")) {
                            fieldStringMap.put(i-1, "usage");
                        } else if (value.equals("pump")) {
                            fieldStringMap.put(i-1, "pump_description");
                        } else if (value.equals("comments")) {
                            fieldStringMap.put(i-1, "comment");
                        } else if (value.equals("diameter")) {
                            fieldStringMap.put(i-1, "diameter");
                        } else if (value.equals("owner")) {
                            fieldStringMap.put(i-1, "owner_name");
                        } else if (value.equals("ownerType")) {
                            fieldStringMap.put(i - 1, "owner_type");
                        } else if (value.equals("topDepth")) {
                            fieldStringMap.put(i-1, "top_depth");
                        } else if (value.equals("bottomDepth")) {
                            fieldStringMap.put(i-1, "bottom_depth");
                        //End is used to tell us where the end of the columns are located
                        } else if(value.equals("end")) {
                            end = i - 1;
                        }
                    }

                }

                conn = null;
                stmt = null;
                try {
                    //STEP 2: Register JDBC driver
                    Class.forName("com.mysql.jdbc.Driver");

                    //STEP 3: Open a connection
                    System.out.println("Connecting to database...");
                    conn = DriverManager.getConnection(DB_URL, USER, PASS);

                    //STEP 4: Execute a query
                    System.out.println("Creating statement...");
                    stmt = conn.createStatement();

                    //For loop iterates through each row.
                    for(int i = 0; i < (parts.length / (end -1)) && success; i++) {
                        //Setting variables back to default values.
                        usage = "";
                        wellID = 0;
                        aquafier_code = "";
                        type_code = "";
                        comment = "";
                        bottom_depth = -1;
                        top_depth = -1;
                        depth = -1;
                        land_elevation = -1;
                        water_level_elevation = -1;
                        bottom_elevation = -1;
                        diameter = -1;
                        casingID = -1;
                        pump_description = "";
                        latitude = -1;
                        longitude = -1;
                        state = "";
                        county = "";
                        owner_name = "";
                        owner_type = "";
                        //Matching data to well variables from the columns.
                        for (int j = 0; j < end; j++) {
                            if(fieldStringMap.containsKey(j)) {
                                temp = parts[(i* end) + j];
                                temp = temp.replace("\"","");   //Random quotation marks appearing.
                                temp = temp.replace(" ", "");
                                switch (fieldStringMap.get(j)) {
                                    case "wellID":
                                        if(!parts[(i*end) +j].isEmpty()) {
                                            System.out.println(temp);
                                            wellID = Double.parseDouble(temp);
                                        }
                                        break;
                                    case "latitude":
                                        if(!parts[(i*end) +j].isEmpty())
                                            latitude = Double.parseDouble(temp);
                                        break;
                                    case "longitude":
                                        if(!parts[(i*end) +j].isEmpty())
                                            longitude = Double.parseDouble(temp);
                                        break;
                                    case "county":
                                        county = temp;
                                        break;
                                    case "aquafier_code":
                                        aquafier_code = temp;
                                        break;
                                    case "state":
                                        state = temp;
                                        break;
                                    case "type_code":
                                        type_code = temp;
                                        break;
                                    case "depth":
                                        if(!parts[(i*end) +j].isEmpty())
                                            depth = Double.parseDouble(temp);
                                        break;
                                    case "casingID":
                                        if(!parts[(i*end) +j].isEmpty())
                                            casingID = Double.parseDouble(temp);
                                        break;
                                    case "land_elevation":
                                        if(!parts[(i*j) +j].isEmpty())
                                            land_elevation = Double.parseDouble(temp);
                                        break;
                                    case "water_level_elevation":
                                        if(!parts[(i*j) +j].isEmpty())
                                            water_level_elevation = Double.parseDouble(temp);
                                        break;
                                    case "usage":
                                        usage = temp;
                                        break;
                                    case "pump_description":
                                        pump_description = temp;
                                        break;
                                    case "comment":
                                        comment = temp;
                                        break;
                                    case "diameter":
                                        if(!parts[(i*j) +j].isEmpty())
                                            diameter = Double.parseDouble(temp);
                                        break;
                                    case "top_depth":
                                        if(!parts[(i*j) +j].isEmpty())
                                            top_depth = Double.parseDouble(temp);
                                        break;
                                    case "bottom_depth":
                                        if(!parts[(i*j) +j].isEmpty())
                                            bottom_depth = Double.parseDouble(temp);
                                        break;
                                    case "bottom_elevation":
                                        if(!parts[(i*j) +j].isEmpty())
                                            bottom_elevation = Double.parseDouble(temp);
                                        break;
                                    case "owner_name":
                                        owner_name = temp;
                                        break;
                                    case "owner_type":
                                        owner_type = temp;
                                        break;
                                    default:
                                        break;
                                }
                            }
                        }

                        //string modifications to help data be consistent for database queries.
                        usage = usage.toLowerCase();
                        state = state.toLowerCase();
                        county = county.toLowerCase();
                        type_code = type_code.toUpperCase();
                        owner_name = owner_name.toLowerCase();
                        owner_type = owner_type.toLowerCase();
                        //actual sql insertion statement below
                        if (wellID == -1) {
                        } else {
                            String sql = "";
                            //Well input is present
                            if (wellID != -1 && (!state.equals("")) && type_code.length() == 1) {
                                //check for valid data!
                                sql = "INSERT INTO ritSpaGee.Well (wellID, usagee, aquafier_code, comment, type_code, top_depth, " +
                                        "bottom_depth, depth, bottom_elevation, water_level_elevation, land_elevation, diameter, " +
                                        "casingID, pump_description, state, county, latitude, longitude) VALUES (" + wellID + ',' +
                                        "\"" + usage + "\"" + ',' + "\"" + aquafier_code + "\"" + ',' + "\"" + comment + "\"" + ',' + "\"" + type_code.charAt(0) + "\"" +
                                        ',' + top_depth + ',' + bottom_depth + ',' + depth + ',' + bottom_elevation + ',' + water_level_elevation + ',' +
                                        land_elevation + ',' + diameter + ',' + casingID + ',' + "\"" + pump_description + "\"" + ',' + "\"" + state +
                                        "\"" + ',' + "\"" + county + "\"" + ',' + latitude + ',' + longitude + ");";
                                if ((usage.equals("irrigation") || usage.equals("unused") || usage.equals("domestic") || usage.equals("stock")) && ((diameter >= 0) || (diameter == -1))
                                        && (depth != -1) && (!aquafier_code.equals("")) && (land_elevation >= bottom_elevation) && (!state.equals("")) &&
                                        (!county.equals("")) && (!type_code.equals("")) && (90 >= latitude) && (latitude >= -90) && (longitude >= -180)
                                        && (180 >= longitude) && type_code.length() == 1) {

                                    System.out.println(sql);
                                    stmt.addBatch(sql);
                                } else {
                                    System.out.println("Well upload has invalid data. \n" + sql);
                                    success = false;
                                }
                            }
                            //Owner input present
                            if (owner_name != "" && success) {
                                sql = "INSERT INTO ritSpaGee.Owner (wellID, type, name) VALUES (" + wellID + ',' + "\"" + owner_type
                                        + "\"" + ',' + "\"" + owner_name + "\"" + ");";
                                if (owner_type.equals("company") || owner_type.equals("government") || owner_type.equals("person")) {
                                    System.out.println(sql);
                                    stmt.addBatch(sql);
                                } else {
                                    System.out.println("Owner upload has invalid data. \n" + sql);
                                    success = false;
                                }
                            }
                        }
                    }
                    stmt.executeBatch();
                } catch (SQLException se) {
                    //Handle errors for JDBC
                    se.printStackTrace();
                    success = false;
                } catch (Exception e) {
                    //Handle errors for Class.forName
                    e.printStackTrace();
                    success = false;
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
                        success = false;
                        se.printStackTrace();
                    }//end finally try
                }//end try

                if (success && end != -1) {
                    out.println(successfulUpload);
                } else if (end == -1) {
                    out.println(noEndOnForm);
                } else {
                    out.println(failedUpload);
                }
                break;


            case "sensor":
                String hourTime;
                String transID = request.getParameter("sensor");
                String date = "11/12/94 13:41:12";
                Calendar calendar = Calendar.getInstance();
                double temperature;
                double conductivity;
                double pressure;
                double salinity;
                double TDS;

                conn = null;
                stmt = null;
                try {
                    SimpleDateFormat userFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm:ss");
                    SimpleDateFormat sqlFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
                    java.util.Date dateTime = userFormat.parse(date);
                    //STEP 2: Register JDBC driver
                    Class.forName("com.mysql.jdbc.Driver");

                    //STEP 3: Open a connection
                    System.out.println("Connecting to database...");
                    conn = DriverManager.getConnection(DB_URL, USER, PASS);

                    //STEP 4: Execute a query
                    System.out.println("Creating statement...");
                    stmt = conn.createStatement();
                    //Assuming that all sensor reading files have eight columns.
                    //This for loop will iterate through each row
                    for(int i = 0; i < (parts.length / 8) && success; i++) {
                        date = "";
                        hourTime = "";
                        temperature = 99999;
                        conductivity = 99999;
                        pressure = 99999;
                        salinity = 99999;
                        TDS = 99999;
                        for(int j = 1; j < 8; j++) {
                            switch (j) {
                                case 1:
                                    date = parts[(i * 8) + j];
                                    break;
                                case 2:
                                    hourTime = parts[(i * 8) + j];
                                    date = date + " " + hourTime;
                                    dateTime = userFormat.parse(date);
                                    System.out.println(dateTime);
                                    break;
                                case 3:
                                    if(!parts[(i*8) + j].isEmpty())
                                        temperature = Double.parseDouble(parts[(i*8) + j]);
                                    break;
                                case 4:
                                    if(!parts[(i*8) + j].isEmpty())
                                        conductivity = Double.parseDouble(parts[(i*8) + j]);
                                    break;
                                case 5:
                                    if(!parts[(i*8) + j].isEmpty())
                                        pressure = Double.parseDouble(parts[(i*8) + j]);
                                    break;
                                case 6:
                                    if(!parts[(i*8) + j].isEmpty())
                                        salinity = Double.parseDouble(parts[(i*8) + j]);
                                    break;
                                case 7:
                                    if(!parts[(i*8) + j].isEmpty())
                                        TDS = Double.parseDouble(parts[(i*8) + j]);
                                    break;
                                default:
                                    //Wrong format?
                                    break;
                            }
                        }
                        calendar.setTime(dateTime);
                        System.out.println(calendar);
                        date = sqlFormat.format(calendar.getTime());
                        System.out.println(date);

                        String sql = "";
                        if (!transID.equals("")) {
                            //check for valid data!
                            sql = "INSERT INTO ritSpaGee.Water (transID, timedate, salinity, temperature, conductivity," +
                                    "pressure, TDS) VALUES (" + "\"" + transID + "\"" + ',' + "\"" + date + "\"" +
                                    ',' + salinity + ',' + temperature + ',' + conductivity + ',' + pressure + ',' +
                                    TDS + ");";
                            if ((!date.equals("")) && (!hourTime.equals("")) && temperature != 99999 && conductivity != 99999 && pressure != 99999
                                    && salinity != 99999 && TDS != 99999) {

                                System.out.println(sql);
                                stmt.addBatch(sql);
                            } else {
                                System.out.println("Sensor data has invalid data. \n" + sql);
                                success = false;
                            }
                        }
                    }
                    stmt.executeBatch();
                } catch (SQLException se) {
                    //Handle errors for JDBC
                    se.printStackTrace();
                    success = false;
                } catch (Exception e) {
                    //Handle errors for Class.forName
                    e.printStackTrace();
                    success = false;
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
                        success = false;
                        se.printStackTrace();
                    }//end finally try
                }//end try

                if (success) {
                    out.println(successfulUpload);
                } else {
                    out.println(failedUpload);
                }
                break;

            default:
                break;
        }
    }
}