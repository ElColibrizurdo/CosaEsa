


async function DeterminarUbicacion() {
    
    const pais = document.getElementById('paises')
    const codigoPostal = document.getElementById('cod')

    if (codigoPostal.value.length > 0) {

        console.log(codigoPostal.value);
        console.log(pais.value);

        const response = await fetch('/auth/determinarUbi?pais=' + pais.value + '&cod=' + codigoPostal.value)
        const data = await response.json()
    
        MostrarEstadosColonias(data)
    }
}

 function MostrarEstadosColonias(colonias) {
    
    const contenedor = document.getElementById('colonias')
    const entidad = document.getElementById('entidad')

    entidad.innerHTML = ''
    contenedor.innerHTML = ''

    colonias.forEach((element, indice) => {

        const option = `
            <option value="${element.d_asenta}">${element.d_asenta}</option>`
        
        console.log(indice);
        

        if (indice != 0 && element.Nombre != colonias[indice - 1].Nombre) {

            const optione = `
            <option value="${element.Nombre}">${element.Nombre}</option>`

            entidad.innerHTML += optione
        } else if(indice == 0) {

            const optione = `
            <option value="${element.Nombre}">${element.Nombre}</option>`

            entidad.innerHTML += optione
        }

        
        
        contenedor.innerHTML += option
    })
}

async function MostrarPaises(params) {
    
    const response = await fetch('/auth/paises')
    const data = await response.json()

    const selectPaises = document.getElementById('paises')

    data.forEach(element => {
        
        const option = `<option value="${element.Nombre}" id="${element.id}">${element.Nombre}</option>`
        
        selectPaises.innerHTML += option
    });

    selectPaises.value = 'México'
    
}

MostrarPaises()