async function ObtenerFavoritos() {

    const cantidad = document.querySelector('#cantidad')

    const sesion = localStorage.getItem('sesion')
    let contador = 0

    const contenedor = document.querySelector('.grupo_cartas')
    contenedor.innerHTML = ''

    const tipos = []
    const equipos = []
    const stock = []
    
    try {
        
        const response = await fetch('/data', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({tipos, equipos, stock})
        })

        const data = await response.json()

        data.forEach(async element => {

            const number = element.id
            
            const fResponse = await fetch('/auth/getLike', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({number, sesion})
            })

            const favoritos = await fResponse.json()
            
            if (favoritos.row) {
                CrearCards(element)
                contador += 1
                console.log(contador);
                
                cantidad.innerText = 'Mis favoritos (' + contador + ')'
            }
        });
        
        console.log(contador);
        
    } catch (error) {
    }
}

function  CrearCards(element) {

    console.log(element);
    
    //Carta para mostrar los productos
    const card = document.createElement('div')
    card.href = '/canasta?id=' + element.id 
    card.classList.add('carta')

    //Contenedor estado del producto
    const div_estado = document.createElement('div')
    div_estado.classList.add('carta_estado')

    const linea = document.createElement('a')

    if (element.estado == 0) {
        linea.innerText = 'Preventa'
    } else if (element.estado  == 1) {
                    
        linea.innerText = 'En Stock'
    } else {

        linea.innerText = 'Agotdo'
    }

    div_estado.appendChild(linea)

    //Imagen del producto
    const img = document.createElement('img')
    img.classList.add('img_carta')
    img.src = '../IMAGES/articulos/' + element.id + '.png'

    //Parte texto de la carta
    const card_body = document.createElement('div')
    card_body.classList.add('txt_carta')

    //Contenedor del nombre
    const contenedor_nombre = document.createElement('div')
    contenedor_nombre.classList.add('txt_carta_1')

    const label_name = document.createElement('a')
    label_name.href = '/canasta?id=' + element.id
    label_name.innerText = element.descripcion

    contenedor_nombre.appendChild(label_name)

    //Contenedor del precio y like
    const card_footer = document.createElement('div')
    card_footer.classList.add('txt_carta_2')

    const label_costo = document.createElement('a')
    label_costo.innerText = element.precio

    //Like en forma  de corazon
    const lbl = document.createElement('label')
    lbl.classList.add('container_corazon')

    const chkbox_deseo = document.createElement('input')
    chkbox_deseo.type = 'checkbox'
    chkbox_deseo.setAttribute('number', element.id)
    chkbox_deseo.setAttribute('onchange', 'DarLike(this)')
    chkbox_deseo.classList.add('productos')

    const svgContent = `
                    <svg id="Layer_1" version="1.0" viewBox="0 0 24 24" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path d="M16.4,4C14.6,4,13,4.9,12,6.3C11,4.9,9.4,4,7.6,4C4.5,4,2,6.5,2,9.6C2,14,12,22,12,22s10-8,10-12.4C22,6.5,19.5,4,16.4,4z"></path>
                    </svg>
                `;

    lbl.appendChild(chkbox_deseo)
    lbl.innerHTML += svgContent

    card_footer.appendChild(label_costo)
    card_footer.appendChild(lbl)

    //contenedor btn agregar carrito
    const contenedor_btn_agregar = document.createElement('div')
    contenedor_btn_agregar.classList.add('.contendror_btn_carta')

    const btn_agregar = document.createElement('button')
    btn_agregar.classList.add('btn_carta', 'btn_pedido')

    const img_btn = `
        <svg xmlns="http://www.w3.org/2000/svg" width="25" height="24" viewBox="0 0 25 24" fill="none">
                                            <mask id="mask0_1950_15788" style="mask-type:alpha" maskUnits="userSpaceOnUse" x="0" y="0" width="25" height="24">
                                            <rect x="0.900391" width="24" height="24" fill="#D9D9D9"/>
                                            </mask>
                                            <g mask="url(#mask0_1950_15788)">
                                            <path d="M7.90039 22C7.35039 22 6.87956 21.8042 6.48789 21.4125C6.09622 21.0208 5.90039 20.55 5.90039 20C5.90039 19.45 6.09622 18.9792 6.48789 18.5875C6.87956 18.1958 7.35039 18 7.90039 18C8.45039 18 8.92122 18.1958 9.31289 18.5875C9.70456 18.9792 9.90039 19.45 9.90039 20C9.90039 20.55 9.70456 21.0208 9.31289 21.4125C8.92122 21.8042 8.45039 22 7.90039 22ZM17.9004 22C17.3504 22 16.8796 21.8042 16.4879 21.4125C16.0962 21.0208 15.9004 20.55 15.9004 20C15.9004 19.45 16.0962 18.9792 16.4879 18.5875C16.8796 18.1958 17.3504 18 17.9004 18C18.4504 18 18.9212 18.1958 19.3129 18.5875C19.7046 18.9792 19.9004 19.45 19.9004 20C19.9004 20.55 19.7046 21.0208 19.3129 21.4125C18.9212 21.8042 18.4504 22 17.9004 22ZM7.05039 6L9.45039 11H16.4504L19.2004 6H7.05039ZM6.10039 4H20.8504C21.2337 4 21.5254 4.17083 21.7254 4.5125C21.9254 4.85417 21.9337 5.2 21.7504 5.55L18.2004 11.95C18.0171 12.2833 17.7712 12.5417 17.4629 12.725C17.1546 12.9083 16.8171 13 16.4504 13H9.00039L7.90039 15H19.9004V17H7.90039C7.15039 17 6.58372 16.6708 6.20039 16.0125C5.81706 15.3542 5.80039 14.7 6.15039 14.05L7.50039 11.6L3.90039 4H1.90039V2H5.15039L6.10039 4Z" fill="white"/>
                                            </g>
                                        </svg>Añadir carrito `
    btn_agregar.innerHTML += img_btn
    btn_agregar.setAttribute('el', element.id)
    btn_agregar.setAttribute('precio', element.precio)
    btn_agregar.setAttribute('onclick', 'AgregarCanasta(this);')

    contenedor_btn_agregar.appendChild(btn_agregar)

                card_body.appendChild(contenedor_nombre)
                card_body.appendChild(card_footer)
                card_body.appendChild(contenedor_btn_agregar)

                card.appendChild(div_estado)
                card.appendChild(img)
                card.appendChild(card_body)
                card.setAttribute('tipo', element.idTipo)
                card.setAttribute('equipo', element.idEquipo)

                ImprimirProductos(card)
}

function ImprimirProductos(card) {

    const contenedor = document.querySelector('.grupo_cartas')
    contenedor.appendChild(card)
    
}

async function DarLike(boton) {
    
    const number =  boton.getAttribute('number')
    const sesion = localStorage.getItem('sesion')
    let estado 

    if (boton.checked) {
        estado = 1
    } else {
        estado = 0
    }

    try {
        
        const response = await fetch('/auth/like', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ number,  sesion, estado})
        })

        const data = await response.json()
        
        if (data.ok) {
        }

    } catch (error) {
        console.log(error);
    }
}

ObtenerFavoritos()

document.querySelector('.atras').addEventListener('click', function () {
    
    history.back()
})

