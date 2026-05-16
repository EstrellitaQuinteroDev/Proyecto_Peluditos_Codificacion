package modelo;

public class Bandana {
    private int id;
    private String nombre;
    private int idEstilo;
    private int idMaterial;
    private double precio;
    private String descripcion;
    private int stock; // Variable de apoyo
    private int stockXS;
    private int stockS;
    private int stockM;
    private int stockL;
    private int stockXL;
    private String imagen;
    
    private String nombreEstilo;
    private String nombreMaterial;

    public Bandana() {}

    // --- MÉTODOS CLAVE PARA QUITAR EL ERROR ---
    public int getStock() { 
        // Esto suma las tallas automáticamente para el DAO y la tabla
        return stockXS + stockS + stockM + stockL + stockXL; 
    }
    public void setStock(int stock) { this.stock = stock; }

    // --- RESTO DE GETTERS Y SETTERS ---
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public int getIdEstilo() { return idEstilo; }
    public void setIdEstilo(int idEstilo) { this.idEstilo = idEstilo; }

    public int getIdMaterial() { return idMaterial; }
    public void setIdMaterial(int idMaterial) { this.idMaterial = idMaterial; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

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

    public String getImagen() { return imagen; }
    public void setImagen(String imagen) { this.imagen = imagen; }
    
    public String getNombreEstilo() { return nombreEstilo; }
    public void setNombreEstilo(String nombreEstilo) { this.nombreEstilo = nombreEstilo; }
    
    public String getNombreMaterial() { return nombreMaterial; }
    public void setNombreMaterial(String nombreMaterial) { this.nombreMaterial = nombreMaterial; }
}