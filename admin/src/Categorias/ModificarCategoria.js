async function MostrarCategorias(id) {
    
    console.log(id);
    
    const consulta = 'WHERE id = ' + id

    const response = await fetch('/auth/categorias?tipo=' + consulta)
    const data = await response.json()

    const nombre = document.getElementById('nombre')

    console.log(data);
    nombre.value = data[0].nombre

    
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

if (new URLSearchParams(window.location.search).get('idCategoria')) {

    
    MostrarCategorias(new URLSearchParams(window.location.search).get('idCategoria'))

    const btnFinalizar = document.getElementById('finalizar')

    btnFinalizar.setAttribute('onclick', 'ModificarCategoria()')

    const btnSubirImagen = document.getElementById('image')

    //btnSubirImagen.setAttribute('enctype', 'NuevaImagen(this)')
    //btnSubirImagen.removeAttribute('onchange')
}