

function AgregarBotonPagar() {
    
    const btn_pagar = document.createElement('button')
    btn_pagar.classList.add('btn_inciarSesion')
    btn_pagar.onclick = ComprarProductos
    btn_pagar.textContent = 'Pagar'

    const div = document.querySelector('.btn_logIn')

    div.appendChild(btn_pagar)
}

const params = new URLSearchParams(window.location.search)

console.log(window.location.href);

console.log(params);

if (params.get('comprar')) {
    
    AgregarBotonPagar()
}