package com.peluditos;

import com.peluditos.dao.BandanaDAO;
import com.peluditos.model.Bandana;

/**
 * @author ESTRELLA-PC
 */
public class PeluditosConEstilo {

    public static void main(String[] args) {
        // 1. Instanciamos el DAO y el Modelo de datos
        BandanaDAO dao = new BandanaDAO();
        Bandana prueba = new Bandana();

        // 2. DATOS DE PRUEBA ACTUALIZADOS
        prueba.setEstilo("Natural");
        prueba.setNombre("Flores amarillas");
        prueba.setMaterial("Algodón"); // Campo nuevo
        prueba.setPrecio(28000);
        prueba.setDescripcion("Bandana con estampado floral ideal para primavera."); // Campo nuevo
        
        // Asignamos stock a cada talla según tu nueva base de datos
        prueba.setStockXS(5);
        prueba.setStockS(10);
        prueba.setStockM(15);
        prueba.setStockL(8);
        prueba.setStockXL(2);

        System.out.println("--- Iniciando Prueba de Funcionamiento CRUD ---");

        // 3. Ejecutar la inserción en la base de datos
        int resultado = dao.agregar(prueba);

        // 4. Mostrar el resultado en la consola
        if (resultado > 0) {
            System.out.println("✅ ÉXITO: El registro se guardó correctamente en MySQL.");
            System.out.println("Producto ingresado: " + prueba.getNombre());
        } else {
            System.out.println("❌ ERROR: No se pudo guardar el registro. Verifica la conexión.");
        }
    }
}