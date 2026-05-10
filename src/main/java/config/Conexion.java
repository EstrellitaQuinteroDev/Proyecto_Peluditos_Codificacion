package config;

import java.sql.Connection;
import java.sql.DriverManager;

public class Conexion {
    private Connection con;
    private final String url = "jdbc:mysql://localhost:3306/peluditosweb_db";
    private final String user = "root";
    private final String pass = "admin123"; 

    public Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, user, pass);
            System.out.println("Conexión exitosa a la base de datos");
        } catch (Exception e) {
            System.err.println("Error de conexión: " + e);
        }
        return con;
    }
}