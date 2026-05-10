package controlador;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

// Esta línea reemplaza lo que el asistente no pudo hacer. 
// Le dice al servidor que este archivo es un Servlet.
@WebServlet(name = "ControladorPrincipal", urlPatterns = {"/ControladorPrincipal"})
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
