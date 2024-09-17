function MostrarVariantes(event, params) {

    if (event.key == 'Enter') {
        
        event.preventDefault()
        
        console.log(params.value);
        console.log('Presionada');
        
        const fila = document.createElement('li')
        const label = document.createElement('label')
        const btn = document.createElement('button')
        btn.textContent = 'eliminar'

        label.textContent = params.value
        label.appendChild(btn)

        params.value = ''
        
        fila.appendChild(label)
        btn.setAttribute('onclick', 'RemoverVariante(this)')

        const lista = document.getElementById('variantes')
        lista.appendChild(fila)

    }
}

function MostrarColores(params) {

    const fila = document.createElement('li')

    const label = document.createElement('label')
    label.textContent = params.value

    const btn = document.createElement('button')
    btn.textContent = 'eliminar'
    label.appendChild(btn)

    fila.appendChild(label)
    btn.setAttribute('onclick', 'RemoverVariante(this)')

    params.nextElementSibling.appendChild(fila)
    
}

function SubirImagen(params) {
    
    console.log(params.files[0]);
    
    const formData = new FormData()
    formData.append('image', params.files[0])

    fetch('/upload', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())  // Si esperas texto en la respuesta
    .then(result => {
        console.log('Resultado:', result);  // Imprimir el resultado del servidor
        // Aquí puedes manejar la respuesta, por ejemplo mostrar la imagen subida:
        document.body.innerHTML += result; // Mostrar la URL de la imagen
    })
    .catch(error => {
        console.error('Error al subir la imagen:', error);
    });

    const img = document.createElement('img')
    img.src = URL.createObjectURL(params.files[0])
    img.style.maxWidth = '200px'

    const label = document.createElement('label')
    label.appendChild(img)

    const btn = document.createElement('button')
    btn.textContent = 'eliminar'
    label.appendChild(btn)

    const fila = document.createElement('li')
    fila.appendChild(label)
    btn.setAttribute('onclick', 'RemoverVariante(this)')

    params.nextElementSibling.appendChild(fila)
}

function RemoverVariante(params) {
    
    params.parentNode.parentNode.remove()
    
    
}