<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrador - Peluditos con Estilo</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/style.css">
</head>
<body class="admin-page">
    <header class="header">
        <div class="logo">
            <a href="index.jsp">
                <img src="${pageContext.request.contextPath}/Imagenes/logo verde nombre.png" alt="Peluditos con estilo">
            </a>
        </div>
        <div class="header-right">
            <nav class="nav">
                <a href="#">Inventario</a>
                <a href="#">Pedidos</a>
            </nav>
            <div class="auth-buttons">
                <button onclick="logout()" class="btn btn-header-yellow">Cerrar sesión</button>
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

            <button class="btn-add-bandana" onclick="openBandanaModal()">+ Agregar nueva bandana</button>
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
                    <tr>
                        <td>Galáctico</td>
                        <td>N-01</td>
                        <td>Estrellas</td>
                        <td><div class="img-placeholder-table"></div></td>
                        <td class="stock-status">15</td>
                        <td class="col-precio">$28.000</td>
                        <td class="actions-cell">
                            <button class="btn-action edit" onclick="openBandanaModal('N-01')">✏️</button>
                            <button class="btn-action delete">🗑️</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </section>
    </main>

    <div id="bandanaModal" class="login-modal" style="display: none;">
        <div class="login-box modal-bandana">
            <span class="close-modal" onclick="closeBandanaModal()">✕</span>
            <div class="modal-logo-container">
                <img src="${pageContext.request.contextPath}/Imagenes/logo verde nombre.png" alt="Logo Peluditos" class="modal-logo-img">
            </div>
            
            <h2 class="modal-title">Nueva bandana</h2>

            <form id="formBandana" class="modal-form-two-columns">
                <div class="modal-col-left">
                    <div class="image-upload-container">
                        <div class="image-preview-box" id="imagePreview">
                            <img src="" alt="Previsualización" id="previewImg" style="display: none; width: 100%; height: 100%; object-fit: cover; border-radius: 13px;">
                        </div>

                        <input type="file" id="fileInput" accept="image/*" style="display: none;" onchange="previewFile()">

                        <button type="button" class="btn-upload" onclick="document.getElementById('fileInput').click()">Cargar imagen</button>
                    </div>
                </div>

                <div class="modal-col-right">
                    <div class="input-group">
                        <label>Estilo</label>
                        <div class="style-select-row">
                            <select name="estilo" id="selectEstilo">
                                <option value="">Seleccionar estilo</option>
                                <option value="galactico">Galáctico</option>
                                <option value="urbano">Urbano</option>
                                <option value="clasico">Clásico</option>
                            </select>
                            <button type="button" class="btn-plus-style" id="btnAddStyle" onclick="mostrarCampoNuevoEstilo()">+</button>
                        </div>
                        <div id="newStyleContainer" style="display: none; margin-top: 10px;">
                            <input type="text" id="newStyleInput" name="nuevoEstilo" class="input-redondeado" placeholder="Nuevo estilo...">
                        </div>
                    </div>

                    <div class="input-group">
                        <label>Nombre</label>
                        <input type="text" name="nombre">
                    </div>

                    <div class="input-group">
                        <label>Id</label>
                        <input type="text" name="id" class="input-id-readonly" readonly placeholder="#001">
                    </div>

                    <div class="input-group">
                        <label>Material</label>
                        <div class="style-select-row">
                            <select name="material" id="selectMaterial">
                                <option value="">Seleccionar material</option>
                                <option value="algodon">Algodón</option>
                                <option value="lino">Lino</option>
                                <option value="poliester">Poliéster</option>
                            </select>
                            <button type="button" class="btn-plus-style" id="btnAddMaterial" onclick="mostrarCampoNuevoMaterial()">+</button>
                        </div>
                        <div id="newMaterialContainer" style="display: none; margin-top: 10px;">
                            <input type="text" id="newMaterialInput" name="nuevoMaterial" class="input-redondeado" placeholder="Nuevo material...">
                        </div>
                    </div>

                    <div class="input-group">
                        <label>Stock</label>
                        <div class="stock-inputs-row">
                            <div class="stock-field"><label>XS</label><input type="number" name="stockXS"></div>
                            <div class="stock-field"><label>S</label><input type="number" name="stockS"></div>
                            <div class="stock-field"><label>M</label><input type="number" name="stockM"></div>
                            <div class="stock-field"><label>L</label><input type="number" name="stockL"></div>
                            <div class="stock-field"><label>XL</label><input type="number" name="stockXL"></div>
                        </div>
                    </div>

                    <div class="input-group">
                        <label>Precio</label>
                        <input type="text" name="precio" placeholder="$">
                    </div>
                </div>

                <div class="modal-full-width">
                    <div class="input-group">
                        <label>Descripción</label>
                        <textarea name="descripcion" rows="4"></textarea>
                    </div>
                    
                    <div class="modal-actions-footer">
                        <button type="submit" class="btn-save-changes">Guardar cambios</button>
                    </div>
                </div>
            </form>
            
            <img src="${pageContext.request.contextPath}/Imagenes/huella decorativa.png" class="paw-decor decor-left">
            <img src="${pageContext.request.contextPath}/Imagenes/huella decorativa.png" class="paw-decor decor-right">
        </div>
    </div>

    <footer class="footer">
        <div class="footer-bottom">
            <p>© 2025 Peluditos con estilo – Todos los derechos reservados.</p>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/JS/auth.js"></script>
</body>
</html>