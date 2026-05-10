package dao;

import config.Conexion;
import java.sql.*;
import java.util.ArrayList; // Necesario para la lista
import java.util.List;      // Necesario para la lista
import modelo.Bandana;

public class BandanaDAO {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs; // Esta "herramienta" sirve para leer los resultados de la base de datos

    // Tu método de agregar que ya funciona
    public int agregar(Bandana b) {
        String sql = "INSERT INTO bandanas (nombre, id_estilo, id_material, precio, descripcion) VALUES (?,?,?,?,?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, b.getNombre());
            ps.setInt(2, b.getIdEstilo());
            ps.setInt(3, b.getIdMaterial());
            ps.setDouble(4, b.getPrecio());
            ps.setString(5, b.getDescripcion());
            return ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error en DAO al agregar: " + e);
            return 0;
        }
    }

    // NUEVO MÉTODO: Para llenar tu tabla de administrador
    public List<Bandana> listar() {
    String sql = "SELECT * FROM bandanas";
    List<Bandana> lista = new ArrayList<>();
    try {
        con = cn.getConnection();
        
        // AGREGAR ESTA VALIDACIÓN:
        
        if (con != null) { 
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Bandana b = new Bandana();
                b.setId(rs.getInt("id_bandana")); 
                b.setNombre(rs.getString("nombre"));
                b.setIdEstilo(rs.getInt("id_estilo"));
                b.setIdMaterial(rs.getInt("id_material"));
                b.setPrecio(rs.getDouble("precio"));
                b.setDescripcion(rs.getString("descripcion"));
                lista.add(b);
            }
        } else {
            System.err.println("Error: La conexión es nula. Revisa tu clase Conexion.java");
        }
    } catch (SQLException e) {
        System.err.println("Error en DAO al listar: " + e);
    } finally {
        // OPCIONAL: Es buena práctica cerrar recursos para no saturar MySQL
        try { if (rs != null) rs.close(); if (ps != null) ps.close(); } catch (SQLException e) {}
    }
    return lista;
    }
}
