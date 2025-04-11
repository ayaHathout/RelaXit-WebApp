package com.relaxit.domain.utils;
import java.sql.Connection;
import java.sql.DriverManager;

public class Connectivity {
    public static Connection connection;

    public static  Connection getConnection() {
        String dbName = "relaxit";
        String username = "root";
        String password = "M@12345678";
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
