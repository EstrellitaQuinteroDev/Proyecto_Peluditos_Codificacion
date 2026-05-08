package com.peluditos.dao;

import com.peluditos.conexion.Conexion;
import com.peluditos.model.Bandana;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BandanaDAO {
    Conexion conectar = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    // 1. INSERTAR (Create)
    public int agregar(Bandana b) {
        String sql = "INSERT INTO bandanas (estilo, nombre_bandana, material, precio, descripcion_detallada, stock_xs, stock_s, stock_m, stock_l, stock_xl) VALUES (?,?,?,?,?,?,?,?,?,?)";
        try {
            con = conectar.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, b.getEstilo());
            ps.setString(2, b.getNombre());
            ps.setString(3, b.getMaterial());
            ps.setDouble(4, b.getPrecio());
            ps.setString(5, b.getDescripcion());
            ps.setInt(6, b.getStockXS());
            ps.setInt(7, b.getStockS());
            ps.setInt(8, b.getStockM());
            ps.setInt(9, b.getStockL());
            ps.setInt(10, b.getStockXL());
            return ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al insertar: " + e.getMessage());
            return 0;
        }
    }

    // 2. CONSULTAR (Read)
    public List<Bandana> listar() {
        List<Bandana> datos = new ArrayList<>();
        String sql = "SELECT * FROM bandanas";
        try {
            con = conectar.getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Bandana b = new Bandana();
                b.setId(rs.getInt("id"));
                b.setEstilo(rs.getString("estilo"));
                b.setNombre(rs.getString("nombre_bandana"));
                b.setMaterial(rs.getString("material"));
                b.setPrecio(rs.getDouble("precio"));
                b.setDescripcion(rs.getString("descripcion_detallada"));
                b.setStockXS(rs.getInt("stock_xs"));
                b.setStockS(rs.getInt("stock_s"));
                b.setStockM(rs.getInt("stock_m"));
                b.setStockL(rs.getInt("stock_l"));
                b.setStockXL(rs.getInt("stock_xl"));
                datos.add(b);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar: " + e.getMessage());
        }
        return datos;
    }

    // 3. ACTUALIZAR (Update)
    public int actualizar(Bandana b) {
        String sql = "UPDATE bandanas SET estilo=?, nombre_bandana=?, material=?, precio=?, descripcion_detallada=?, stock_xs=?, stock_s=?, stock_m=?, stock_l=?, stock_xl=? WHERE id=?";
        try {
            con = conectar.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, b.getEstilo());
            ps.setString(2, b.getNombre());
            ps.setString(3, b.getMaterial());
            ps.setDouble(4, b.getPrecio());
            ps.setString(5, b.getDescripcion());
            ps.setInt(6, b.getStockXS());
            ps.setInt(7, b.getStockS());
            ps.setInt(8, b.getStockM());
            ps.setInt(9, b.getStockL());
            ps.setInt(10, b.getStockXL());
            ps.setInt(11, b.getId());
            return ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al actualizar: " + e.getMessage());
            return 0;
        }
    }

    // 4. ELIMINAR (Delete)
    public void eliminar(int id) {
        String sql = "DELETE FROM bandanas WHERE id=?";
        try {
            con = conectar.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.err.println("Error al eliminar: " + e.getMessage());
        }
    }
}
