async function inicio() {
    
    const btn = document.getElementById('btn_carrito')
    var div = document.getElementById("lista_carrito");
    
    try {
        btn.addEventListener('mousedown', async function() {

            if (div.classList.contains("active")) {
                div.classList.remove("active");
                 document.body.style.setProperty('--before-z-index', '3');
                 document.body.style.overflowY = 'hidden';
                
            } else {
                div.classList.add("active");
                 document.body.style.setProperty('--before-z-index', '0');
                  document.body.style.overflowY = 'auto';
                 
            }
    
            console.log(btn);
    
            const columna = document.querySelector('.div_scroll')
            columna.innerHTML = ''
            
            const id = localStorage.getItem('sesion')
    
            try {
                
                const response = await fetch('/auth/mostrar', {
    
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({id})
                })
                const data = await response.json()
                data.rows.forEach(element => {
                    console.log(element);
                    
                    Obtener_datos(element.id_producto, element.total, element.cantidad, element.id, columna, element.etiqueta, element.numero)
                    
                });
                console.log(data.rows);
                //Obtener_datos(data.rows[0].id_producto ,data.rows[0].cantidad)
    
    
            } catch (error) {
                console.log(error);
            }
        })
    } catch (error) {
        console.log(error);
        
    }

   

    
}

async function Obtener_datos(id, total, cantidad, idCanasta, columna, etiqueta, numero) {

    if (numero == 0 ) {
        numero = ''
        console.log('Nuevo numero: ' + numero);
        console.log('Nuevo numero: ' + etiqueta);
        
    }
    

    try {

        const response = await fetch('/auth/producto', {

            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({id})
        })

        const data = await response.json();
        console.log(numero);
        
        Crear_card(data.producto, total, cantidad, idCanasta, columna, etiqueta, numero)

    } catch (error) {
        console.log(error);
    }
}

function Crear_card(producto, total, cantidad, idCanasta, columna, etiqueta, numero) {


    
    //card que mostrara el producto que el usuario elijio
    const carta_carrito = document.createElement('div')
    carta_carrito.classList.add('carta_carrito')

    //Seccion para mostrar la img del producto
    const img_carrito_cart = document.createElement('div')
    img_carrito_cart.classList.add('img_carrito_cart')

    const img = document.createElement('img')
    img.src = '../img/articulos/' + producto[0][0].id + '.png'

    img_carrito_cart.appendChild(img)

    //Seccion para la informacion del producto
    const txt_carta = document.createElement('div')
    txt_carta.classList.add('txt_carta_carrito')

    //div del titulo
    const div_titulo = document.createElement('div')
    div_titulo.classList.add('txt_carta_carrito_titulo')

    const titulo = document.createElement('a')
    titulo.innerText = producto[0][0].descripcion + ' ' + etiqueta + ' ' + numero

    div_titulo.appendChild(titulo)

    //div precio 
    const div_precio = document.createElement('div')
    div_precio.classList.add('txt_carta_carrito_precio')

    const recorte = total.split(/(?<=\.00)/)
    
    const precio = document.createElement('a')
    precio.innerText = recorte[0]

    //div eliminar producto
    const div_btn_precio = document.createElement('div')
    div_btn_precio.classList.add('contenedor_btn_precio')

    const btn_eliminiar = document.createElement('button')
    btn_eliminiar.classList.add('btn_eliminar')
    btn_eliminiar.id = 'btn-borrar'
    btn_eliminiar.setAttribute('onclick','BorrarProducto(this); ObtenerCantidadCanasta();')
    btn_eliminiar.setAttribute('elej', idCanasta)

    const an = ` <svg viewBox="0 0 448 512" class="svgIcon_eliminar"><path d="M135.2 17.7L128 32H32C14.3 32 0 46.3 0 64S14.3 96 32 96H416c17.7 0 32-14.3 32-32s-14.3-32-32-32H320l-7.2-14.3C307.4 6.8 296.3 0 284.2 0H163.8c-12.1 0-23.2 6.8-28.6 17.7zM416 128H32L53.2 467c1.6 25.3 22.6 45 47.9 45H346.9c25.3 0 46.3-19.7 47.9-45L416 128z"></path></svg>`

    btn_eliminiar.innerHTML += an

    div_btn_precio.appendChild(btn_eliminiar)

    //div btns aumentar, disminuir
    const div_cantidad = document.createElement('div')
    div_cantidad.classList.add('num_productos')

    const a_disminuir = `
                                <a signo = "-" onclick = "AumentarDisminuir(this)" elej = "${idCanasta}" tipo = "${producto[0][0].id}">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                                        <mask id="mask0_1871_15957" style="mask-type:alpha" maskUnits="userSpaceOnUse" x="0" y="0" width="24" height="24">
                                          <rect width="24" height="24" fill="#D9D9D9"/>
                                        </mask>
                                        <g mask="url(#mask0_1871_15957)">
                                          <path d="M3.79688 13.1373V10.8623H20.2034V13.1373H3.79688Z" fill="#004789"/>
                                        </g>
                                    </svg>
                                </a> `

    const input_cantidad = document.createElement('input')
    input_cantidad.type = 'text'
    input_cantidad.setAttribute('value', '' + cantidad)
    input_cantidad.setAttribute('tipos', producto[0][0].id)
    input_cantidad.setAttribute('name', 'numero')
    input_cantidad.classList.add('num_productos_input')

    const a_aumentar = `
                                <a signo = "+" onclick = "AumentarDisminuir(this)" elej = "${idCanasta}" tipo = "${producto[0][0].id}">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                                        <mask id="mask0_1871_15961" style="mask-type:alpha" maskUnits="userSpaceOnUse" x="0" y="0" width="24" height="24">
                                          <rect width="24" height="24" fill="#D9D9D9"/>
                                        </mask>
                                        <g mask="url(#mask0_1871_15961)">
                                          <path d="M10.8626 13.1376H4.79688V10.8626H10.8626V4.79688H13.1376V10.8626H19.2034V13.1376H13.1376V19.2034H10.8626V13.1376Z" fill="#004789"/>
                                        </g>
                                    </svg>
                                </a> `

    div_cantidad.innerHTML += a_disminuir
    div_cantidad.appendChild(input_cantidad)
    div_cantidad.innerHTML += a_aumentar

    div_precio.appendChild(precio)
    div_precio.appendChild(div_btn_precio)

    txt_carta.appendChild(div_titulo)
    txt_carta.appendChild(div_precio)
    txt_carta.appendChild(div_cantidad)

    carta_carrito.appendChild(img_carrito_cart)
    carta_carrito.appendChild(txt_carta)

    columna.appendChild(carta_carrito)

    const btnBorrar = document.createElement('button')
    btnBorrar.id = 'btn-borrar'
    btnBorrar.classList.add('btn_eliminar')
    btnBorrar.setAttribute('onclick','BorrarProducto(this); window.parent.ObtenerCantidadCanasta()')
    btnBorrar.setAttribute('elej', idCanasta)

    const imgBorrar = `
        <svg viewBox="0 0 448 512" class="svgIcon_eliminar">
            <path d="M135.2 17.7L128 32H32C14.3 32 0 46.3 0 64S14.3 96 32 96H416c17.7 0 32-14.3 32-32s-14.3-32-32-32H320l-7.2-14.3C307.4 6.8 296.3 0 284.2 0H163.8c-12.1 0-23.2 6.8-28.6 17.7zM416 128H32L53.2 467c1.6 25.3 22.6 45 47.9 45H346.9c25.3 0 46.3-19.7 47.9-45L416 128z"></path></svg>
    `
   
   
   

    COntrolarBotonPago()
}

function parseJwt(token) {
    const base64Url = token.split('.')[1];
    const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    const jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));
    return JSON.parse(jsonPayload);
}

function COntrolarBotonPago() {
    
    const cantidad = document.querySelectorAll('.num_productos_input')
    const precios = document.querySelectorAll('.txt_carta_carrito_precio')

    let acumulado = 0

    precios.forEach((element, indice) => {

        const precio = parseFloat(element.querySelector('a').textContent)
        const can = parseFloat(cantidad[indice].value)


        acumulado += precio * can
        console.log(acumulado);
        
    })

    const btnPagar = document.querySelector('.btn_lista_carrito_1')
    btnPagar.innerHTML = `Pagar Pedido-Total: ${acumulado} MXN`
}

    inicio()

