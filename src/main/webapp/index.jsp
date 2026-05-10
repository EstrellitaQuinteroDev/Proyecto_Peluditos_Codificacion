<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Peluditos con estilo</title>
    <link rel="stylesheet" href="css/style.css">
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
                <a href="#catalogo">CatÃ¡logo</a> 
                <a href="#" onclick="openLogin()">DiseÃ±a tu accesorio</a>
                <a href="#">Nosotros</a>
                <a href="#contacto">Contacto</a>
            </nav>

            <div class="auth-buttons">
                <button onclick="openLogin()" class="btn btn-header-outline">Iniciar sesiÃ³n</button>
                <button onclick="openRegister()" class="btn btn-header-green">Registrarse</button>
            </div>
        </div>
    </header>

    <section class="hero">
        <img src="Imagenes/Perro.png" class="hero-img left" alt="Perro">

        <div class="hero-text">
            <h1> Collares, bandanas y accesorios personalizados para tu mascota.</h1>
            <p> Tu eliges los colores, nosotros creamos la magia para tu peludito</p>
            <a href="#" class="btn btn-hero" onclick="openLogin()">DiseÃ±ar mi propio accesorio</a>
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

        <a href="#" class="btn btn-catalogo">Ver mÃ¡s</a>
    </section>

    <footer class="footer" id="contacto">
        <div class="footer-container">
            <div class="footer-col footer-brand">
                <img src="Imagenes/logo blanco.png" alt="Peluditos con estilo" class="footer-logo">
                <h3>Peluditos con estilo</h3>
                <p>DiseÃ±os Ãºnicos para tus mejores amigos.</p>
            </div>

            <div class="footer-col">
                <h4>Enlaces Ãºtiles</h4>
                <ul>
                    <li><a href="index.html">Inicio</a></li>
                    <li><a href="#catalogo">CatÃ¡logo</a></li>
                    <li><a href="#" onclick="openLogin()">DiseÃ±a tu accesorio</a></li>
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

 <div id="loginModal" class="login-modal">
    <div class="login-box">
        <span class="close-modal" onclick="closeLogin()">✖</span>
        <img src="Imagenes/logo verde.png" class="modal-logo">
        <h2>Iniciar sesión</h2>
        <p class="modal-subtitle">Accede a tu cuenta para personalizar accesorios para tu peludito.</p>
        
        <form action="ControladorPrincipal" method="POST">
            <label>Correo electrónico</label>
            <input type="email" name="txtCorreo" id="loginEmail" placeholder="ejemplo@correo.com" required>
            
            <label>Contraseña</label>
            <input type="password" name="txtClave" id="loginPassword" placeholder="********" required>
            
            <a href="#" class="forgot">¿Olvidaste tu contraseña?</a>
            
            <input type="hidden" name="accion" value="Ingresar">
            
            <button type="submit" class="btn-primary">Iniciar sesión</button>
        </form>

        <p class="switch">¿No tienes cuenta? <span onclick="openRegister()">Regístrate</span></p>
    </div>
</div>

    <div id="registerModal" class="login-modal">
        <div class="login-box">
            <span class="close-modal" onclick="closeRegister()">â</span>
            <img src="Imagenes/logo verde.png" class="modal-logo">
            <h2>Crear cuenta</h2>
            <p class="modal-subtitle">Crea tu cuenta para diseÃ±ar accesorios Ãºnicos para tu peludito.</p>
            <label>Nombre completo</label>
            <input type="text" placeholder="Ej. MarÃ­a GÃ³mez">
            <label>Correo electrÃ³nico</label>
            <input type="email" placeholder="ejemplo@correo.com">
            <label>ContraseÃ±a</label>
            <input type="password" placeholder="********">
            <label>Confirmar contraseÃ±a</label>
            <input type="password" placeholder="********">
            <button class="btn-primary">Crear cuenta</button>
            <p class="switch">Â¿Ya tienes cuenta? <span onclick="openLogin()">Iniciar sesiÃ³n</span></p>
        </div>
    </div>

    <div class="modal-error" id="errorModal">
        <div class="modal-error-content">
            <button class="modal-close" onclick="closeErrorModal()">â</button>
            <div class="modal-error-logo">
                <img src="Imagenes/logo verde.png" alt="Peluditos con estilo">
            </div>
            <h2 class="modal-title">Revisa tu informaciÃ³n</h2>
            <div class="modal-icon">â ï¸</div>
            <p class="modal-message" id="errorMessage">El correo ingresado no tiene un formato vÃ¡lido</p>
            <button class="modal-btn" onclick="closeErrorModal()">Entendido</button>
        </div>
    </div>          

    <script src="js/auth.js"></script>

    </body>
</html>