/* ==========================================
    INICIALIZACIÓN GLOBAL (EVENT LISTENERS)
   ========================================== */

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

    // --- 3. Botones de Guardar en Mini Modales (AJUSTADO) ---
    const btnSaveEstilo = document.getElementById('btn-guardar-estilo');
    const btnSaveMaterial = document.getElementById('btn-guardar-material');

    if (btnSaveEstilo) {
        // Cambiamos a 'submit' para que el formulario viaje al servidor
        btnSaveEstilo.addEventListener('click', (e) => {
            if (!validarAntesDeEnviar('estilo')) {
                e.preventDefault(); // Detiene el envío si el campo está vacío
            }
        });
    }
    if (btnSaveMaterial) {
        btnSaveMaterial.addEventListener('click', (e) => {
            if (!validarAntesDeEnviar('material')) {
                e.preventDefault();
            }
        });
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

    // --- 6. Previsualización de Imagen ---
    const fileInput = document.getElementById('file-input');
    const previewContainer = document.getElementById('inner-preview');

    if (fileInput && previewContainer) {
        fileInput.onchange = function () {
            const [file] = this.files;
            if (file) {
                const url = URL.createObjectURL(file);
                previewContainer.innerHTML = `<img src="${url}" style="width: 100%; height: 100%; object-fit: cover; border-radius: 10px;">`;
            }
        };
    }
}

document.addEventListener("DOMContentLoaded", inicializarEventos);

window.onload = function() {
    const btn = document.getElementById('btn-nueva-bandana');
    if (btn && !btn.onclick) {
        inicializarEventos();
    }
};

/* ==========================================
    MODALES Y NAVEGACIÓN
   ========================================== */

function openLogin() {
    const registerModal = document.getElementById("registerModal");
    if (registerModal) registerModal.style.display = "none";
    const modal = document.getElementById("loginModal");
    if (modal) modal.style.display = "flex";
}

function openRegister() {
    const loginModal = document.getElementById("loginModal");
    if (loginModal) loginModal.style.display = "none";
    const modal = document.getElementById("registerModal");
    if (modal) modal.style.display = "flex";
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

function openBandanaModal() {
    const modal = document.getElementById("bandanaModal");
    if (modal) modal.style.display = "flex";
}

/* ==========================================
    VALIDACIÓN DE DATOS EXTRAS (ESTILO/MATERIAL)
   ========================================== */

// Nueva función que solo valida. El envío lo hace el botón 'submit' del HTML
function validarAntesDeEnviar(tipo) {
    const inputId = tipo === 'estilo' ? 'input-estilo-nombre' : 'input-material-nombre';
    const inputElement = document.getElementById(inputId);
    
    if (!inputElement) return false;

    const nombre = inputElement.value.trim();
    if (nombre === "") {
        // Usamos SweetAlert para que no se vea feo
        Swal.fire({
            icon: 'warning',
            title: 'Campo vacío',
            text: 'Por favor, ingresa un nombre para el ' + tipo,
            confirmButtonColor: '#1a4731'
        });
        return false;
    }

    console.log("Enviando nuevo " + tipo + " al servidor...");
    return true; // Si retorna true, el formulario se envía al ControladorPrincipal
}

/* ==========================================
    MENSAJES DE ERROR Y LOGOUT
   ========================================== */

function logout() {
    localStorage.removeItem("isLogged");
    window.location.href = "index.html";
}

window.addEventListener('click', function(event) {
    if (event.target.classList.contains('login-modal')) {
        event.target.style.display = "none";
    }
});