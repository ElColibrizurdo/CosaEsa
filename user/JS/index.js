

    contador = 0
    conte = ''
    item_active = ''
    seccion_carousel = document.getElementById('carouselExample')
    carousel = document.querySelector('.carousel-inner')

  

function tomar_datos() {

    const numero_cards = detectar_tamaño()
    
    
    fetch('/data')
        .then(response => response.json())
        .then(data => {
            data.forEach((element, indice) => {
                console.log(indice);
                num = indice -= 1
                if (indice >= 1 && element.equipo !== data[num].equipo) {
                    
                    nuevo_carousel = seccion_carousel.cloneNode(true)
                    nuevo_carousel.id = 'carousel' + element.id
                    nuevo_carousel.classList.add('equipos', 'carousel', 'slide', 'mt-4')

                    left_button = nuevo_carousel.querySelector('.carousel-control-prev')
                    left_button.setAttribute('data-bs-target', '#carousel' + element.id)

                    right_button = nuevo_carousel.querySelector('.carousel-control-next')
                    right_button.setAttribute('data-bs-target', '#carousel' + element.id)

                    document.getElementById('productos').appendChild(nuevo_carousel)
                    carousel = nuevo_carousel.querySelector('.carousel-inner')
                    carousel.innerHTML=''
                    contador = 0
                }
                contador += 1
                if (contador == numero_cards) {
                    
                    contador = 0
                }
                crear_card(element, contador)
                document.dispatchEvent(new Event('codigoTerminado'));
            });
        })
        .catch(error => console.error(error))

}

function crear_card(element, contador) {
        
        const card = document.createElement('div');
        const img = document.createElement('img');
        const div_datos = document.createElement('div');
        const equipo = document.createElement('h5')
        const nombre = document.createElement('h5')
        const div_agregar = document.createElement('div')
        const btn_agregar = document.createElement('button')
                    
        img.src = "../IMAGES/kirbo.png"
        img.classList.add('position-absolute', 'img-fluid')

        equipo.textContent = element.equipo
        nombre.textContent = element.jugador

        div_agregar.classList.add('canasta', 'position-absolute', 'end-0')
        btn_agregar.setAttribute('id_producto', '' + element.id)
        btn_agregar.classList.add('btn', 'btn-warning', 'end-0', 'rounded-circle')
        btn_agregar.textContent = '+'
        div_agregar.appendChild(btn_agregar)
        btn_agregar.style.visibility = 'hidden'
        btn_agregar.disabled = false

        div_datos.classList.add('nombre_equipo', 'position-absolute', 'float-end')
        equipo.classList.add('mt-3', 'fs-4', 'card-title')
        nombre.classList.add('mt-3', 'fs-4', 'card-title')
        div_datos.appendChild(equipo)
        div_datos.appendChild(nombre)

        card.classList.add('equipo', 'ms-3', 'position-relative')
        card.appendChild(img)
        card.appendChild(div_datos)
        card.appendChild(div_agregar)

        contenedor(element, contador, card)

    }

function contenedor(element, contador, card) {

        if (contador == 1) {
            
            var contenedor = document.createElement('div')
            contenedor.id = 'contenedor'
            contenedor.classList.add('contenedor', 'd-flex', 'flex-wrap', 'justify-content-center')

            conte = contenedor
        } 
        conte.appendChild(card)
        
        item_activo(contador, conte)
    }

function item_activo(contador, conte) {

        if (contador == 1) {
            
            var item_activo = document.createElement('div')
            item_activo.classList.add('carousel-item', 'active')

            item_active = item_activo
        }

        item_active.appendChild(conte)
        console.log(item_active);
        carousel.appendChild(item_active)
    }

function detectar_tamaño () {

    const tamanio_pagina = window.innerWidth

    const numero_cards = Math.floor(tamanio_pagina / 326)
    
    return numero_cards
}


tomar_datos()

window.addEventListener('resize', function () {

    const carouseles = this.document.querySelectorAll('.carousel')
    seccion_carousel = document.getElementById('carouselExample')
    carousel = document.querySelector('.carousel-inner')

    carouseles.forEach( carousel => {

        if (carouseles[0] == carousel) {

            const inner = carousel.querySelector('.carousel-inner')
            inner.innerHTML = ''
        } else {

            carousel.remove()
        }
    })
    
    
    tomar_datos()
})