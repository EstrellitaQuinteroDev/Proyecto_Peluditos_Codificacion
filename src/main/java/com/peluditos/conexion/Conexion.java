package com.peluditos.conexion;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Clase encargada de gestionar la conexión técnica con el motor de base de datos MySQL.
 * Implementa el driver JDBC para establecer el puente de comunicación.
 */
public class Conexion {
    
    // Parámetros de configuración de la base de datos
    private final String bd = "peluditos_db";
    private final String url = "jdbc:mysql://localhost:3306/" + bd;
    private final String user = "root"; 
    private final String password = "Quintero19023*"; 

    /**
     * Establece y retorna el objeto de conexión a la base de datos.
     * @return Connection objeto de conexión activa o null en caso de error.
     */
    public Connection getConnection() {
        Connection con = null;
        try {
            // Carga dinámica del controlador JDBC de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Intento de establecimiento de conexión mediante DriverManager
            con = DriverManager.getConnection(url, user, password);
            
            System.out.println("✅ Conexión establecida exitosamente con el servidor.");
        } catch (ClassNotFoundException | SQLException e) {
            // Captura de excepciones relacionadas con el driver o parámetros de red
            System.err.println("❌ Error crítico en la capa de persistencia: " + e.getMessage());
        }
        return con;
    }
}
