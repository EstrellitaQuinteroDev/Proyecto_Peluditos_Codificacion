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

    public int agregar(Bandana b) {
        String sql = "INSERT INTO bandanas (nombre, id_estilo, id_material, precio, descripcion, stockXS, stockS, stockM, stockL, stockXL, imagen) VALUES (?,?,?,?,?,?,?,?,?,?,?)";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, b.getNombre());
            ps.setInt(2, b.getIdEstilo());
            ps.setInt(3, b.getIdMaterial());
            ps.setDouble(4, b.getPrecio());
            ps.setString(5, b.getDescripcion());
            ps.setInt(6, b.getStockXS());
            ps.setInt(7, b.getStockS());
            ps.setInt(8, b.getStockM());
            ps.setInt(9, b.getStockL());
            ps.setInt(10, b.getStockXL());
            ps.setString(11, b.getImagen());
            return ps.executeUpdate();
        } catch (Exception e) {
            System.err.println("Error al agregar: " + e);
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
                    b.setPrecio(rs.getDouble("precio"));
                    b.setDescripcion(rs.getString("descripcion"));
                    b.setImagen(rs.getString("imagen"));
                    b.setStockXS(rs.getInt("stockXS"));
                    b.setStockS(rs.getInt("stockS"));
                    b.setStockM(rs.getInt("stockM"));
                    b.setStockL(rs.getInt("stockL"));
                    b.setStockXL(rs.getInt("stockXL"));
                    b.setNombreEstilo(rs.getString("nombre_estilo"));
                    b.setNombreMaterial(rs.getString("nombre_material"));
                    lista.add(b);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error en DAO al listar bandanas: " + e);
        }
        return lista;
    }

    public Bandana listarId(int id) {
        Bandana b = new Bandana();
        String sql = "SELECT * FROM bandanas WHERE id_bandana = ?";
        
        try (Connection localCon = cn.getConnection();
             PreparedStatement localPs = localCon.prepareStatement(sql)) {
            
            localPs.setInt(1, id);
            try (ResultSet localRs = localPs.executeQuery()) {
                if (localRs.next()) {
                    b.setId(localRs.getInt("id_bandana"));
                    b.setNombre(localRs.getString("nombre"));
                    b.setIdEstilo(localRs.getInt("id_estilo"));
                    b.setIdMaterial(localRs.getInt("id_material"));
                    b.setPrecio(localRs.getDouble("precio"));
                    b.setDescripcion(localRs.getString("descripcion"));
                    b.setStockXS(localRs.getInt("stockXS"));
                    b.setStockS(localRs.getInt("stockS"));
                    b.setStockM(localRs.getInt("stockM"));
                    b.setStockL(localRs.getInt("stockL"));
                    b.setStockXL(localRs.getInt("stockXL"));
                    b.setImagen(localRs.getString("imagen"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error crítico en DAO al buscar ID " + id + ": " + e.getMessage());
        }
        return b;
    }

    public void eliminar(int id) {
        String sql = "DELETE FROM bandanas WHERE id_bandana = ?";
        try (Connection localCon = cn.getConnection();
             PreparedStatement localPs = localCon.prepareStatement(sql)) {
            localPs.setInt(1, id);
            localPs.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al eliminar: " + e.getMessage());
        }
    }

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
        try (Connection localCon = cn.getConnection();
             PreparedStatement localPs = localCon.prepareStatement(sql)) {
            localPs.setString(1, nombre);
            return localPs.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al registrar estilo: " + e.getMessage());
            return 0;
        }
    }

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
        try (Connection localCon = cn.getConnection();
             PreparedStatement localPs = localCon.prepareStatement(sql)) {
            localPs.setString(1, nombre);
            return localPs.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al registrar material: " + e.getMessage());
            return 0;
        }
    }

    public int actualizar(Bandana b) {
        String sql = "UPDATE bandanas SET nombre=?, precio=?, descripcion=?, id_estilo=?, id_material=?, "
                   + "stockXS=?, stockS=?, stockM=?, stockL=?, stockXL=?";
        
        if (b.getImagen() != null && !b.getImagen().isEmpty()) {
            sql += ", imagen=?";
        }
        sql += " WHERE id_bandana=?";

        int r = 0;
        config.Conexion cn = new config.Conexion();

        try (java.sql.Connection localCon = cn.getConnection();
             java.sql.PreparedStatement localPs = localCon.prepareStatement(sql)) {
            
            localPs.setString(1, b.getNombre());
            localPs.setDouble(2, b.getPrecio());
            localPs.setString(3, b.getDescripcion());
            localPs.setInt(4, b.getIdEstilo());
            localPs.setInt(5, b.getIdMaterial());
            localPs.setInt(6, b.getStockXS());
            localPs.setInt(7, b.getStockS());
            localPs.setInt(8, b.getStockM());
            localPs.setInt(9, b.getStockL());
            localPs.setInt(10, b.getStockXL());

            if (b.getImagen() != null && !b.getImagen().isEmpty()) {
                localPs.setString(11, b.getImagen());
                localPs.setInt(12, b.getId());
            } else {
                localPs.setInt(11, b.getId());
            }

            r = localPs.executeUpdate();
        } catch (Exception e) {
            System.err.println("Error en DAO Actualizar: " + e.getMessage());
        }
        return r;
    }
}