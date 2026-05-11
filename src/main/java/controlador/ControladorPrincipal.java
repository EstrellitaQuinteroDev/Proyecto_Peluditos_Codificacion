package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig; // IMPORTANTE PARA IMÁGENES
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part; // IMPORTANTE PARA IMÁGENES
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

@WebServlet(name = "ControladorPrincipal", urlPatterns = {"/ControladorPrincipal"})
// Añadimos configuración para manejar archivos (máximo 10MB por foto)
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) 
public class ControladorPrincipal extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if (accion != null) {
            // --- Lógica de Login existente ---
            if (accion.equals("Ingresar")) {
                String correo = request.getParameter("txtCorreo");
                String clave = request.getParameter("txtClave");

                if ("admin@peluditos.com".equals(correo) && "sena2026".equals(clave)) {
                    response.sendRedirect("administrador.jsp");
                } else {
                    response.sendRedirect("index.jsp?error=1");
                }
            } 
            
            // --- NUEVA LÓGICA: Guardar Bandana ---
            else if (accion.equals("GuardarBandana")) {
                try {
                    // 1. Recoger datos de texto
                    String nombre = request.getParameter("nombreBandana");
                    String precio = request.getParameter("precioBandana");
                    String stock = request.getParameter("stockBandana");

                    // 2. Manejar la imagen
                    Part filePart = request.getPart("fotoBandana"); 
                    String fileName = filePart.getSubmittedFileName();
                    
                    // Definimos la ruta de guardado (Carpeta 'img/bandanas' dentro de la app)
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "img" + File.separator + "bandanas";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs(); // Crea la carpeta si no existe

                    // Guardar el archivo físicamente
                    File file = new File(uploadPath + File.separator + fileName);
                    try (InputStream input = filePart.getInputStream()) {
                        Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    }

                    // 3. AQUÍ IRÁ EL DAO (Por ahora solo confirmamos)
                    System.out.println("Guardado exitoso: " + nombre + " Imagen: " + fileName);
                    
                    // Redirigir de nuevo al panel para ver cambios
                    response.sendRedirect("administrador.jsp?exito=1");

                } catch (Exception e) {
                    System.out.println("Error al guardar: " + e.getMessage());
                    response.sendRedirect("administrador.jsp?error=save");
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
