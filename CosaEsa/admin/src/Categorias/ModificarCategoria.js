async function MostrarCategorias(id) {
    
    console.log(id);
    
    const consulta = 'WHERE id = ' + id

    const response = await fetch('/auth/categorias?tipo=' + consulta)
    const data = await response.json()

    const nombre = document.getElementById('nombre')

    console.log(data);
    nombre.value = data[0].nombre
    RecuperarIMG(data[0].nombre)
    
}

async function ModificarCategoria() {
    
    const form = document.getElementById('form')
    const formData = new FormData(form)

    console.log(formData.get('nombre'));
    

    const response = await fetch('/auth/actualizarCategoria', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            id: new URLSearchParams(window.location.search).get('idCategoria'),
            nombre: formData.get('nombre')
        })
    })

    const data = await response.json()

    if (data.affectedRows == 1) {
        alert('Se modifico el color')
    }
    
}

async function RecuperarIMG(nombre) {
    const responseIMG = await fetch('/auth/recuperarIMG?id=' + nombre)
    const dataIMG = await responseIMG.json()

    console.log(dataIMG);
            
    if (dataIMG) {
                
        dataIMG.forEach(element => {

            const fila = document.createElement('li')
            fila.setAttribute('nombre', element.nombre)
            fila.id = 'logo'
            fila.classList.add('fila')
                
            const img = document.createElement('img')
            img.src = '../img/articulos/' + element.nombre
            img.style.maxWidth = '70px'

            const label = document.createElement('label')
            label.appendChild(img)

            const btn = document.createElement('button')
            btn.textContent = 'eliminar'
            label.appendChild(btn)

                    
            fila.appendChild(label)
            btn.setAttribute('onclick', 'BorrarImagen(event, this)')

            const lista = document.getElementById('lista')
            lista.appendChild(fila)
        })
    }
}

if (new URLSearchParams(window.location.search).get('idCategoria')) {

    
    MostrarCategorias(new URLSearchParams(window.location.search).get('idCategoria'))

    const btnFinalizar = document.getElementById('finalizar')

    btnFinalizar.setAttribute('onclick', 'ModificarCategoria()')

    const btnSubirImagen = document.getElementById('image')

    //btnSubirImagen.setAttribute('enctype', 'NuevaImagen(this)')
    //btnSubirImagen.removeAttribute('onchange')
} 