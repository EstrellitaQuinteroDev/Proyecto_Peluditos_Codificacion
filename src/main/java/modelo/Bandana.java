package modelo;

public class Bandana {
    private int id;
    private String nombre;
    private int idEstilo;
    private int idMaterial;
    private double precio;
    private String descripcion;

    public Bandana() {}

    // Getters y Setters (Usa Alt+Insert en NetBeans para generarlos rápido)
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
}
