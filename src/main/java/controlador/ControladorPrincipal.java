package controlador;

import dao.BandanaDAO; 
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.List;
import modelo.Bandana; 

@WebServlet(name = "ControladorPrincipal", urlPatterns = {"/ControladorPrincipal"})
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
            
            // --- Lógica para Guardar Bandana ---
            else if (accion.equals("GuardarBandana")) {
                try {
                    String nombre = request.getParameter("nombreBandana");
                    double precio = Double.parseDouble(request.getParameter("precioBandana"));
                    String descripcion = request.getParameter("txtDescripcion");
                    int idEstilo = Integer.parseInt(request.getParameter("id_estilo"));
                    int idMaterial = Integer.parseInt(request.getParameter("id_material"));

                    int sXS = leerStock(request.getParameter("stockXS"));
                    int sS  = leerStock(request.getParameter("stockS"));
                    int sM  = leerStock(request.getParameter("stockM"));
                    int sL  = leerStock(request.getParameter("stockL"));
                    int sXL = leerStock(request.getParameter("stockXL"));
                    int stockTotal = sXS + sS + sM + sL + sXL;

                    Part filePart = request.getPart("fotoBandana"); 
                    String fileName = filePart.getSubmittedFileName();
                    
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "img" + File.separator + "bandanas";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs(); 

                    File file = new File(uploadPath + File.separator + fileName);
                    try (InputStream input = filePart.getInputStream()) {
                        Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                    }

                    Bandana b = new Bandana();
                    b.setNombre(nombre);
                    b.setPrecio(precio);
                    b.setDescripcion(descripcion);
                    b.setIdEstilo(idEstilo);
                    b.setIdMaterial(idMaterial);
                    b.setStock(stockTotal);
                    b.setImagen(fileName);

                    BandanaDAO dao = new BandanaDAO();
                    int resultado = dao.agregar(b);

                    if (resultado > 0) {
                        response.sendRedirect("administrador.jsp?exito=1");
                    } else {
                        response.sendRedirect("administrador.jsp?error=db");
                    }

                } catch (Exception e) {
                    System.out.println("Error al guardar bandana: " + e.getMessage());
                    response.sendRedirect("administrador.jsp?error=save");
                }
            }
            
            // --- NUEVA LÓGICA: Guardar Nuevo Estilo ---
            else if (accion.equals("GuardarEstilo")) {
                try {
                    String nombreEstilo = request.getParameter("nombreNuevoEstilo");
                    if (nombreEstilo != null && !nombreEstilo.trim().isEmpty()) {
                        BandanaDAO dao = new BandanaDAO();
                        dao.registrarEstilo(nombreEstilo);
                        response.sendRedirect("administrador.jsp?exito_estilo=1");
                    } else {
                        response.sendRedirect("administrador.jsp?error=vacio");
                    }
                } catch (Exception e) {
                    System.err.println("Error al guardar estilo: " + e.getMessage());
                    response.sendRedirect("administrador.jsp?error=1");
                }
            }

            // --- NUEVA LÓGICA: Guardar Nuevo Material ---
            else if (accion.equals("GuardarMaterial")) {
                try {
                    String nombreMaterial = request.getParameter("nombreNuevoMaterial");
                    if (nombreMaterial != null && !nombreMaterial.trim().isEmpty()) {
                        BandanaDAO dao = new BandanaDAO();
                        dao.registrarMaterial(nombreMaterial);
                        response.sendRedirect("administrador.jsp?exito_material=1");
                    } else {
                        response.sendRedirect("administrador.jsp?error=vacio");
                    }
                } catch (Exception e) {
                    System.err.println("Error al guardar material: " + e.getMessage());
                    response.sendRedirect("administrador.jsp?error=1");
                }
            }
        }
    }

    private int leerStock(String valor) {
        if (valor == null || valor.trim().isEmpty()) {
            return 0;
        }
        try {
            return Integer.parseInt(valor);
        } catch (NumberFormatException e) {
            return 0;
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