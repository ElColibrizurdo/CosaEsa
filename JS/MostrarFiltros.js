async function MostrarFiltros() {
    
    const response = await fetch('/auth/mostrarFiltros')
    const data = await response.json()


    try {
        
        MostrarFiltrosOfficiales(data.tipos)
        MostrarFiltrosEquipos(data.equipos)

    } catch (error) {
        
    }

    MostrarLogosEquipos(data.equipos)
    
}

function MostrarFiltrosOfficiales(tipos) {
    
    tipos.forEach(element => {

        const lista = document.getElementById('Articulos')

        const filtro = ` 
        <li class="lista_checkbox"><div class="opciones">${element.nombre}&nbsp</div>&nbsp<label class="checkBox_filtro"><input id="ch1" value="${element.id}" name="" class="tipo" type="checkbox" onchange="FiltrarDatos(this)"><div class="transition_checkbox" ></div></label>&nbsp</li>
                         `
        lista.innerHTML += filtro
    })
}

function MostrarFiltrosEquipos(equipos) {
    
    equipos.forEach(element => {

        const lista = document.getElementById('Equipos')

        const filtro = `
        <li class="lista_checkbox"><div class="opciones">${element.nombre}&nbsp</div><label class="checkBox_filtro"><input id="ch1" type="checkbox" value="${element.id}" class="equipos"  onchange="FiltrarDatos(this)"><div class="transition_checkbox"></div></label>&nbsp</li>
                     `

        lista.innerHTML += filtro
    })
}

function MostrarLogosEquipos(equipos) {

    
    const lugar = Math.floor(equipos.length / 2)
    
    equipos.forEach((element, indice) => {

        const apartado = document.querySelector('.logos_de_equipos')
        
        let logo

        if (lugar == indice) {
            logo = `
            <img src="../IMAGES/logos/logo_19.jpeg" class="img-fluid equipos" value="19" alt="..." onclick="FiltrarDatos(this)"/>
            `
            const logo2 = `
            <img src="../IMAGES/logos/logo_${element.id}.jpeg" class="img-fluid equipos" value="${element.id}" alt="..." onclick="FiltrarDatos(this)"/>
            `

            apartado.innerHTML += logo
            apartado.innerHTML += logo2

        } else if (indice != 10) {
            
            logo = `
            <img src="../IMAGES/logos/logo_${element.id}.jpeg" class="img-fluid equipos" value="${element.id}" alt="..." onclick="FiltrarDatos(this)"/>
            `

            apartado.innerHTML += logo
        }   

    })
}

MostrarFiltros()