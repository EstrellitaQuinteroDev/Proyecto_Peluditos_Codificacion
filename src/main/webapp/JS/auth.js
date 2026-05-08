/* ==========================================
    MODALES DE NAVEGACIÓN (LOGIN / REGISTRO)
   ========================================== */

function openLogin() {
    // Cerramos registro por si está abierto para que no se encimen
    const registerModal = document.getElementById("registerModal");
    if (registerModal) registerModal.style.display = "none";

    const modal = document.getElementById("loginModal");
    if (modal) modal.style.display = "flex";
}

function closeLogin() {
    const modal = document.getElementById("loginModal");
    if (modal) modal.style.display = "none";
}

function openRegister() {
    // Cerramos login por si está abierto
    const loginModal = document.getElementById("loginModal");
    if (loginModal) loginModal.style.display = "none";

    const modal = document.getElementById("registerModal");
    if (modal) modal.style.display = "flex";
}

function closeRegister() {
    const modal = document.getElementById("registerModal");
    if (modal) modal.style.display = "none";
}

/* ==========================================
    VALIDACIONES Y REDIRECCIÓN
   ========================================== */

function login() {
    const emailInput = document.getElementById("loginEmail");
    const passwordInput = document.getElementById("loginPassword");

    // Si no existen los inputs (seguridad), salimos
    if (!emailInput || !passwordInput) return;

    const email = emailInput.value.trim();
    const password = passwordInput.value.trim();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!emailRegex.test(email)) {
        openErrorModal("Por favor ingresa un correo válido.");
        return;
    }

    if (password.length < 6) {
        openErrorModal("La contraseña debe tener al menos 6 caracteres.");
        return;
    }

    // Login exitoso: Guardamos estado y redirigimos
    localStorage.setItem("isLogged", "true");
    closeLogin();
    
    // REDIRECCIÓN EXACTA (Ajustado a JSP para tu servidor)
    window.location.href = "disena-tu-bandana.jsp"; 
}

/* ==========================================
    MODALES DE LA PÁGINA DE DISEÑO
   ========================================== */

function openSizeGuide() {
    const modal = document.getElementById("sizeGuideModal");
    if (modal) modal.style.display = "flex";
}

function closeSizeGuide() {
    const modal = document.getElementById("sizeGuideModal");
    if (modal) modal.style.display = "none";
}

function openPaymentGuide() {
    const modal = document.getElementById("paymentGuideModal");
    if (modal) modal.style.display = "flex";
}

function closePaymentGuide() {
    const modal = document.getElementById("paymentGuideModal");
    if (modal) modal.style.display = "none";
}

function openOrders() {
    const modal = document.getElementById("ordersModal");
    if (modal) modal.style.display = "flex";
}

function closeOrders() {
    const modal = document.getElementById("ordersModal");
    if (modal) modal.style.display = "none";
}

/* ==========================================
    MENSAJES DE ERROR
   ========================================== */

function openErrorModal(message) {
    const errorText = document.getElementById("errorMessage");
    const modal = document.getElementById("errorModal");
    if (errorText && modal) {
        errorText.textContent = message;
        modal.style.display = "flex";
    }
}

function closeErrorModal() {
    const modal = document.getElementById("errorModal");
    if (modal) modal.style.display = "none";
}

/* ==========================================
    CERRAR SESIÓN
   ========================================== */

function logout() {
    // Borramos el permiso de la memoria del navegador
    localStorage.removeItem("isLogged");
    // Volvemos al inicio (Ajustado a JSP)
    window.location.href = "index.jsp";
}

// Función para simular el envío del pago
function confirmPayment() {
    alert("¡Gracias! Tu comprobante está siendo verificado. Podrás ver el estado en 'Mis pedidos' pronto.");
    closePaymentGuide();
}

/* ==========================================================================
    ADICIÓN: MODALES DEL PANEL ADMINISTRATIVO Y LÓGICA DE NUEVO ESTILO
   ========================================================================== */

// Abre el modal para agregar o editar una bandana
function openBandanaModal(id = null) {
    const modal = document.getElementById("bandanaModal");
    if (modal) {
        modal.style.display = "flex";
        if(id) {
            console.log("Cargando datos de la bandana ID: " + id);
            // Aquí iría la lógica para llenar el formulario si es edición
        }
    }
}

// Cierra el modal de la bandana
function closeBandanaModal() {
    const modal = document.getElementById("bandanaModal");
    if (modal) {
        modal.style.display = "none";
        // Limpiamos los campos de nuevo estilo y material
        document.getElementById("newStyleContainer").style.display = "none";
        document.getElementById("newMaterialContainer").style.display = "none";
        
        // Opcional: limpiar los inputs
        document.getElementById("newStyleInput").value = "";
        document.getElementById("newMaterialInput").value = "";
    }
}

// Función para mostrar/ocultar el campo redondeado del nuevo estilo
function mostrarCampoNuevoEstilo() {
    const contenedor = document.getElementById("newStyleContainer");
    const input = document.getElementById("newStyleInput");
    
    if (contenedor) {
        if (contenedor.style.display === "none" || contenedor.style.display === "") {
            contenedor.style.display = "block";
            if (input) input.focus();
        } else {
            contenedor.style.display = "none";
        }
    }
}

function mostrarCampoNuevoMaterial() {
    const contenedor = document.getElementById("newMaterialContainer");
    const input = document.getElementById("newMaterialInput");
    
    if (contenedor) {
        if (contenedor.style.display === "none" || contenedor.style.display === "") {
            contenedor.style.display = "block";
            if (input) input.focus();
        } else {
            contenedor.style.display = "none";
        }
    }
}

/* ==========================================
    CIERRE GLOBAL (Hacer clic fuera del modal)
   ========================================== */
window.onclick = function(event) {
    // Lista de todos tus modales
    const modals = [
        "loginModal", "registerModal", "sizeGuideModal", 
        "paymentGuideModal", "ordersModal", "errorModal", "bandanaModal"
    ];

    modals.forEach(id => {
        const modal = document.getElementById(id);
        // Usamos === para comparación estricta (Línea 189)
        if (modal && event.target === modal) {
            modal.style.display = "none";
        }
    });
};