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

    // --- MÉTODOS PARA BANDANAS ---
    
    public int agregar(Bandana b) {
        // CORRECCIÓN: Usamos INSERT INTO para guardar en la BD
        String sql = "INSERT INTO bandanas (nombre, id_estilo, id_material, precio, descripcion, stock, imagen) VALUES (?,?,?,?,?,?,?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, b.getNombre());
            ps.setInt(2, b.getIdEstilo());
            ps.setInt(3, b.getIdMaterial());
            ps.setDouble(4, b.getPrecio());
            ps.setString(5, b.getDescripcion());
            ps.setInt(6, b.getStock());
            ps.setString(7, b.getImagen());
            return ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error en DAO al agregar bandana: " + e);
            return 0;
        }
    }

    public List<Bandana> listar() {
        String sql = "SELECT b.*, e.nombre_estilo, m.nombre_material FROM bandanas b "
                   + "INNER JOIN estilos e ON b.id_estilo = e.id_estilo "
                   + "INNER JOIN materiales m ON b.id_material = m.id_material";
        List<Bandana> lista = new ArrayList<>();
        try {
            con = cn.getConnection();
            if (con != null) {
                ps = con.prepareStatement(sql);
                rs = ps.executeQuery();
                while (rs.next()) {
                    Bandana b = new Bandana();
                    b.setId(rs.getInt("id_bandana"));
                    b.setNombre(rs.getString("nombre"));
                    b.setIdEstilo(rs.getInt("id_estilo"));
                    b.setNombreEstilo(rs.getString("nombre_estilo")); // Para mostrar el nombre en la tabla
                    b.setIdMaterial(rs.getInt("id_material"));
                    b.setPrecio(rs.getDouble("precio"));
                    b.setDescripcion(rs.getString("descripcion"));
                    b.setStock(rs.getInt("stock"));
                    b.setImagen(rs.getString("imagen"));
                    lista.add(b);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error en DAO al listar bandanas: " + e);
        }
        return lista;
    }

    // --- MÉTODOS PARA ESTILOS ---

    public List<String[]> listarEstilos() {
        List<String[]> lista = new ArrayList<>();
        String sql = "SELECT id_estilo, nombre_estilo FROM estilos";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(new String[]{rs.getString("id_estilo"), rs.getString("nombre_estilo")});
            }
        } catch (SQLException e) {
            System.err.println("Error al listar estilos: " + e);
        }
        return lista;
    }

    public int registrarEstilo(String nombre) {
        String sql = "INSERT INTO estilos (nombre_estilo) VALUES (?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, nombre);
            return ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al registrar estilo: " + e);
            return 0;
        }
    }

    // --- MÉTODOS PARA MATERIALES ---

    public List<String[]> listarMateriales() {
        List<String[]> lista = new ArrayList<>();
        String sql = "SELECT id_material, nombre_material FROM materiales";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                lista.add(new String[]{rs.getString("id_material"), rs.getString("nombre_material")});
            }
        } catch (SQLException e) {
            System.err.println("Error al listar materiales: " + e);
        }
        return lista;
    }

    public int registrarMaterial(String nombre) {
        String sql = "INSERT INTO materiales (nombre_material) VALUES (?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, nombre);
            return ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al registrar material: " + e);
            return 0;
        }
    }
}
