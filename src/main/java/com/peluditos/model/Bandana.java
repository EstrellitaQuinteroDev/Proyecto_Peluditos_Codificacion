package com.peluditos.model;

public class Bandana {
    private int id;
    private String estilo;
    private String nombre;
    private String material; // Nuevo campo
    private String imagenUrl; // Nuevo campo
    private double precio;
    private String descripcion; // Nuevo campo
    
    // Desglose de stock por tallas
    private int stockXS;
    private int stockS;
    private int stockM;
    private int stockL;
    private int stockXL;

    public Bandana() {
    }

    // --- GETTERS Y SETTERS ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getEstilo() { return estilo; }
    public void setEstilo(String estilo) { this.estilo = estilo; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getMaterial() { return material; }
    public void setMaterial(String material) { this.material = material; }

    public String getImagenUrl() { return imagenUrl; }
    public void setImagenUrl(String imagenUrl) { this.imagenUrl = imagenUrl; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    // Getters y Setters para los stocks individuales
    public int getStockXS() { return stockXS; }
    public void setStockXS(int stockXS) { this.stockXS = stockXS; }

    public int getStockS() { return stockS; }
    public void setStockS(int stockS) { this.stockS = stockS; }

    public int getStockM() { return stockM; }
    public void setStockM(int stockM) { this.stockM = stockM; }

    public int getStockL() { return stockL; }
    public void setStockL(int stockL) { this.stockL = stockL; }

    public int getStockXL() { return stockXL; }
    public void setStockXL(int stockXL) { this.stockXL = stockXL; }
}