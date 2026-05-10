<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Peluditos con estilo</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body class="logged-user">
    <header class="header">
        <div class="logo">
            <a href="index.html">
                <img src="Imagenes/logo verde nombre.png" alt="Peluditos con estilo">
            </a>
        </div>

        <div class="header-right">
            <nav class="nav">
                <a href="index.html">Inicio</a>
                <a href="index.html#catalogo">CatÃ¡logo</a>
                <a href="#" onclick="openOrders()" class="nav-orders">Mis pedidos</a>
                <a href="#">Nosotros</a>
                <a href="#contacto">Contacto</a>
            </nav>

            <div class="auth-buttons">
                <span class="user-info">SesiÃ³n activa ð¾</span>
                <button onclick="logout()" class="btn btn-header-green">Cerrar sesiÃ³n</button>
            </div>
        </div>
    </header>

    <main class="design-page">
        <h1 class="page-title">DiseÃ±a tu banadana</h1>

        <section class="design-container">
            <div class="options-panel">
                <section class="option-group">
                    <h3>Talla de la bandana</h3> 
                    <p class="help-text">Â¿No sabes tu talla? <a href="#" onclick="openSizeGuide()">Ver guÃ­a</a></p>
                    <div class="sizes">
                        <button class="size-btn" onclick="selectSize(this, 'S')">S</button>
                        <button class="size-btn active" onclick="selectSize(this, 'M')">M</button>
                        <button class="size-btn" onclick="selectSize(this, 'L')">L</button>
                        <button class="size-btn" onclick="selectSize(this, 'XL')">XL</button>
                    </div>
                </section>

                <section class="option-group">
                    <h3>Color base</h3>
                    <p class="sub-title">Color plano</p>
                    <div class="slider">
                        <button class="arrow">â¹</button>
                        <div class="slider-track">
                            <span class="color color-1"></span>
                            <span class="color color-2"></span>
                            <span class="color color-3"></span>
                            <span class="color color-4"></span>
                            <span class="color color-5"></span>
                            <span class="color color-6"></span>
                            <span class="color color-7"></span>
                            <span class="color color-8"></span>
                            <span class="color color-9"></span>
                            <span class="color color-10"></span>
                        </div>
                        <button class="arrow">âº</button>
                    </div>

                    <p class="sub-title">Color con patrÃ³n</p>
                    <div class="slider">
                        <button class="arrow">â¹</button>
                        <div class="slider-track">
                            <img src="patrones/patron1.png" class="pattern">
                            <img src="patrones/patron2.png" class="pattern">
                            <img src="patrones/patron3.png" class="pattern">
                            <img src="patrones/patron4.png" class="pattern">
                            <img src="patrones/patron5.png" class="pattern">
                        </div>
                        <button class="arrow">âº</button>
                    </div>
                </section>

                <section class="option-group">
                    <h3>Stickers</h3>
                    <div class="slider">
                        <button class="arrow">â¹</button>
                        <div class="slider-track">
                            <img src="stickers/s1.png" class="sticker">
                            <img src="stickers/s2.png" class="sticker">
                            <img src="stickers/s3.png" class="sticker">
                            <img src="stickers/s4.png" class="sticker">
                            <img src="stickers/s5.png" class="sticker">
                        </div>
                        <button class="arrow">âº</button>
                    </div>
                </section>

                <section class="option-group">
                    <h3>Frase</h3>
                    <input type="text" placeholder="Nombre de tu peludo">
                </section>

                <section class="option-group">
                    <h3>TipografÃ­a</h3>
                    <input type="text" value="Poppins" disabled>
                </section>
            </div>

            <div class="preview-panel">
                <div class="preview-box">
                    <p>PrevisualizaciÃ³n de la bandana</p>
                </div>
                <button class="btn-primary" onclick="openPaymentGuide()">Continuar compra</button>
            </div>
        </section>
    </main>

    <footer class="footer" id="contacto">
        <div class="footer-container">
            <div class="footer-col footer-brand">
                <img src="Imagenes/logo blanco.png" alt="Peluditos con estilo" class="footer-logo">
                <h3>Peluditos con estilo</h3>
            </div>

            <div class="footer-col">
                <h4>Enlaces Ãºtiles</h4>
                <ul>
                    <li><a href="index.html">Inicio</a></li>
                    <li><a href="index.html#catalogo">CatÃ¡logo</a></li>
                    <li><a href="#" onclick="openOrders()">Mis pedidos</a></li>
                    <li><a href="#">Nosotros</a></li>
                    <li><a href="#contacto">Contacto</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>InformaciÃ³n</h4>
                <ul>
                    <li><a href="#">PolÃ­tica de privacidad</a></li>
                    <li><a href="#">TÃ©rminos y condiciones</a></li>
                    <li><a href="#">Preguntas frecuentes</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>SÃ­guenos</h4>
                <div class="footer-socials">
                    <a href="#">ð¾</a>
                    <a href="#">ð·</a>
                    <a href="#">ð¬</a>
                </div>
            </div>
        </div>
        <div class="footer-bottom">
            <p>Â© 2025 Peluditos con estilo â Todos los derechos reservados.</p>
        </div>
    </footer>

    <div id="sizeGuideModal" class="login-modal">
        <div class="login-box modal-guia">
            <span class="close-modal" onclick="closeSizeGuide()">â</span>
            
            <div class="modal-error-logo">
                <img src="Imagenes/logo verde nombre.png" alt="Logo">
            </div>
            <h2 class="modal-title">Guia de tallas para bandana</h2>

            <div class="guia-img-container">
                <img src="Imagenes/medida cuello.png" alt="CÃ³mo medir" class="img-guia">
                <p class="modal-note">Mide el cuello de tu peludito dejando espacio para dos dedos</p>
            </div>

            <div class="tabla-tallas">
                <div class="tabla-header">
                    <span>Contorno cuello</span>
                    <span>Raza referencia</span>
                    <span>Talla</span>
                </div>
                <div class="tabla-body">
                    <div class="tabla-fila"><span>20 - 26 cm</span><span>Chihuahua, Gatos, Yorkie</span><span class="talla-badge">XS</span></div>
                    <div class="tabla-fila"><span>27 - 35 cm</span><span>Shih Tzu, Pomerania</span><span class="talla-badge">S</span></div>
                    <div class="tabla-fila"><span>36 - 45 cm</span><span>Beagle, Cocker Spaniel</span><span class="talla-badge">M</span></div>
                    <div class="tabla-fila"><span>46 - 55 cm</span><span>Border Collie, Boxer, Labrador</span><span class="talla-badge">L</span></div>
                    <div class="tabla-fila"><span>56 - 65 cm</span><span>Golden Retriever</span><span class="talla-badge">XL</span></div>
                </div>
            </div>

            <p class="modal-note">Ahora que conoces la talla de la bandana de tu peludo</p>
            <button class="btn-primary" onclick="closeSizeGuide()">Continuar diseÃ±o</button>
        </div>
    </div>

    <div id="paymentGuideModal" class="login-modal">
        <div class="login-box modal-guia">
            <span class="close-modal" onclick="closePaymentGuide()">â</span>
            
            <div class="modal-error-logo">
                <img src="Imagenes/logo verde nombre.png" alt="Logo Peluditos con estilo">
            </div>
            <h2 class="modal-title">Pagar tu pedido</h2>
            <h3 class="order-number">P-023</h3>

            <p class="modal-message">
                Realiza el pago de tu accesorio a travÃ©s de Nequi y adjunta el comprobante para continuar el proceso. 
                Luego podrÃ¡s ver el estado de tu pedido en <span class="highlight-text">'Mis pedidos'</span>.
            </p>

            <div class="payment-details">
                <div class="nequi-info">
                    <img src="Imagenes/nequi.jpg" alt="Nequi" class="nequi-logo">
                </div>
                <div class="account-info">
                    <p><strong>Celular:</strong> 321 913 6057</p>
                    <p><strong>Estrellita Quintero</strong></p>
                    <p><strong>Valor total:</strong> $ xxxxxxx</p>
                </div>
            </div>

            <div class="modal-actions">
                <button class="btn-primary" onclick="confirmPayment()">Confirmar y enviar pago</button>
                <p class="security-note">"Toda la informaciÃ³n es cifrada y segura. Tu pedido iniciarÃ¡ fabricaciÃ³n despuÃ©s de verificar el pago."</p>
                <button class="btn-header-outline" onclick="closePaymentGuide()">Cancelar</button>
            </div>
        </div>
    </div>

<div id="ordersModal" class="login-modal">
    <div class="login-box modal-pedidos">
        <span class="close-modal" onclick="closeOrders()">â</span>
        
        <div class="modal-error-logo">
            <img src="Imagenes/logo verde nombre.png" alt="Logo">
        </div>
        <h2 class="modal-title">Mis pedidos</h2>

        <div class="orders-container">
            <div class="order-card">
                <div class="order-info">
                    <div class="info-group">
                        <label>Id pedido</label>
                        <span>P 023</span>
                    </div>
                    <div class="info-group">
                        <label>DiseÃ±o</label>
                        <span>Verde bosque v 532</span>
                    </div>
                    <div class="info-group">
                        <label>referencia</label>
                        <div class="ref-placeholder"></div>
                    </div>
                    <div class="info-group">
                        <label>Estado pedido</label>
                        <span class="status-pending">Pago pendiente</span>
                    </div>
                    <div class="info-group">
                        <label>Estado del pago</label>
                        <button class="btn-adjuntar" onclick="openPaymentGuide()">Adjuntar pago</button>
                    </div>
                </div>
            </div>

            <div class="order-card">
                <div class="order-info">
                    <div class="info-group">
                        <label>Id pedido</label>
                        <span>P 023</span>
                    </div>
                    <div class="info-group">
                        <label>DiseÃ±o</label>
                        <span>propio cliente c 234</span>
                    </div>
                    <div class="info-group">
                        <label>referencia</label>
                        <div class="ref-placeholder"></div>
                    </div>
                    <div class="info-group">
                        <label>Estado pedido</label>
                        <span class="status-pending">Pago pendiente</span>
                    </div>
                    <div class="info-group">
                        <label>Estado del pago</label>
                        <button class="btn-adjuntar" onclick="openPaymentGuide()">Adjuntar pago</button>
                    </div>
                </div>
            </div>
        </div>

        <p class="modal-note-small">
            "Puedes adjuntar el pago de tus pedidos pendientes directamente desde cada tarjeta."<br>
            "Tus diseÃ±os se empezarÃ¡n a fabricar una vez verifiquemos el pago."
        </p>
        
        <button class="btn-primary" onclick="closeOrders()">Continuar nuevo diseÃ±o</button>
    </div>
</div>

    <script src="js/auth.js"></script>
    <script>
        if (localStorage.getItem("isLogged") !== "true") {
            window.location.href = "index.html";
        }

        function selectSize(element, size) {
            const buttons = document.querySelectorAll('.size-btn');
            buttons.forEach(btn => btn.classList.remove('active'));
            element.classList.add('active');
        }
    </script>
</body>
</html>