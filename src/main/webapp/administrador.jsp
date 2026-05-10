<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Bandana"%>
<%@page import="dao.BandanaDAO"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrador - Peluditos con Estilo</title>
    <link rel="stylesheet" href="css/style.css">
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
                    BandanaDAO dao = new BandanaDAO();
                    List<Bandana> lista = dao.listar();
                    for (Bandana b : lista) {
                %>
                <tr>
                    <td>Estilo #<%= b.getIdEstilo() %></td>
                    <td>N-<%= b.getId() %></td>
                    <td><%= b.getNombre() %></td>
                    <td><div class="img-placeholder-table"></div></td>
                    <td class="stock-status">Disponible</td>
                    <td class="col-precio">$ <%= b.getPrecio() %></td>
                    <td class="actions-cell">
                        <button class="btn-action edit">✎</button>
                        <button class="btn-action delete">🗑</button>
                    </td>
                </tr>
                <% 
                    } 
                %>
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

            <form id="formBandana" action="ControladorPrincipal" method="POST" class="modal-form-two-columns">
                
                <div class="modal-col-left">
                    <div class="image-upload-container">
                        <div class="image-preview-box"></div>
                        <button type="button" class="btn-upload">Cargar imagen</button>
                    </div>
                </div>

                <div class="modal-col-right">
                    <div class="input-group">
                        <label>Estilo:</label>
                        <div class="style-select-row">
                            <select name="id_estilo" id="select-estilo">
                                <option value="1">Galáctico</option>
                            </select>
                            <button type="button" class="btn-plus-style" id="btn-add-estilo">+</button>
                        </div>
                    </div>

                    <div class="input-group">
                        <label>Nombre</label>
                        <input type="text" name="txtNombre" required>
                    </div>

                    <div class="input-group">
                        <label>Id</label>
                        <input type="text" class="input-id-readonly" readonly placeholder="Auto-generado">
                    </div>

                    <div class="input-group">
                        <label>Material:</label>
                        <div class="style-select-row">
                            <select name="id_material" id="select-material">
                                <option value="1">Algodón</option>
                            </select>
                            <button type="button" class="btn-plus-style" id="btn-add-material">+</button>
                        </div>
                    </div>

                    <div class="input-group">
                        <label>Stock Total</label>
                        <div class="stock-inputs-row">
                            <div class="stock-field"><label>XS</label><input type="number"></div>
                            <div class="stock-field"><label>S</label><input type="number"></div>
                            <div class="stock-field"><label>M</label><input type="number"></div>
                            <div class="stock-field"><label>L</label><input type="number"></div>
                            <div class="stock-field"><label>XL</label><input type="number"></div>
                        </div>
                    </div>

                    <div class="input-group">
                        <label>Precio</label>
                        <input type="number" step="0.01" name="txtPrecio" placeholder="$ 0.00" required>
                    </div>
                </div>

                <div class="modal-full-width">
                    <div class="input-group">
                        <label>Descripción</label>
                        <textarea name="txtDescripcion" rows="4"></textarea>
                    </div>
                    
                    <input type="hidden" name="accion" value="Guardar">

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
        <div class="modal-bandana mini-box">
            <span class="close-modal">&times;</span>
            <h3 class="modal-title">Nuevo Estilo</h3>
            <div class="input-group">
                <input type="text" id="input-estilo-nombre" placeholder="Nombre del estilo...">
            </div>
            <button type="button" class="btn-upload btn-save-extra" style="width: 100%;" id="btn-guardar-estilo">
                Guardar Estilo
            </button>
        </div>
    </div>

    <div id="modal-nuevo-material" class="login-modal mini-overlay">
        <div class="modal-bandana mini-box">
            <span class="close-modal">&times;</span>
            <h3 class="modal-title">Nuevo Material</h3>
            <div class="input-group">
                <input type="text" id="input-material-nombre" placeholder="Nombre del material...">
            </div>
            <button type="button" class="btn-upload btn-save-extra" style="width: 100%;" id="btn-guardar-material">
                Guardar Material
            </button>
        </div>
    </div>

    <footer class="footer">
        <div class="footer-bottom">
            <p>© 2025 Peluditos con estilo – Todos los derechos reservados.</p>
        </div>
    </footer>
    
    <script src="js/auth.js"></script>
</body>
</html>