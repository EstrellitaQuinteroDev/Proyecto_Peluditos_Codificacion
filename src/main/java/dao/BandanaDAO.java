package dao;

import config.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import modelo.Bandana;

public class BandanaDAO {
    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    // Método AGREGAR actualizado con stock e imagen
    public int agregar(Bandana b) {
        // Añadimos 'stock' e 'imagen' a la consulta SQL
        String sql = "INSERT INTO bandanas (nombre, id_estilo, id_material, precio, descripcion, stock, imagen) VALUES (?,?,?,?,?,?,?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, b.getNombre());
            ps.setInt(2, b.getIdEstilo());
            ps.setInt(3, b.getIdMaterial());
            ps.setDouble(4, b.getPrecio());
            ps.setString(5, b.getDescripcion());
            // NUEVOS CAMPOS:
            ps.setInt(6, b.getStock());
            ps.setString(7, b.getImagen()); 
            
            return ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error en DAO al agregar: " + e);
            return 0;
        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException e) {}
        }
    }

    // Método LISTAR actualizado para traer stock e imagen a la tabla
    public List<Bandana> listar() {
        String sql = "SELECT * FROM bandanas";
        List<Bandana> lista = new ArrayList<>();
        try {
            con = cn.getConnection();
            if (con != null) { 
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Bandana b = new Bandana();
                    // Asegúrate de que los nombres en "" coincidan exactamente con tu tabla en MySQL
                    b.setId(rs.getInt("id_bandana")); 
                    b.setNombre(rs.getString("nombre"));
                    b.setIdEstilo(rs.getInt("id_estilo"));
                    b.setIdMaterial(rs.getInt("id_material"));
                    b.setPrecio(rs.getDouble("precio"));
                    b.setDescripcion(rs.getString("descripcion"));
                    // NUEVOS CAMPOS:
                    b.setStock(rs.getInt("stock"));
                    b.setImagen(rs.getString("imagen"));
                    
                    lista.add(b);
                }
            } else {
                System.err.println("Error: La conexión es nula.");
            }
        } catch (SQLException e) {
            System.err.println("Error en DAO al listar: " + e);
        } finally {
            try { if (rs != null) rs.close(); if (ps != null) ps.close(); } catch (SQLException e) {}
        }
        return lista;
    }
}
