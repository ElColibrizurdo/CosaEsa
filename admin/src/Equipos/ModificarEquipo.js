
const url = window.location.search

if (url.includes('idEquipo=')) {
    
    const btnAceptar = document.getElementById('finalizar')

    btnAceptar.setAttribute('onclick', 'ModificarEquipo() cerrarPage()')

    const currentURL = new URLSearchParams(url)

    MostrarEquipo(currentURL.get('idEquipo'))
}

async function MostrarEquipo(params) {
    
    const response = await fetch('/auth/mostrarEquipos')
    const data = await response.json()

    console.log(params);
    
    const equipo = data.find(obj => obj.id == params)

    console.log(equipo.nombre);

    const nombre = document.getElementById('nombre')
    

    const respuestaLogo = await fetch('/auth/obtenerLogo?id=' + params)
    const rutaLogo = await respuestaLogo.json()

    console.log(rutaLogo);
    const archivo = { files: rutaLogo }
    
    MostrarImagen(archivo)

    nombre.setAttribute('value', equipo.nombre)
}

function MostrarImagen(params) {
    
    const fila = document.createElement('li')

    fila.setAttribute('nombre', params.files[0])
        document.body.innerHTML += params.files[0]

    const label = document.createElement('label')

    const img = document.createElement('img')
    img.src = '../img/logos/' + params.files[0].name

    const btn = document.createElement('button')
    btn.textContent = 'eliminar'

    label.appendChild(img)
    label.appendChild(btn)

    
    fila.appendChild(label)
    btn.setAttribute('onclick', 'RemoverImage(this)')

    const lista = document.getElementById('imagenes')
    lista.appendChild(fila)
    
    //lista.appendChild(fila)
    console.log(params.files[0]);
    inpuImage = params.files[0]
}

