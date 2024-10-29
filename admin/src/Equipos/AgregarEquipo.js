async function AgregarEquipo() {

    const form = document.getElementById('form')

    const formData = new FormData(form)

    const responde = await fetch('/auth/agregarEquipo', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            nombre: formData.get('nombre')
        })
    })


    const data = await responde.json()

    console.log(data);
    
    if (data.affectedRows == 1) {
        
        SubirImagen(data.insertId)
    }

}

let inpuImage

function SubirImagen(nombre) {
    
    console.log(nombre);
    console.log(inpuImage);
    
    const formData = new FormData()
    formData.append('id', nombre)
    formData.append('images', inpuImage)

    fetch('/upload?equipo', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())  // Si esperas texto en la respuesta
    .then(result => {
        console.log('Resultado:', result);  // Imprimir el resultado del servidor
        // Aquí puedes manejar la respuesta, por ejemplo mostrar la imagen subida:
         // Mostrar la URL de la imagen
         cerrarPage()
    })
    .catch(error => {
        console.error('Error al subir la imagen:', error);
    });
}

function MostrarImagen(params) {
    
    const existente = document.getElementById('logo')

    if (existente) {
    
        console.log(existente);
        

        existente.setAttribute('nombre', params.files[0])
        
        const img = existente.querySelector('img')
        console.log(img);
        
        img.src = '../img/logos/' + params.files[0].name

    } else {

        console.log('holo');
        

        const fila = document.createElement('li')
        fila.id = 'logo'

        fila.setAttribute('nombre', params.files[0])

        const label = document.createElement('label')

        const img = document.createElement('img')
        img.src = '../img/logos/' + params.files[0].name

        const btn = document.createElement('button')
        btn.textContent = 'eliminar'

        label.appendChild(img)
        label.appendChild(btn)

        
        fila.appendChild(label)
        btn.setAttribute('onclick', 'BorrarImagen(this)')

        const lista = document.getElementById('imagenes')
        lista.appendChild(fila)
        
        
    }

    inpuImage = params.files[0]
}

function RemoverImage(params) {

    console.log(params.nodeParents);
    const image = document.getElementById('image')
    image.value = ''

    
}