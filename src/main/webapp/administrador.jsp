<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Bandana"%>
<%@page import="dao.BandanaDAO"%>

<%
    BandanaDAO dao = new BandanaDAO();
    List<Bandana> lista = dao.listar();
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
                <a href="ControladorPrincipal?accion=CerrarSesion" class="btn-cerrar-sesion">Cerrar sesión</a>
            </div>
        </div>
    </header>

    <main class="admin-container">
        <section class="admin-controls">
            <div class="filters-bar">
                <input type="text" id="filter-search" placeholder="Buscar por nombre o ID..." class="filter-input-search">

                <div class="filter-group">
                    <label>Estilos</label>
                    <select id="filter-style" class="filter-select">
                        <option value="Todos">Todos</option>
                        <%-- Iteramos sobre la lista real de la base de datos --%>
                        <% if (listaEstilos != null) {
                            for(String[] estilo : listaEstilos) { %>
                                <option value="<%= estilo[1] %>"><%= estilo[1] %></option>
                        <%  } 
                        } %>
                    </select>
                </div>

                <button type="button" id="btn-clean-filters" class="btn-limpiar">Limpiar</button>
            </div>

            <button type="button" class="btn-add-bandana" id="btn-nueva-bandana">
                + Agregar nueva bandana
            </button>
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
                    <% if (lista != null && !lista.isEmpty()) {
                        for (Bandana b : lista) { %>
                    <tr>
                        <td><%= b.getNombreEstilo() != null ? b.getNombreEstilo() : "Sin estilo" %></td>
                        <td>N-<%= b.getId() %></td>
                        <td><%= b.getNombre() %></td>
                        <td>
                            <div class="img-placeholder-table" style="overflow: hidden; display: flex; justify-content: center; align-items: center; width: 50px; height: 50px;">
                                <% if(b.getImagen() != null && !b.getImagen().isEmpty()) { %>
                                    <img src="${pageContext.request.contextPath}/Imagenes/bandanas/<%= b.getImagen() %>" 
                                         alt="Bandana" 
                                         style="width: 100%; height: 100%; object-fit: cover; border-radius: 5px;">
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
                            <button class="btn-action edit" title="Editar" onclick="prepararEdicion(
                                '<%= b.getId() %>', '<%= b.getNombre() %>', '<%= b.getPrecio() %>', '<%= b.getDescripcion() %>', 
                                '<%= b.getIdEstilo() %>', '<%= b.getIdMaterial() %>', <%= b.getStockXS() %>, <%= b.getStockS() %>, 
                                <%= b.getStockM() %>, <%= b.getStockL() %>, <%= b.getStockXL() %>, '<%= b.getImagen() %>'
                            )">✎</button>
                            <button class="btn-action delete" title="Eliminar" onclick="confirmarEliminacion('<%= b.getId() %>')">🗑</button>
                        </td>
                    </tr>
                    <% } } else { %>
                    <tr><td colspan="7" style="text-align: center; padding: 20px; color: gray;">No hay bandanas registradas.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </section>
    </main>

    <div id="bandanaModal" class="login-modal">
        <div class="login-box modal-bandana">
            <span class="close-modal" id="close-main-modal" onclick="closeBandanaModal()">&times;</span>
            <div class="modal-logo-container">
                <img src="Imagenes/logo verde nombre.png" alt="Logo Peluditos" class="modal-logo-img">
            </div>
            <h2 class="modal-title" id="titulo-modal">Nueva bandana</h2>

            <form id="formBandana" action="ControladorPrincipal" method="POST" enctype="multipart/form-data" class="modal-form-two-columns">
                <div class="modal-col-left">
                    <div class="image-upload-container">
                        <label for="file-input" class="image-preview-box" id="preview-container">
                            <div id="inner-preview">
                                <img src="Imagenes/huella decorativa.png" alt="Previsualización" style="width: 50px; opacity: 0.3;">
                            </div>
                        </label>
                        <label for="file-input" class="btn-upload">Cargar imagen</label>
                        <input type="file" name="fotoBandana" id="file-input" accept="image/*" style="display: none;">
                    </div>
                </div>

                <div class="modal-col-right">
                    <div class="input-group">
                        <label>Estilo:</label>
                        <div class="style-select-row">
                            <select name="id_estilo" id="input-estilo" class="form-select">
                                <option value="0">Seleccione un estilo...</option>
                                <% for(String[] estilo : listaEstilos) { %>
                                    <option value="<%= estilo[0] %>"><%= estilo[1] %></option>
                                <% } %>
                            </select>
                            <button type="button" class="btn-plus-style" onclick="abrirMiniModal('modal-nuevo-estilo')">+</button>
                        </div>
                    </div>

                    <div class="input-group">
                        <label>Nombre</label>
                        <input type="text" name="nombreBandana" id="input-nombre" required>
                    </div>

                    <div class="input-group">
                        <label>Id</label>
                        <input type="text" id="input-id-bandana" class="input-id-readonly" readonly placeholder="Auto-generado">
                        <input type="hidden" name="id_bandana" id="input-id-hidden">
                    </div>

                    <div class="input-group">
                        <label>Material:</label>
                        <div class="style-select-row">
                            <select name="id_material" id="input-material" class="form-select">
                                <option value="0">Seleccione un material...</option>
                                <% for(String[] material : listaMateriales) { %>
                                    <option value="<%= material[0] %>"><%= material[1] %></option>
                                <% } %>
                            </select>
                            <button type="button" class="btn-plus-style" onclick="abrirMiniModal('modal-nuevo-material')">+</button>
                        </div>
                    </div>

                    <div class="input-group">
                        <label>Stock por tallas</label>
                        <div class="stock-inputs-row">
                            <div class="stock-field"><label>XS</label><input type="number" name="stockXS" id="stk-xs" value="0"></div>
                            <div class="stock-field"><label>S</label><input type="number" name="stockS" id="stk-s" value="0"></div>
                            <div class="stock-field"><label>M</label><input type="number" name="stockM" id="stk-m" value="0"></div>
                            <div class="stock-field"><label>L</label><input type="number" name="stockL" id="stk-l" value="0"></div>
                            <div class="stock-field"><label>XL</label><input type="number" name="stockXL" id="stk-xl" value="0"></div>
                        </div>
                    </div>

                    <div class="input-group">
                        <label>Precio</label>
                        <input type="number" step="0.01" name="precioBandana" id="input-precio" required>
                    </div>
                </div>

                <div class="modal-full-width">
                    <div class="input-group">
                        <label>Descripción</label>
                        <textarea name="txtDescripcion" id="input-descripcion" rows="4"></textarea>
                    </div>
                    <input type="hidden" name="accion" id="input-accion" value="GuardarBandana">
                    <div class="modal-actions-footer">
                        <button type="submit" class="btn-save-changes">Guardar cambios</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
                            
    <div id="modal-nuevo-estilo" class="login-modal" style="display: none;">
        <div class="login-box mini-modal">
            <span class="close-modal">&times;</span>
            <h3 class="modal-title">Agregar Nuevo Estilo</h3>

            <form action="ControladorPrincipal" method="POST" class="modal-form">
                <input type="hidden" name="accion" value="GuardarEstilo">
                <div class="input-group">
                    <label>Nombre del Estilo</label>
                    <input type="text" name="nombreEstilo" id="input-estilo-nombre" required placeholder="Ej: Navideño">
                </div>
                <button type="submit" class="btn-save-changes">Guardar Estilo</button>
            </form>
        </div>
    </div>

    <div id="modal-nuevo-material" class="login-modal" style="display: none;">
        <div class="login-box mini-modal">
            <span class="close-modal">&times;</span>
            <h3 class="modal-title">Agregar Nuevo Material</h3>

            <form action="ControladorPrincipal" method="POST" class="modal-form">
                <input type="hidden" name="accion" value="GuardarMaterial">
                <div class="input-group">
                    <label>Nombre del Material</label>
                    <input type="text" name="nombreMaterial" id="input-material-nombre" required placeholder="Ej: Seda">
                </div>
                <button type="submit" class="btn-save-changes">Guardar Material</button>
            </form>
        </div>
    </div>                       
    <script src="js/auth.js"></script>                            

</body>
</html>