package com.relaxit.domain.utils;
import java.sql.Connection;
import java.sql.DriverManager;

public class Connectivity {
    public static Connection connection;

    public static  Connection getConnection() {
        String dbName = "iti";
        String username = "root";
        String password = "root";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/" + dbName, username, password);
            System.out.println(" Database connected successfully!");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return connection;
    }
}
