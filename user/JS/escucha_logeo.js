


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
    console.log(localStorage.getItem('token'));
    

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
        window.parent.location.reload()
    } catch (error) {
        console.log(error);
        
    }

    
}

console.log(new Date().getFullYear() + '-' + new Date().getUTCMonth() + '-' + new Date().getDay());

if (localStorage.getItem('name')) {


    const btn = document.getElementById('perfil')
    const name = localStorage.getItem('name')
  
   btn.innerHTML = name


    ObtenerCantidadCanasta()
    
}

if (localStorage.getItem('sesion')) {

    console.log('sesion');
    
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
    const token = localStorage.getItem('token')
    console.log(sesion);
    
    const response = await fetch(`/auth/cantidad?sesion=${sesion}&token=${token}`)
    
    const data = await response.json()
    
    const carrit0 = document.querySelector('.btn_carrito')
console.log('epep');

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



        


