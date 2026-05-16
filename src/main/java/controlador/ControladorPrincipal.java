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
import modelo.Bandana; 

@WebServlet(name = "ControladorPrincipal", urlPatterns = {"/ControladorPrincipal"})
@MultipartConfig(maxFileSize = 1024 * 1024 * 10) 
public class ControladorPrincipal extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if (accion != null) {
            if (accion.equals("Ingresar")) {
                String correo = request.getParameter("txtCorreo");
                String clave = request.getParameter("txtClave");

                if ("admin@peluditos.com".equals(correo) && "sena2026".equals(clave)) {
                    response.sendRedirect("administrador.jsp");
                } else {
                    response.sendRedirect("index.jsp?error=1");
                }
            } 
            
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

                    Part filePart = request.getPart("fotoBandana"); 
                    String fileName = filePart.getSubmittedFileName();
                    
                    String uploadPath = getServletContext().getRealPath("") + File.separator + "img" + File.separator + "bandanas";
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) uploadDir.mkdirs(); 

                    if (fileName != null && !fileName.isEmpty()) {
                        File file = new File(uploadPath + File.separator + fileName);
                        try (InputStream input = filePart.getInputStream()) {
                            Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                        }
                    }

                    Bandana b = new Bandana();
                    b.setNombre(nombre);
                    b.setPrecio(precio);
                    b.setDescripcion(descripcion);
                    b.setIdEstilo(idEstilo);
                    b.setIdMaterial(idMaterial);
                    b.setImagen(fileName);
                    b.setStockXS(sXS);
                    b.setStockS(sS);
                    b.setStockM(sM);
                    b.setStockL(sL);
                    b.setStockXL(sXL);

                    BandanaDAO dao = new BandanaDAO();
                    int resultado = dao.agregar(b);

                    if (resultado > 0) {
                        response.sendRedirect("administrador.jsp?exito=1");
                    } else {
                        response.sendRedirect("administrador.jsp?error=db");
                    }
                } catch (Exception e) {
                    response.sendRedirect("administrador.jsp?error=save");
                }
            }

            else if (accion.equals("ActualizarBandana")) {
                try {
                    int id = Integer.parseInt(request.getParameter("id_bandana"));
                    String nombre = request.getParameter("nombreBandana");
                    double precio = Double.parseDouble(request.getParameter("precioBandana"));
                    String descripcion = request.getParameter("txtDescripcion");
                    
                    BandanaDAO dao = new BandanaDAO();
                    
                    int idEstilo;
                    int idMaterial;
                    
                    String paramEstilo = request.getParameter("id_estilo");
                    String paramMaterial = request.getParameter("id_material");
                    
                    // Si el navegador llega a omitir los select por pointer-events en alguna variante de arquitectura:
                    if (paramEstilo == null || paramEstilo.trim().isEmpty() || paramEstilo.equals("0")) {
                        Bandana bandanaActual = dao.listarId(id);
                        idEstilo = bandanaActual.getIdEstilo();
                    } else {
                        idEstilo = Integer.parseInt(paramEstilo);
                    }
                    
                    if (paramMaterial == null || paramMaterial.trim().isEmpty() || paramMaterial.equals("0")) {
                        Bandana bandanaActual = dao.listarId(id);
                        idMaterial = bandanaActual.getIdMaterial();
                    } else {
                        idMaterial = Integer.parseInt(paramMaterial);
                    }

                    int sXS = leerStock(request.getParameter("stockXS"));
                    int sS  = leerStock(request.getParameter("stockS"));
                    int sM  = leerStock(request.getParameter("stockM"));
                    int sL  = leerStock(request.getParameter("stockL"));
                    int sXL = leerStock(request.getParameter("stockXL"));

                    Part filePart = request.getPart("fotoBandana");
                    String fileName = filePart.getSubmittedFileName();
                    
                    Bandana b = new Bandana();
                    b.setId(id);
                    b.setNombre(nombre);
                    b.setPrecio(precio);
                    b.setDescripcion(descripcion);
                    b.setIdEstilo(idEstilo);
                    b.setIdMaterial(idMaterial);
                    b.setStockXS(sXS);
                    b.setStockS(sS);
                    b.setStockM(sM);
                    b.setStockL(sL);
                    b.setStockXL(sXL);

                    if (fileName != null && !fileName.isEmpty()) {
                        String uploadPath = getServletContext().getRealPath("") + File.separator + "img" + File.separator + "bandanas";
                        File file = new File(uploadPath + File.separator + fileName);
                        try (InputStream input = filePart.getInputStream()) {
                            Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                        }
                        b.setImagen(fileName);
                    } else {
                        Bandana bandanaActual = dao.listarId(id);
                        b.setImagen(bandanaActual.getImagen()); 
                    }

                    int resultado = dao.actualizar(b);

                    if (resultado > 0) {
                        response.sendRedirect("administrador.jsp?editado=1");
                    } else {
                        response.sendRedirect("administrador.jsp?error=db_update");
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("administrador.jsp?error=update_fail");
                }
            }
            
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
                    response.sendRedirect("administrador.jsp?error=1");
                }
            }

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
                    response.sendRedirect("administrador.jsp?error=1");
                }
            }
            
            else if (accion.equals("eliminarBandana")) {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    BandanaDAO dao = new BandanaDAO();
                    dao.eliminar(id);
                    response.sendRedirect("administrador.jsp?eliminado=1");
                } catch (Exception e) {
                    response.sendRedirect("administrador.jsp?error=delete");
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