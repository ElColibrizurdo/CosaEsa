const saltos = [0,0,0]
const contador = 5


async function Clasificaciones(btn) {
 
   

    const response = await fetch(`/auth/filtros?producto=%camiseta%&saltos=${saltos}`)
    const data = await response.json()

  
    
    
    MostrarProductos(btn, data)
    
    
}

async function EjecutarScripts() {
    
    
    await Poner_Likes('../JS/Poner_Likes.js')
}

function Salto(params) {
 
    const botones = document.querySelectorAll('.radio-button')

    botones.forEach((element, indice) => {

        if (element.checked) {
            
            if (params == '-') {
                
                if (saltos[indice] == 0) {
                    
                    saltos[indice] = 2
                    Clasificaciones(element)
                } else {

                    saltos[indice] -= 1
                    Clasificaciones(element)
                }
            } else {
                console.log('adelante   ');

                if (saltos[indice] == 2) {
                    
                    saltos[indice] = 0
                    Clasificaciones(element)
                } else {

                    saltos[indice] += 1
                    Clasificaciones(element)
                }
            }
        }
    })
}

function MostrarProductos(params, data) {

   
    

    const contenedor_recomendados = document.querySelector('.grupo_cartas_recomendaciones')
    contenedor_recomendados.innerHTML = ' '
    

    switch (params.classList[1]) {
        case "0":
            
            data.productos.forEach(element => {

                CrearCards(element, contenedor_recomendados)
            })

            
            //contenedor_recomendados.setAttribute('p', pRecomendados)
            break;
        case "1":
            data.masVendidos.forEach(element => {

                CrearCards(element, contenedor_recomendados)
            })
            //contenedor_recomendados.setAttribute('v', pRecomendados)
            break;
        case "2":
            data.preventa.forEach(element => {

                CrearCards(element, contenedor_recomendados)
            })
            //contenedor_recomendados.setAttribute('pr', pRecomendados)
            break;
    
        default:
            data.productos.forEach(element => {

                CrearCards(element, contenedor_recomendados)
            })
            //contenedor_recomendados.setAttribute('p', pRecomendados)
            break;
    }

    
    EjecutarScripts()
}

function CrearCards(element, contenedor) {
    

    //Carta para mostrar los productos
    const card = document.createElement('div')
    card.href = '/canasta?id=' + element.id 
    card.classList.add('carta')

    //Link
    const link = document.createElement('a')
    link.href = '/canasta?id=' + element.id
    link.classList = 'link'

    card.appendChild(link)

    //Contenedor estado del producto
    const div_estado = document.createElement('div')
    div_estado.classList.add('carta_estado')

    const linea = document.createElement('a')

    if (element.estado == 0) {
         linea.innerText = 'Preventa'
    } else if (element.estado  == 1) {
        
         linea.innerText = 'Disponible'
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

    const label_name = document.createElement('p')
    label_name.href = '/canasta?id=' + element.id
    label_name.innerText = element.descripcion
    label_name.title = element.descripcion

    contenedor_nombre.appendChild(label_name)

    //Contenedor del precio y like
    const card_footer = document.createElement('div')
    card_footer.classList.add('txt_carta_2')

    const label_costo = document.createElement('p')
    label_costo.innerText = element.precio

    //Like en forma  de corazon
    const lbl = document.createElement('label')
    lbl.classList.add('container_corazon')

    const chkbox_deseo = document.createElement('input')
    chkbox_deseo.type = 'checkbox'
    chkbox_deseo.setAttribute('number', element.id)
    chkbox_deseo.classList.add('productos')
    chkbox_deseo.setAttribute('onchange', 'DarLike(this)')
    chkbox_deseo.setAttribute('onclick', 'validaSesion(this)')

    const svgContent = `
        <svg id="Layer_1"  onclick="abrir_inicar_sesion()" version="1.0" viewBox="0 0 24 24" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
        <path d="M16.4,4C14.6,4,13,4.9,12,6.3C11,4.9,9.4,4,7.6,4C4.5,4,2,6.5,2,9.6C2,14,12,22,12,22s10-8,10-12.4C22,6.5,19.5,4,16.4,4z"></path></svg>
                                  `;

    lbl.appendChild(chkbox_deseo)
    lbl.innerHTML += svgContent

    card_footer.appendChild(label_costo)
    card_footer.appendChild(lbl)

    card_body.appendChild(contenedor_nombre)
    card_body.appendChild(card_footer)

    link.appendChild(div_estado)
    link.appendChild(img)
    link.appendChild(card_body)
    card.setAttribute('tipo', element.idTipo)
    card.setAttribute('equipo', element.idEquipo)

    
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
        }

    } catch (error) {
        console.log(error);
    }
}

function FiltrarDatos(boton) {
    
    
    window.location.href = `/tienda?equipo=${boton.getAttribute('value')}`
}

const boton = document.querySelector('.radio-button')
Clasificaciones(boton)