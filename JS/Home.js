async function Clasificaciones(signo) {

    let saltos = []
    let cual = 0

    const contenedor_recomendados = document.querySelector('.grupo_cartas_recomendaciones')
    
    if (signo) {
        
        const btnRadio = document.querySelector('[name="radio"]:checked')

        if (signo == '+') {


            
        } else if (signo == '-') {
            
        }
    }

    let pRecomendados = parseInt(contenedor_recomendados.getAttribute('p'))
    let vRecomendados = parseInt(contenedor_recomendados.getAttribute('v'))
    let prRecomendados = parseInt(contenedor_recomendados.getAttribute('pr'))

    saltos.push(pRecomendados, vRecomendados, prRecomendados)

    console.log(saltos);
    

    const response = await fetch(`/auth/filtros?producto=%camiseta%&saltos=${saltos}`)
    const data = await response.json()

    console.log(data);
    
    document.querySelectorAll('.radio-button').forEach(function(element, indice) {
        saltos = []
        element.addEventListener('click', function(event) {
            contenedor_recomendados.innerHTML = ' '
            console.log(event);
            console.log(element);
            console.log(indice);
            
            switch (indice) {
                case 0:
                    data.productos.forEach(element => {

                        CrearCards(element, contenedor_recomendados)
                    })

                    pRecomendados+=1
                    console.log(pRecomendados);
                    
                    contenedor_recomendados.setAttribute('p', pRecomendados)
                    break;
                case 1:
                    data.masVendidos.forEach(element => {

                        CrearCards(element, contenedor_recomendados)
                    })
                    vRecomendados+=1
                    contenedor_recomendados.setAttribute('v', pRecomendados)
                    break;
                case 2:
                    data.preventa.forEach(element => {

                        CrearCards(element, contenedor_recomendados)
                    })
                    prRecomendados+=1
                    contenedor_recomendados.setAttribute('pr', pRecomendados)
                    break;
            
                default:
                    data.productos.forEach(element => {

                        CrearCards(element, contenedor_recomendados)
                    })
                    pRecomendados+=1
                    contenedor_recomendados.setAttribute('p', pRecomendados)
                    break;
            }
            saltos.push(pRecomendados, vRecomendados, prRecomendados)
            EjecutarScripts()
        })
    })
}

async function EjecutarScripts() {
    
    await Poner_Likes('../JS/Poner_Likes.js')
}

function saltos() {
    
    
}

function CrearCards(element, contenedor) {
    
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
    chkbox_deseo.classList.add('productos')
    chkbox_deseo.setAttribute('onchange', 'DarLike(this)')
    chkbox_deseo.setAttribute('onclick', 'validarSesion(this)')

    const svgContent = `
        <svg id="Layer_1" version="1.0" viewBox="0 0 24 24" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <path d="M16.4,4C14.6,4,13,4.9,12,6.3C11,4.9,9.4,4,7.6,4C4.5,4,2,6.5,2,9.6C2,14,12,22,12,22s10-8,10-12.4C22,6.5,19.5,4,16.4,4z"></path>
        </svg>
    `;

    lbl.appendChild(chkbox_deseo)
    lbl.innerHTML += svgContent

    card_footer.appendChild(label_costo)
    card_footer.appendChild(lbl)

    card_body.appendChild(label_name)
    card_body.appendChild(card_footer)

    card.appendChild(div_estado)
    card.appendChild(img)
    card.appendChild(card_body)
    card.setAttribute('tipo', element.idTipo)
    card.setAttribute('equipo', element.idEquipo)

    console.log(card);
    
    contenedor.appendChild(card)
}

async function DarLike(boton) {
    
    const number =  boton.getAttribute('number')
    const sesion = localStorage.getItem('sesion')
    let estado 
    

    if (boton.checked) {
        estado = 0
    } else {
        estado = 1
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

Clasificaciones()