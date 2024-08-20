


(function() {
    const originalSetItem = sessionStorage.setItem;
    sessionStorage.setItem = function(key, value) {
        const event = new Event('sessionStorageChange');
        event.key = key;
        event.newValue = value;
        window.dispatchEvent(event);
        originalSetItem.apply(this, arguments);
    };
})();

window.addEventListener('localStorage', (event) => {

    console.log('Cambio detectado en sessionStorage');
    console.log(`Clave: ${event.key}`);
    console.log(`Nuevo valor: ${event.newValue}`);

    const token = parseJwts(event.newValue)
    const perfil = document.getElementById('btn-ingresar')
    perfil.textContent = token.user.name
});

function parseJwts (token) {
    const base64Url = token.split('.')[1];
    const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    const jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));
    return JSON.parse(jsonPayload);
}

async function CerrarSesion() {

    console.log('Vamos a cerrar sesion');
    

    try {
        const response = await fetch('/auth/cerrar', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                token: localStorage.getItem('token')
            })
        })
    
        const data = await response.json()
    
        console.log(data);
        
        const frame = document.querySelector('iframe')
    
        localStorage.removeItem('name')
        localStorage.removeItem('sesion')
        localStorage.removeItem('token')
    } catch (error) {
        console.log(error);
        
    }

    
}

console.log(new Date().getFullYear() + '-' + new Date().getUTCMonth() + '-' + new Date().getDay());

if (localStorage.getItem('name')) {


    const btnLogin = document.getElementById('btn-ingresar')
    btnLogin.remove()

    const nav = document.querySelector('.menu-dropdown')

    const dropdownHTML = `
        
            <a class="dropdown-toggle" id="nameUsuario" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                <svg xmlns="http://www.w3.org/2000/svg" width="22" height="24" viewBox="0 0 22 24" fill="none">
                    <path d="M11.0075 11.8644C9.46105 11.8644 8.14038 11.3169 7.04549 10.222C5.9506 9.12714 5.40316 7.80647 5.40316 6.26003C5.40316 4.71381 5.9506 3.39447 7.04549 2.30203C8.14038 1.20981 9.46105 0.663696 11.0075 0.663696C12.5539 0.663696 13.8746 1.20981 14.9695 2.30203C16.0644 3.39447 16.6118 4.71381 16.6118 6.26003C16.6118 7.80647 16.0644 9.12714 14.9695 10.222C13.8746 11.3169 12.5539 11.8644 11.0075 11.8644ZM0.0698242 23.0734V19.053C0.0698242 18.2479 0.278047 17.508 0.694491 16.8334C1.11094 16.1585 1.66427 15.6435 2.35449 15.2884C3.74827 14.5941 5.16682 14.0721 6.61016 13.7224C8.05327 13.3726 9.51904 13.1977 11.0075 13.1977C12.5059 13.1977 13.9769 13.3713 15.4205 13.7184C16.864 14.0655 18.2774 14.5861 19.6605 15.2804C20.3507 15.6348 20.904 16.1487 21.3205 16.822C21.7369 17.4954 21.9452 18.2388 21.9452 19.0524V23.0734H0.0698242ZM3.10316 20.04H18.9118V19.0927C18.9118 18.8534 18.8507 18.6358 18.7285 18.44C18.6063 18.2443 18.4452 18.092 18.2452 17.9834C17.0772 17.4047 15.8899 16.968 14.6835 16.6734C13.4773 16.3785 12.2519 16.231 11.0075 16.231C9.77371 16.231 8.54838 16.3785 7.33149 16.6734C6.1146 16.968 4.92738 17.4047 3.76982 17.9834C3.56982 18.092 3.40871 18.2443 3.28649 18.44C3.16427 18.6358 3.10316 18.8534 3.10316 19.0927V20.04ZM11.0072 8.83103C11.714 8.83103 12.3194 8.57936 12.8232 8.07603C13.3267 7.5727 13.5785 6.96748 13.5785 6.26036C13.5785 5.55347 13.3268 4.94959 12.8235 4.4487C12.3199 3.94759 11.7147 3.69703 11.0078 3.69703C10.3009 3.69703 9.6956 3.94803 9.19182 4.45003C8.68827 4.95203 8.43649 5.55536 8.43649 6.26003C8.43649 6.96714 8.68816 7.57248 9.19149 8.07603C9.69504 8.57936 10.3003 8.83103 11.0072 8.83103Z" fill="#235583"/>
                </svg>
            </a>
            <ul class="dropdown-menu" aria-labelledby="nameUsuario">
                <li><a class="dropdown-item" onclick="CambiarFrame(this)" jual="1">Mis Compras</a></li>
                <li><a class="dropdown-item" onclick="CambiarFrame(this)" jual="2">Mis Favoritos</a></li>
                <li><a class="dropdown-item" onclick="CambiarFrame(this)" jual="3">Mis Datos</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item" href="#" onClick="CerrarSesion(this); CambiarFrame(this)" jual="0">Cerrar Sesion</a></li>
            </ul>
        
    `;

    nav.innerHTML = dropdownHTML

    const btn = document.getElementById('nameUsuario')
    const name = localStorage.getItem('name')
  
   btn.innerHTML += name


    ObtenerCantidadCanasta()
    
}

if (localStorage.getItem('sesion')) {

    DarLikePrevio()
}


async function DarLikePrevio() {
    
    const params = new URLSearchParams(window.location.search)
    
    const like = await fetch('/auth/like', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ 
            number: params.get('like'),
            sesion: localStorage.getItem('sesion'),
            estado: 0
         })
    }) 

    const data = await like.json()

    console.log(data);
    
}


async function ObtenerCantidadCanasta() {

    console.log('modificar');
    
    
    //Poner el numero de productos en la cesta
    const sesion = localStorage.getItem('sesion')
    const response = await fetch(`/auth/cantidad?sesion=${sesion}&token=${localStorage.getItem('token')}`)
    
    const data = await response.json()
    
    const carrit0 = document.querySelector('.btn_carrito')

    console.log(data);
    console.log(carrit0);
    
    

    if (data[0] && carrit0 !== null) {
        
        carrit0.childNodes[2].textContent = data[0].cantidad
    } else if (carrit0 !== null){
        carrit0.childNodes[2].textContent = '0'
    }
    
}

function CambiarFrame(link) {

    const frame = document.querySelector('iframe')

    console.log(frame);

    const barra = document.querySelector('.buscador')
    barra.value = ''
    
    if (link.getAttribute('jual') == 1) {
        sessionStorage.setItem('pag', '/compras')
         frame.src = '/compras'
    } else if (link.getAttribute('jual') == 2) {
        sessionStorage.setItem('pag', '/favoritos')
        frame.src = '/favoritos'
    } else if (link.getAttribute('jual') == 0) {
        sessionStorage.setItem('pag', '/tienda')
        frame.src = '/tienda'
    } else if (link.getAttribute('jual') == 3) {
        sessionStorage.setItem('pag', '/datos')
        frame.src = '/datos'
    } else if (link.getAttribute('jual') == 4) {
        sessionStorage.setItem('pag', '/home')
        frame.src = '/home'
    }
}

if (sessionStorage.getItem('pag')) {
        
    const frame = document.querySelector('iframe')

    frame.src = sessionStorage.getItem('pag')
}

        


