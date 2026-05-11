/* ==========================================
    INICIALIZACIÓN GLOBAL (EVENT LISTENERS)
   ========================================== */

// Usamos una función que se asegura de cargar todo antes de buscar los IDs
function inicializarEventos() {
    console.log("Inicializando scripts de Peluditos con Estilo...");

    // --- 1. Apertura de Modal Principal (Bandana) ---
    const btnOpenMain = document.getElementById('btn-nueva-bandana');
    const modalBandana = document.getElementById("bandanaModal");

    if (btnOpenMain && modalBandana) {
        btnOpenMain.onclick = function(e) {
            e.preventDefault(); 
            console.log("Abriendo modal de nueva bandana...");
            modalBandana.style.display = "flex";
        };
    }

    // --- 2. Apertura de Mini Modales (Estilo/Material) ---
    const btnNewStyle = document.getElementById('btn-add-estilo');
    const btnNewMaterial = document.getElementById('btn-add-material');

    if (btnNewStyle) {
        btnNewStyle.addEventListener('click', () => abrirMiniModal('modal-nuevo-estilo'));
    }
    if (btnNewMaterial) {
        btnNewMaterial.addEventListener('click', () => abrirMiniModal('modal-nuevo-material'));
    }

    // --- 3. Botones de Guardar en Mini Modales ---
    const btnSaveEstilo = document.getElementById('btn-guardar-estilo');
    const btnSaveMaterial = document.getElementById('btn-guardar-material');

    if (btnSaveEstilo) {
        btnSaveEstilo.addEventListener('click', () => guardarDatoExtra('estilo'));
    }
    if (btnSaveMaterial) {
        btnSaveMaterial.addEventListener('click', () => guardarDatoExtra('material'));
    }

    // --- 4. Cierre Genérico ---
    document.querySelectorAll('.close-modal').forEach(boton => {
        boton.addEventListener('click', function() {
            const modal = this.closest('.login-modal');
            if (modal) modal.style.display = 'none';
        });
    });

    // --- 5. Botón de Logout ---
    const btnLogout = document.getElementById('btnLogout');
    if (btnLogout) {
        btnLogout.addEventListener('click', logout);
    }

    // --- 6. Previsualización de Imagen (LO NUEVO) ---
    const fileInput = document.getElementById('file-input');
    const previewContainer = document.getElementById('inner-preview');

    if (fileInput && previewContainer) {
        fileInput.onchange = function () {
            const [file] = this.files;
            if (file) {
                const url = URL.createObjectURL(file);
                // Reemplazamos la huella por la foto seleccionada
                previewContainer.innerHTML = `<img src="${url}" style="width: 100%; height: 100%; object-fit: cover; border-radius: 10px;">`;
            }
        };
    }
}

// Ejecutar al cargar el DOM
document.addEventListener("DOMContentLoaded", inicializarEventos);

// REFUERZO: Si por alguna razón el DOMContentLoaded falla, intentamos una vez más al cargar la ventana
window.onload = function() {
    if (!document.getElementById('btn-nueva-bandana').onclick) {
        inicializarEventos();
    }
};

/* ==========================================
    MODALES DE NAVEGACIÓN (LOGIN / REGISTRO)
   ========================================== */

function openLogin() {
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

    localStorage.setItem("isLogged", "true");
    closeLogin();
    window.location.href = "disena-tu-bandana.html"; 
}

/* ==========================================
    MODALES DE ADMINISTRACIÓN (NUEVA BANDANA)
   ========================================== */

function openBandanaModal() {
    const modal = document.getElementById("bandanaModal");
    if (modal) modal.style.display = "flex";
}

function closeBandanaModal() {
    const modal = document.getElementById("bandanaModal");
    if (modal) modal.style.display = "none";
}

function abrirMiniModal(id) {
    const modal = document.getElementById(id);
    if (modal) {
        modal.style.display = "flex";
        modal.style.zIndex = "3000"; 
    }
}

function cerrarMiniModal(id) {
    const modal = document.getElementById(id);
    if (modal) modal.style.display = "none";
}

function guardarDatoExtra(tipo) {
    const inputId = tipo === 'estilo' ? 'input-estilo-nombre' : 'input-material-nombre';
    const inputElement = document.getElementById(inputId);
    
    if (!inputElement) return;

    const nombre = inputElement.value.trim();
    if (nombre === "") {
        alert("Por favor, ingresa un nombre para el " + tipo);
        return;
    }

    console.log("Guardando nuevo " + tipo + ": " + nombre);
    alert(tipo.charAt(0).toUpperCase() + tipo.slice(1) + " guardado con éxito.");
    
    cerrarMiniModal('modal-nuevo-' + tipo);
    inputElement.value = ""; 
}

/* ==========================================
    MENSAJES DE ERROR Y UTILIDADES
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

function logout() {
    localStorage.removeItem("isLogged");
    window.location.href = "index.html";
}

/* ==========================================
    CONTROL DE CIERRE GLOBAL (CLICK FUERA)
   ========================================== */

window.addEventListener('click', function(event) {
    if (event.target.classList.contains('login-modal')) {
        event.target.style.display = "none";
    }
});