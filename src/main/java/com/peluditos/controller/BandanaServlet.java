package com.peluditos.controller;

import com.peluditos.dao.BandanaDAO;
import com.peluditos.model.Bandana;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Controlador principal para el proyecto Peluditos con Estilo.
 * Gestiona el acceso administrativo y el CRUD de bandanas.
 */
@WebServlet(name = "Controlador", urlPatterns = {"/Controlador"})
public class BandanaServlet extends HttpServlet {
    
    // Instancias para manejo de datos
    BandanaDAO dao = new BandanaDAO();
    Bandana b = new Bandana();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");

        // 1. LÓGICA DE LOGIN (ACCESO AL PANEL)
        if (accion != null && accion.equalsIgnoreCase("Ingresar")) {
            String correo = request.getParameter("txtCorreo");
            String clave = request.getParameter("txtClave");

            // Validación de credenciales para la evidencia del SENA
            if ("admin@peluditos.com".equals(correo) && "sena2026".equals(clave)) {
                // Si es correcto, despachamos la vista del administrador
                request.getRequestDispatcher("administrador.jsp").forward(request, response);
            } else {
                // Si falla, redirigimos al index con un parámetro de error
                response.sendRedirect("index.jsp?error=1");
            }
        }
        
        // 2. LÓGICA DE REGISTRO (GUARDAR NUEVA BANDANA)
        else if (accion != null && accion.equalsIgnoreCase("Guardar")) {
            try {
                // Captura de datos básicos
                b.setEstilo(request.getParameter("txtEstilo"));
                b.setNombre(request.getParameter("txtNombre"));
                b.setMaterial(request.getParameter("txtMaterial"));
                b.setPrecio(Double.parseDouble(request.getParameter("txtPrecio")));
                b.setDescripcion(request.getParameter("txtDescripcion"));
                
                // Captura de stocks por talla
                b.setStockXS(Integer.parseInt(request.getParameter("txtXS")));
                b.setStockS(Integer.parseInt(request.getParameter("txtS")));
                b.setStockM(Integer.parseInt(request.getParameter("txtM")));
                b.setStockL(Integer.parseInt(request.getParameter("txtL")));
                b.setStockXL(Integer.parseInt(request.getParameter("txtXL")));

                dao.agregar(b);
                // Redirigimos de vuelta al panel para ver el cambio
                response.sendRedirect("administrador.jsp");
            } catch (NumberFormatException e) {
                // En caso de error en números, volvemos al panel
                response.sendRedirect("administrador.jsp?error=formato");
            }
        }
        
        // 3. PROTECCIÓN: Si no hay acción válida, volvemos al inicio
        else {
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        // LÓGICA DE ELIMINACIÓN
        if (accion != null && accion.equalsIgnoreCase("Eliminar")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                dao.eliminar(id);
                response.sendRedirect("administrador.jsp");
            } catch (Exception e) {
                response.sendRedirect("administrador.jsp?error=eliminar");
            }
        } else {
            response.sendRedirect("index.jsp");
        }
    }
}