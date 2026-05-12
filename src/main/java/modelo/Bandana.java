package modelo;

public class Bandana {
    private int id;
    private String nombre;
    private int idEstilo;
    private int idMaterial;
    private double precio;
    private String descripcion;
    // Nuevos campos necesarios:
    private int stock; // Aquí guardaremos la suma de XS, S, M, L y XL
    private String imagen; // Aquí guardaremos el nombre o ruta del archivo (ej: "bandana_galactica.jpg")

    public Bandana() {}

    // Getters y Setters
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

    public int getStock() { return stock; }
    public void setStock(int stock) { this.stock = stock; }

    public String getImagen() { return imagen; }
    public void setImagen(String imagen) { this.imagen = imagen; }
}
