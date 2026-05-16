/* ==========================================
    1. INICIALIZACIÓN GLOBAL (EVENT LISTENERS)
   ========================================== */

function inicializarEventos() {
    console.log("Inicializando scripts de Peluditos con Estilo...");

    // --- MODAL DE LOGIN (Página Principal) ---
    // Agregamos esto para solucionar el error "openLogin is not defined"
    const btnLoginModal = document.getElementById('btnIniciarSesion');
    const modalLogin = document.getElementById('loginModal'); 

    if (btnLoginModal && modalLogin) {
        btnLoginModal.onclick = function(e) {
            e.preventDefault();
            modalLogin.style.display = 'flex';
        };
    }

    // --- Apertura de Modal Principal (Panel Administrador - Bandana) ---
    const btnOpenMain = document.getElementById('btn-nueva-bandana');
    if (btnOpenMain) {
        btnOpenMain.onclick = function(e) {
            e.preventDefault(); 
            openBandanaModal();
        };
    }

    // --- SISTEMA DE FILTROS ---
    const inputSearch = document.getElementById('filter-search');
    const selectStyle = document.getElementById('filter-style');
    const btnClean = document.getElementById('btn-clean-filters');

    if (inputSearch) inputSearch.addEventListener('keyup', filtrarTabla);
    if (selectStyle) selectStyle.addEventListener('change', filtrarTabla);
    if (btnClean) {
        btnClean.addEventListener('click', () => {
            if(inputSearch) inputSearch.value = "";
            if(selectStyle) selectStyle.value = "Todos";
            filtrarTabla();
        });
    }

    // --- Apertura de Mini Modales (Estilo/Material) ---
    const btnNewStyle = document.getElementById('btn-add-estilo');
    const btnNewMaterial = document.getElementById('btn-add-material');

    if (btnNewStyle) btnNewStyle.onclick = () => abrirMiniModal('modal-nuevo-estilo');
    if (btnNewMaterial) btnNewMaterial.onclick = () => abrirMiniModal('modal-nuevo-material');

    // --- Cierre Genérico de Modales (X y Clicks fuera) ---
    document.querySelectorAll('.close-modal').forEach(boton => {
        boton.onclick = function() {
            const modal = this.closest('.login-modal');
            if (modal) modal.style.display = 'none';
        };
    });

    // Cerrar al hacer clic en la parte oscura
    window.onclick = function(event) {
        if (event.target.classList.contains('login-modal')) {
            event.target.style.display = "none";
        }
    };

    // --- Logout y Previsualización de Imagen ---
    const btnLogout = document.getElementById('btnLogout');
    if (btnLogout) btnLogout.onclick = logout;

    const fileInput = document.getElementById('file-input');
    if (fileInput) {
        fileInput.onchange = function (evt) {
            const [file] = this.files;
            if (file) {
                const fr = new FileReader();
                fr.onload = () => {
                    const previewContainer = document.getElementById('inner-preview');
                    if (previewContainer) {
                        previewContainer.innerHTML = `<img src="${fr.result}" style="width: 100%; height: 100%; object-fit: cover; border-radius: 10px;">`;
                    }
                };
                fr.readAsDataURL(file);
            }
        };
    }
}

// Aseguramos que cargue siempre
document.addEventListener("DOMContentLoaded", inicializarEventos);

/* ==========================================
    2. GESTIÓN DE BANDANAS (CRUD VISUAL)
   ========================================== */

function openBandanaModal() {
    document.getElementById('titulo-modal').innerText = "Nueva bandana";
    document.getElementById('input-accion').value = "GuardarBandana";
    document.getElementById('formBandana').reset();
    
    const selects = [document.getElementById('input-estilo'), document.getElementById('input-material')];
    selects.forEach(s => {
        if(s){ s.style.pointerEvents = 'auto'; s.style.background = '#fff'; }
    });
    
    document.getElementById('inner-preview').innerHTML = `<img src="Imagenes/huella decorativa.png" style="width: 50px; opacity: 0.3;">`;
    document.getElementById('bandanaModal').style.display = 'flex'; 
}

function prepararEdicion(id, nombre, precio, desc, estilo, material, xs, s, m, l, xl, imagen) {
    document.getElementById('titulo-modal').innerText = "Editar bandana N-" + id;
    document.getElementById('input-accion').value = "ActualizarBandana";
    document.getElementById('input-id-hidden').value = id;
    document.getElementById('input-id-bandana').value = "N-" + id;
    document.getElementById('input-nombre').value = nombre;
    document.getElementById('input-precio').value = precio;
    document.getElementById('input-descripcion').value = desc;
    
    const sEstilo = document.getElementById('input-estilo');
    const sMaterial = document.getElementById('input-material');
    if(sEstilo) { sEstilo.value = estilo; sEstilo.style.pointerEvents = 'none'; sEstilo.style.background = '#e9ecef'; }
    if(sMaterial) { sMaterial.value = material; sMaterial.style.pointerEvents = 'none'; sMaterial.style.background = '#e9ecef'; }

    document.getElementById('stk-xs').value = xs;
    document.getElementById('stk-s').value = s;
    document.getElementById('stk-m').value = m;
    document.getElementById('stk-l').value = l;
    document.getElementById('stk-xl').value = xl;

    const preview = document.getElementById('inner-preview');
    preview.innerHTML = (imagen && imagen !== "null" && imagen !== "") 
        ? `<img src="Imagenes/bandanas/${imagen}" style="width: 100%; height: 100%; object-fit: cover; border-radius: 10px;">`
        : `<img src="Imagenes/huella decorativa.png" style="width: 50px; opacity: 0.3;">`;
    
    document.getElementById('bandanaModal').style.display = 'flex';
}

function confirmarEliminacion(id) {
    Swal.fire({
        title: '¿Eliminar?', text: "No se puede deshacer.", icon: 'warning',
        showCancelButton: true, confirmButtonColor: '#1a4731', confirmButtonText: 'Eliminar'
    }).then((r) => { if (r.isConfirmed) window.location.href = "ControladorPrincipal?accion=eliminarBandana&id=" + id; });
}

/* ==========================================
    3. MODALES SECUNDARIOS Y VALIDACIÓN
   ========================================== */

function abrirMiniModal(id) {
    const m = document.getElementById(id);
    if (m) { m.style.display = "flex"; m.style.zIndex = "5000"; }
}

function cerrarMiniModal(id) {
    const m = document.getElementById(id);
    if (m) m.style.display = "none";
}

/* ==========================================
    4. SISTEMA DE FILTROS (LA PARTE QUE FALTABA)
   ========================================== */

function filtrarTabla() {
    const texto = document.getElementById('filter-search').value.toLowerCase();
    const estiloFiltro = document.getElementById('filter-style').value;
    const filas = document.querySelectorAll('.admin-table tbody tr');

    filas.forEach(fila => {
        // En tu tabla: celda 0 es Estilo, celda 1 es ID, celda 2 es Nombre
        const estiloCelda = fila.cells[0].innerText;
        const idCelda = fila.cells[1].innerText.toLowerCase();
        const nombreCelda = fila.cells[2].innerText.toLowerCase();

        const coincideTexto = nombreCelda.includes(texto) || idCelda.includes(texto);
        const coincideEstilo = (estiloFiltro === "Todos" || estiloCelda === estiloFiltro);

        if (coincideTexto && coincideEstilo) {
            fila.style.display = "";
        } else {
            fila.style.display = "none";
        }
    });
}

/* ==========================================
    5. UTILIDADES Y SESIÓN
   ========================================== */

function logout() {
    localStorage.removeItem("isLogged");
    window.location.href = "index.html";
}

window.onclick = (e) => {
    if (e.target.classList.contains('login-modal')) e.target.style.display = "none";
};