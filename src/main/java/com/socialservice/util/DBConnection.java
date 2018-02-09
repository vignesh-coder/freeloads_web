package com.socialservice.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static Connection con = null;
    private static final String URL = "jdbc:mysql://localhost:3306/";
    private static final String DATABASE_NAME = "social_service";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";

    public static Connection getConnection() throws ClassNotFoundException, SQLException {

        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(URL + DATABASE_NAME, USERNAME, PASSWORD);
        return con;

    }
}
