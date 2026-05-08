<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Peluditos con estilo</title>
    <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
    <header class="header">
        <div class="logo">
            <a href="index.html">
                <img src="Imagenes/logo verde nombre.png" alt="Peluditos con estilo">
            </a>
        </div>

        <div class="header-right">
            <nav class="nav">
                <a href="index.html">Inicio</a>
                <a href="#catalogo">Catálogo</a> 
                <a href="#" onclick="openLogin()">Diseña tu accesorio</a>
                <a href="#">Nosotros</a>
                <a href="#contacto">Contacto</a>
            </nav>

            <div class="auth-buttons">
                <button onclick="openLogin()" class="btn btn-header-outline">Iniciar sesión</button>
                <button onclick="openRegister()" class="btn btn-header-green">Registrarse</button>
            </div>
        </div>
    </header>

    <section class="hero">
        <img src="Imagenes/Perro.png" class="hero-img left" alt="Perro">

        <div class="hero-text">
            <h1> Collares, bandanas y accesorios personalizados para tu mascota.</h1>
            <p> Tu eliges los colores, nosotros creamos la magia para tu peludito</p>
            <a href="#" class="btn btn-hero" onclick="openLogin()">Diseñar mi propio accesorio</a>
        </div>

        <img src="Imagenes/Gato.png" class="hero-img right" alt="Gato">
    </section>

    <section class="catalogo" id="catalogo">
        <h2>Nuestras bandanas</h2>
        <div class="grid-collares">
            <div class="card">
                <div class="img-placeholder"></div>
                <p>Verde selva</p>
                <p>$ xxxxxxx</p>
            </div>
            <div class="card">
                <div class="img-placeholder"></div>
                <p>Verde selva</p>
                <p>$ xxxxxxx</p>
            </div>
            <div class="card">
                <div class="img-placeholder"></div>
                <p>Verde selva</p>
                <p>$ xxxxxxx</p>
            </div>
            <div class="card">
                <div class="img-placeholder"></div>
                <p>Verde selva</p>
                <p>$ xxxxxxx</p>
            </div>
            <div class="card">
                <div class="img-placeholder"></div>
                <p>Verde selva</p>
                <p>$ xxxxxxx</p>
            </div>
            <div class="card">
                <div class="img-placeholder"></div>
                <p>Verde selva</p>
                <p>$ xxxxxxx</p>
            </div>
        </div>

        <a href="#" class="btn btn-catalogo">Ver más</a>
    </section>

    <footer class="footer" id="contacto">
        <div class="footer-container">
            <div class="footer-col footer-brand">
                <img src="Imagenes/logo blanco.png" alt="Peluditos con estilo" class="footer-logo">
                <h3>Peluditos con estilo</h3>
                <p>Diseños Únicos para tus mejores amigos.</p>
            </div>

            <div class="footer-col">
                <h4>Enlaces Útiles</h4>
                <ul>
                    <li><a href="index.html">Inicio</a></li>
                    <li><a href="#catalogo">Catálogo</a></li>
                    <li><a href="#" onclick="openLogin()">Diseñaa tu accesorio</a></li>
                    <li><a href="#">Nosotros</a></li>
                    <li><a href="#contacto">Contacto</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>Información</h4>
                <ul>
                    <li><a href="#">Polí­tica de privacidad</a></li>
                    <li><a href="#">Términos y condiciones</a></li>
                    <li><a href="#">Preguntas frecuentes</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h4>Sí­guenos</h4>
                <div class="footer-socials">
                    <a href="#">🐾</a>
                    <a href="#">📷</a>
                    <a href="#">💬</a>
                </div>
            </div>
        </div>

        <div class="footer-bottom">
            <p> © 2025 Peluditos con estilo - Todos los derechos reservados.</p>
        </div>
    </footer>

    <div id="loginModal" class="login-modal">
        <div class="login-box">
            <span class="close-modal" onclick="closeLogin()">✖</span>
            <img src="Imagenes/logo verde.png" class="modal-logo">
            <h2>Iniciar sesión</h2>
            <p class="modal-subtitle">Accede a tu cuenta para personalizar accesorios para tu peludito.</p>

            <!-- ENVOLVEMOS LOS INPUTS EN UN FORMULARIO -->
            <form action="${pageContext.request.contextPath}/Controlador" method="POST">
                <label>Correo electrónico</label>
                <input type="email" name="txtCorreo" id="loginEmail" placeholder="ejemplo@correo.com" required>

                <label>Contraseña</label>
                <!-- Cambiamos txtPassword por txtClave para que coincida con el Servlet -->
                <input type="password" name="txtClave" id="loginPassword" placeholder="********" required>

                <a href="#" class="forgot">¿Olvidaste tu contraseña?</a>

                <button type="submit" name="accion" value="Ingresar" class="btn-primary">Iniciar sesión</button>
            </form> 

            <p class="switch">¿No tienes cuenta? <span onclick="openRegister()">Regístrate</span></p>
        </div>
    </div>

    <div id="registerModal" class="login-modal">
        <div class="login-box">
            <span class="close-modal" onclick="closeRegister()">✖</span>
            <img src="Imagenes/logo verde.png" class="modal-logo">
            <h2>Crear cuenta</h2>
            <p class="modal-subtitle">Crea tu cuenta para diseñar accesorios únicos para tu peludito.</p>
            <label>Nombre completo</label>
            <input type="text" placeholder="Ej. Marí­a Gómez">
            <label>Correo electrónico</label>
            <input type="email" placeholder="ejemplo@correo.com">
            <label>Contraseña</label>
            <input type="password" placeholder="********">
            <label>Confirmar contraseña</label>
            <input type="password" placeholder="********">
            <button class="btn-primary">Crear cuenta</button>
            <p class="switch">¿Ya tienes cuenta? <span onclick="openLogin()">Iniciar sesión</span></p>
        </div>
    </div>

    <div class="modal-error" id="errorModal">
        <div class="modal-error-content">
            <button class="modal-close" onclick="closeErrorModal()">✖</button>
            <div class="modal-error-logo">
                <img src="Imagenes/logo verde.png" alt="Peluditos con estilo">
            </div>
            <h2 class="modal-title">Revisa tu información</h2>
            <div class="modal-icon">⚠️</div>
            <p class="modal-message" id="errorMessage">El correo ingresado no tiene un formato válido</p>
            <button class="modal-btn" onclick="closeErrorModal()">Entendido</button>
        </div>
    </div>          

    <script src="JS/auth.js"></script>

    </body>
</html>