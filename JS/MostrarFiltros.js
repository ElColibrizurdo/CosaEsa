async function MostrarFiltros() {
    
    const response = await fetch('/auth/mostrarFiltros')
    const data = await response.json()

    MostrarFiltrosOfficiales(data.tipos)
    MostrarFiltrosEquipos(data.equipos)

    console.log(data);
    
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

MostrarFiltros()