import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.*;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;

@WebServlet("/file_upload")
@MultipartConfig
public class UploadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //String description = request.getParameter("description"); // Retrieves <input type="text" name="description">
        Part filePart = request.getPart("file"); // Retrieves <input type="file" name="file">
        //String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
        InputStream fileContentIS = filePart.getInputStream();

        String fileContent;
        try (BufferedReader buffer = new BufferedReader(new InputStreamReader(fileContentIS))) {
             fileContent = buffer.lines().collect(Collectors.joining("\n"));
        }

        Boolean success = true;
        String DB_URL = "jdbc:mysql://mama.c95cjqkvfcem.us-east-1.rds.amazonaws.com:3306";
        String USER = "ritSpaGee";
        String PASS = "geeterman";

        String fileType = request.getParameter("isFile");
        switch (fileType) {

            case "well":
                String usage = "";
                double wellID = 0;
                String aquafier_code = "";
                String type_code = "";
                String comment = "";
                double bottom_depth = 0;
                double top_depth = 0;
                double depth = 0;
                double land_elevation = 0;
                double water_level_elevation = 0;
                double bottom_elevation = 0;
                double diameter = 0;
                double casingID = 0;
                String pump_description = "";
                double latitude = 0;
                double longitude = 0;
                String state = "";
                String county = "";

                Map<Integer, String> fieldStringMap = new HashMap<>();
                int end = -1;
                for (int i = 1; i < 26; i++) {
                    String value, temp = "field" + i;
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
                        } else if (value.equals("topDepth")) {
                            fieldStringMap.put(i-1, "top_depth");
                        } else if (value.equals("bottomDepth")) {
                            fieldStringMap.put(i-1, "bottom_depth");
                        }

                    } else if(end == -1) {
                        end = i-1;
                    }

                }

                String[] parts = fileContent.split("\\,|\\n");
//                for(int i = 0; i < 30; i++) {
//                    System.out.print(parts[i]);
//                    System.out.print(" ");
//                }
                System.out.println("Number of rows is " + (parts.length / (end -1) ));
                for(int i = 0; i < (parts.length / (end -1)) && success; i++) {
                    //Setting variables back to default values.
                    usage = "";
                    wellID = 0;
                    aquafier_code = "";
                    type_code = "";
                    comment = "";
                    bottom_depth = 0;
                    top_depth = 0;
                    depth = 0;
                    land_elevation = 0;
                    water_level_elevation = 0;
                    bottom_elevation = 0;
                    diameter = 0;
                    casingID = 0;
                    pump_description = "";
                    latitude = 0;
                    longitude = 0;
                    state = "";
                    county = "";
                    //Matching data to well variables and then using insertion statement to put it in the db.
                    for (int j = 0; j < end; j++) {
                        if(fieldStringMap.containsKey(j)) {
                            switch (fieldStringMap.get(j)) {
                                case "wellID":
                                    if(!parts[(i*end) +j].isEmpty())
                                        wellID = Double.parseDouble(parts[(i * end) + j]);
                                    break;
                                case "latitude":
                                    if(!parts[(i*end) +j].isEmpty())
                                        latitude = Double.parseDouble(parts[(i * end) + j]);
                                    break;
                                case "longitude":
                                    if(!parts[(i*end) +j].isEmpty())
                                        longitude = Double.parseDouble(parts[(i * end) + j]);
                                    break;
                                case "county":
                                    county = parts[(i * end) + j];
                                    county = county.replace("\"", "");
                                    break;
                                case "aquafier_code":
                                    aquafier_code = parts[(i * end) + j];
                                    aquafier_code = aquafier_code.replace("\"", "");
                                    break;
                                case "state":
                                    state = parts[(i * end) + j];
                                    state = state.replace("\"", "");
                                    break;
                                case "type_code":
                                    type_code = parts[(i * end) + j];
                                    type_code = type_code.replace("\"","");
                                    break;
                                case "depth":
                                    if(!parts[(i*end) +j].isEmpty())
                                        depth = Double.parseDouble(parts[(i * end) + j]);
                                    break;
                                case "casingID":
                                    if(!parts[(i*end) +j].isEmpty())
                                        casingID = Double.parseDouble(parts[(i * end) + j]);
                                    break;
                                case "land_elevation":
                                    if(!parts[(i*j) +j].isEmpty())
                                        land_elevation = Double.parseDouble(parts[(i * end) + j]);
                                    break;
                                case "water_level_elevation":
                                    if(!parts[(i*j) +j].isEmpty())
                                        water_level_elevation = Double.parseDouble(parts[(i * end) + j]);
                                    break;
                                case "usage":
                                    usage = parts[(i * end) + j];
                                    usage = usage.replace("\"","");
                                    break;
                                case "pump_description":
                                    pump_description = parts[(i * end) + j];
                                    pump_description = pump_description.replace("\"", "");
                                    break;
                                case "comment":
                                    comment = parts[(i * end) + j];
                                    comment = comment.replace("\"","");
                                    break;
                                case "diameter":
                                    if(!parts[(i * end) + j].isEmpty())
                                        diameter = Double.parseDouble(parts[(i * end) + j]);
                                case "top_depth":
                                    if(!parts[(i * end) + j].isEmpty())
                                        top_depth = Double.parseDouble(parts[(i * end) + j]);
                                case "bottom_depth":
                                    if(!parts[(i * end) + j].isEmpty())
                                        bottom_depth = Double.parseDouble(parts[(i * end) + j]);
                                case "bottom_elevation":
                                    if(!parts[(i * end) + j].isEmpty())
                                        bottom_elevation = Double.parseDouble(parts[(i * end) + j]);
                                default:
                                    break;
                            }
                        }
                    }

                    //string modifications to help them be used for database queries.
                    usage = usage.toLowerCase();
                    state = state.toLowerCase();
                    county = county.toLowerCase();
                    type_code = type_code.toUpperCase();
                    //double (and other primitive types) evaluate to zero if null.
                    if (wellID == 0) {
                    } else {
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
                            if (wellID != 0 && state != "" && type_code.length() == 1) {
                                //check for valid data!
                                sql = "INSERT INTO ritSpaGee.Well (wellID, usagee, aquafier_code, comment, type_code, top_depth, " +
                                        "bottom_depth, depth, bottom_elevation, water_level_elevation, land_elevation, diameter, " +
                                        "casingID, pump_description, state, county, latitude, longitude) VALUES (" + wellID + ',' +
                                        "\"" + usage + "\"" + ',' + "\"" + aquafier_code + "\"" + ',' + "\"" + comment + "\"" + ',' + "\"" + type_code.charAt(0) + "\"" +
                                        ',' + top_depth + ',' + bottom_depth + ',' + depth + ',' + bottom_elevation + ',' + water_level_elevation + ',' +
                                        land_elevation + ',' + diameter + ',' + casingID + ',' + "\"" + pump_description + "\"" + ',' + "\"" + state +
                                        "\"" + ',' + "\"" + county + "\"" + ',' + latitude + ',' + longitude + ");";
                                if ((usage.equals("irrigation") || usage.equals("unused") || usage.equals("domestic") || usage.equals("stock")) && (diameter >= 0)
                                        && (depth != 0) && (aquafier_code != "") && (land_elevation >= bottom_elevation) && (state != "") &&
                                        (county != "") && (type_code != "") && (90 >= latitude) && (latitude >= -90) && (longitude >= -180)
                                        && (180 >= longitude)) {

                                    System.out.println(sql);
                                    stmt.executeUpdate(sql);
                                    success = true;
                                } else {
                                    System.out.println("Well upload has invalid data. \n" + sql);
                                }
                            }

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
                    }
                }

                if (success) {

                } else {

                }
                break;


            case "sensor":


                break;

            default:
                break;
        }
    }
}