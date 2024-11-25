async function MostrarColores(id) {
    
    console.log(id);
    

    const response = await fetch('/auth/colores?id=' + id)
    const data = await response.json()

    const nombre = document.getElementById('nombre')
    const color = document.getElementById('color')

    data.row.forEach(element => {
        
        if (element.id == id) {
            
            nombre.value = element.nombre
            color.value = element.hexadecimal
        }
    });
}

async function ModificarColor() {
    
    const form = document.getElementById('form')
    const formData = new FormData(form)

    console.log(formData.get('nombre'));
    

    const response = await fetch('/auth/actualizarColor', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            id: new URLSearchParams(window.location.search).get('idColor'),
            nombre: formData.get('nombre'),
            color: formData.get('color')
        })
    })

    const data = await response.json()

    if (data.affectedRows == 1) {
        alert('Se modifico el color')
    }
    
}

if (new URLSearchParams(window.location.search).get('idColor')) {

    console.log('Hola');
    
    
    MostrarColores(new URLSearchParams(window.location.search).get('idColor'))

    const btnFinalizar = document.getElementById('finalizar')

    btnFinalizar.setAttribute('onclick', 'ModificarColor()')

    const btnSubirImagen = document.getElementById('image')

    //btnSubirImagen.setAttribute('enctype', 'NuevaImagen(this)')
    //btnSubirImagen.removeAttribute('onchange')
}