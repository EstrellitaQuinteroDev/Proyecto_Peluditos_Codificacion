<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Bandana"%>
<%@page import="dao.BandanaDAO"%>
<%@ page import="dao.BandanaDAO" %>
<%@ page import="java.util.List" %>

<%
    // Creamos el DAO una sola vez para todo el archivo
    BandanaDAO dao = new BandanaDAO();
    
    // 1. Cargamos la lista principal para la tabla de administración
    List<Bandana> lista = dao.listar();
    
    // 2. Cargamos las listas para los menús desplegables (select) del modal
    List<String[]> listaEstilos = dao.listarEstilos();
    List<String[]> listaMateriales = dao.listarMateriales();
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrador - Peluditos con Estilo</title>
    <link rel="stylesheet" href="css/style.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body class="admin-page">
    <header class="header">
        <div class="logo">
            <a href="index.html">
                <img src="Imagenes/logo verde nombre.png" alt="Peluditos con estilo">
            </a>
        </div>
        <div class="header-right">
            <nav class="nav">
                <a href="#">Inventario</a>
                <a href="#">Pedidos</a>
            </nav>
            <div class="auth-buttons">
                <button id="btnLogout" class="btn btn-header-yellow">Cerrar sesión</button>
            </div>
        </div>
    </header>

    <main class="admin-container">
        <section class="admin-controls">
            <div class="filters-bar">
                <input type="text" placeholder="Buscar por nombre o ID..." class="filter-input-search">
                
                <div class="filter-group">
                    <label>Estilos</label>
                    <select class="filter-select">
                        <option>Todos</option>
                        <option>Galáctico</option>
                        <option>Urbano</option>
                        <option>Clásico</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label>Talla</label>
                    <select class="filter-select">
                        <option>Todas</option>
                        <option>XS</option>
                        <option>S</option>
                        <option>M</option>
                        <option>L</option>
                        <option>XL</option>
                    </select>
                </div>

                <div class="filter-group">
                    <label>Material</label>
                    <select class="filter-select">
                        <option>Todos</option>
                        <option>Algodón</option>
                        <option>Lino</option>
                    </select>
                </div>

                <button class="btn-limpiar">Limpiar</button>
            </div>

            <button type="button" class="btn-add-bandana" id="btn-nueva-bandana">+ Agregar nueva bandana</button>
        </section>

        <section class="inventory-table-container">
        <table class="admin-table">
            <thead>
                <tr>
                    <th>Estilo</th>
                    <th>Id</th>
                    <th>Nombre</th>
                    <th>Imagen</th>
                    <th>Stock Total</th>
                    <th>Precio</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    // Usamos la variable 'lista' que ya fue declarada al inicio del archivo
                    if (lista != null && !lista.isEmpty()) {
                        for (Bandana b : lista) {
                %>
                <tr>
                    <td><%= b.getNombreEstilo() != null ? b.getNombreEstilo() : "Sin estilo" %></td>

                    <td>N-<%= b.getId() %></td>

                    <td><%= b.getNombre() %></td>

                    <td>
                        <div class="img-placeholder-table" style="overflow: hidden; display: flex; justify-content: center; align-items: center;">
                            <% if(b.getImagen() != null && !b.getImagen().isEmpty()) { %>
                                <img src="img/bandanas/<%= b.getImagen() %>" alt="Bandana" style="width: 100%; height: 100%; object-fit: cover;">
                            <% } else { %>
                                <div style="font-size: 10px; color: gray;">Sin foto</div>
                            <% } %>
                        </div>
                    </td>

                    <td class="stock-status">
                        <% if(b.getStock() > 0) { %>
                            <span style="color: #28a745;">Disponible (<%= b.getStock() %>)</span>
                        <% } else { %>
                            <span style="color: #dc3545;">Agotado</span>
                        <% } %>
                    </td>

                    <td class="col-precio">$ <%= String.format("%.2f", b.getPrecio()) %></td>

                    <td class="actions-cell">
                        <button class="btn-action edit" title="Editar">✎</button>
                        <button class="btn-action delete" title="Eliminar">🗑</button>
                    </td>
                </tr>
                <% 
                        } 
                    } else { 
                %>
                <tr>
                    <td colspan="7" style="text-align: center; padding: 20px; color: gray;">
                        No hay bandanas registradas aún.
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        </section>
    </main>

    <div id="bandanaModal" class="login-modal">
        <div class="login-box modal-bandana">
            <span class="close-modal" id="close-main-modal">&times;</span>
            <div class="modal-logo-container">
                <img src="Imagenes/logo verde nombre.png" alt="Logo Peluditos" class="modal-logo-img">
            </div>
            
            <h2 class="modal-title">Nueva bandana</h2>

            <form id="formBandana" action="ControladorPrincipal" method="POST" enctype="multipart/form-data" class="modal-form-two-columns">
    
                <div class="modal-col-left">
                    <div class="image-upload-container">
                        <label for="file-input" class="image-preview-box" id="preview-container" style="cursor: pointer; overflow: hidden; display: flex; justify-content: center; align-items: center;">
                            <div id="inner-preview">
                                <img src="Imagenes/huella decorativa.png" alt="Previsualización" style="width: 50px; opacity: 0.3;">
                            </div>
                        </label>

                        <label for="file-input" class="btn-upload" style="display: inline-block; text-align: center; cursor: pointer;">
                            Cargar imagen
                        </label>

                        <input type="file" name="fotoBandana" id="file-input" accept="image/*" required style="display: none;">
                    </div>
                </div>

                <div class="modal-col-right">
                    <div class="input-group">
                        <label>Estilo:</label>
                        <div class="style-select-row">
                            <select name="id_estilo" class="form-select">
                                <option value="0">Seleccione un estilo...</option>
                                <%
                                    for(String[] estilo : listaEstilos) {
                                %>
                                    <option value="<%= estilo[0] %>"><%= estilo[1] %></option>
                                <%
                                    }
                                %>
                            </select>

                            <button type="button" class="btn-plus-style" id="btn-add-estilo">+</button>
                        </div>
                    </div>

                    <div class="input-group">
                        <label>Nombre</label>
                        <input type="text" name="nombreBandana" required>
                    </div>

                    <div class="input-group">
                        <label>Id</label>
                        <input type="text" class="input-id-readonly" readonly placeholder="Auto-generado">
                    </div>

                    <div class="input-group">
                        <label>Material:</label>
                        <div class="style-select-row">
                            <select name="id_material" class="form-select">
                                <option value="0">Seleccione un material...</option>
                                <%
                                    for(String[] material : listaMateriales) {
                                %>
                                    <option value="<%= material[0] %>"><%= material[1] %></option>
                                <%
                                    }
                                %>
                            </select>
                            
                            <button type="button" class="btn-plus-style" id="btn-add-material">+</button>
                        </div>
                    </div>

                    <div class="input-group">
                        <label>Stock por tallas</label>
                        <div class="stock-inputs-row">
                            <div class="stock-field"><label>XS</label><input type="number" name="stockXS" min="0" value="0"></div>
                            <div class="stock-field"><label>S</label><input type="number" name="stockS" min="0" value="0"></div>
                            <div class="stock-field"><label>M</label><input type="number" name="stockM" min="0" value="0"></div>
                            <div class="stock-field"><label>L</label><input type="number" name="stockL" min="0" value="0"></div>
                            <div class="stock-field"><label>XL</label><input type="number" name="stockXL" min="0" value="0"></div>
                        </div>
                    </div>

                    <div class="input-group">
                        <label>Precio</label>
                        <input type="number" step="0.01" name="precioBandana" placeholder="$ 0.00" required>
                    </div>
                </div>

                <div class="modal-full-width">
                    <div class="input-group">
                        <label>Descripción</label>
                        <textarea name="txtDescripcion" rows="4"></textarea>
                    </div>

                    <input type="hidden" name="accion" value="GuardarBandana">

                    <div class="modal-actions-footer">
                        <button type="submit" class="btn-save-changes">Guardar cambios</button>
                    </div>
                </div>
            </form>
            
            <img src="Imagenes/huella decorativa.png" class="paw-decor decor-left">
            <img src="Imagenes/huella decorativa.png" class="paw-decor decor-right">
        </div>
    </div>

    <div id="modal-nuevo-estilo" class="login-modal mini-overlay">
    <form action="ControladorPrincipal" method="POST" class="modal-bandana mini-box">
        <span class="close-modal">&times;</span>
        <h3 class="modal-title">Nuevo Estilo</h3>
        
        <input type="hidden" name="accion" value="GuardarEstilo">
        
        <div class="input-group">
            <input type="text" name="nombreNuevoEstilo" id="input-estilo-nombre" placeholder="Nombre del estilo..." required>
        </div>
        
        <button type="submit" class="btn-upload btn-save-extra" style="width: 100%" id="btn-guardar-estilo">
            Guardar Estilo
        </button>
    </form>
    </div>

    <div id="modal-nuevo-material" class="login-modal mini-overlay">
    <form action="ControladorPrincipal" method="POST" class="modal-bandana mini-box">
        <span class="close-modal">&times;</span>
        <h3 class="modal-title">Nuevo Material</h3>
        
        <input type="hidden" name="accion" value="GuardarMaterial">
        
        <div class="input-group">
            <input type="text" name="nombreNuevoMaterial" id="input-material-nombre" placeholder="Nombre del material..." required>
        </div>
        
        <button type="submit" class="btn-upload btn-save-extra" style="width: 100%" id="btn-guardar-material">
            Guardar Material
        </button>
    </form>
    </div>

    <footer class="footer">
        <div class="footer-bottom">
            <p>© 2025 Peluditos con estilo – Todos los derechos reservados.</p>
        </div>
    </footer>
                            
    <script src="js/auth.js"></script>
    
    <script>
        <%-- Bloque para Estilo --%>
        <% if (request.getParameter("exito_estilo") != null) { %>
            Swal.fire({
                title: '¡Estilo Agregado!',
                text: 'El nuevo estilo ya está disponible en la lista.',
                icon: 'success',
                confirmButtonColor: '#1a4731'
            }).then(() => { openBandanaModal(); });
        <% } %>

        <%-- Bloque para Material (El que sí te funciona en image_714abf.png) --%>
        <% if (request.getParameter("exito_material") != null) { %>
            Swal.fire({
                title: '¡Material Agregado!',
                text: 'El nuevo material ya está disponible en la lista.',
                icon: 'success',
                confirmButtonColor: '#1a4731'
            }).then(() => { openBandanaModal(); });
        <% } %>
    </script>                      
    
    
</body>
</html>