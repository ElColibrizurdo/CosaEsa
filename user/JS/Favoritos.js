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
            body: JSON.stringify({tipos, equipos, stock, buscar: '%'})
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

        linea.innerText = 'Agotado'
    }

    div_estado.appendChild(linea)

    //Imagen del producto
    const img = document.createElement('img')
    img.classList.add('img_carta')
    img.src = '../img/articulos/' + element.id + '.png'

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
    console.log(chkbox_deseo.checked);
    

    const svgContent = `
                    <svg id="Layer_1" version="1.0" viewBox="0 0 24 24" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                        <path d="M16.4,4C14.6,4,13,4.9,12,6.3C11,4.9,9.4,4,7.6,4C4.5,4,2,6.5,2,9.6C2,14,12,22,12,22s10-8,10-12.4C22,6.5,19.5,4,16.4,4z"></path>
                    </svg>
                `;

    lbl.appendChild(chkbox_deseo)
    lbl.innerHTML += svgContent

    card_footer.appendChild(label_costo)
    card_footer.appendChild(lbl)

    

                card_body.appendChild(contenedor_nombre)
                card_body.appendChild(card_footer)

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
        console.log(boton);
        
        estado = 1
    } else {
        console.log(boton);
        
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
            console.log('To salio bien');
        }

    } catch (error) {
        console.log(error);
    }
}



ObtenerFavoritos()


document.querySelector('.atras').addEventListener('click', function () {
    
    history.back()
})

