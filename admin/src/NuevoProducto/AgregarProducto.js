function MostrarVariantes(event, params) {

    
    console.log(params.options[params.selectedIndex].text);
    console.log(event.type);
    
    const fila = document.createElement('li')
    const label = document.createElement('label')
    const btn = document.createElement('button')
    btn.textContent = 'eliminar'

    if (event.key == 'Enter' ) {
        
        event.preventDefault()
        
        

        label.textContent = params.value
        label.appendChild(btn)

        params.value = ''
        
        fila.appendChild(label)
        btn.setAttribute('onclick', 'RemoverVariante(this)')

        const lista = document.getElementById('variantes')
        lista.appendChild(fila)

    }

    if (event.type == 'click') {
        
        event.preventDefault()

        label.textContent = params.options[params.selectedIndex].text
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

    const fila = document.createElement('li')

    fetch('/upload', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())  // Si esperas texto en la respuesta
    .then(result => {
        console.log('Resultado:', result);  // Imprimir el resultado del servidor
        // Aquí puedes manejar la respuesta, por ejemplo mostrar la imagen subida:
        fila.setAttribute('nombre', result)
        document.body.innerHTML += result; // Mostrar la URL de la imagen
    })
    .catch(error => {
        console.error('Error al subir la imagen:', error);
    });

    const img = document.createElement('img')
    img.src = URL.createObjectURL(params.files[0])
    img.style.maxWidth = '70px'

    const label = document.createElement('label')
    label.appendChild(img)

    const btn = document.createElement('button')
    btn.textContent = 'eliminar'
    label.appendChild(btn)

    
    fila.appendChild(label)
    btn.setAttribute('onclick', 'RemoverVariante(this)')

    params.nextElementSibling.appendChild(fila)
}

function RemoverVariante(params) {
    
    params.parentNode.parentNode.remove()
    
    
}

async function AgregarProducto() {

    const nombres = []
    
    const form = document.getElementById('form')
    console.log(form);
    
    const formData = new FormData(form)
    console.log(formData);

    const imagenes = document.querySelectorAll('[nombre]')
    console.log(imagenes);
    
    imagenes.forEach(element => {

        nombres.push(element.getAttribute('nombre'))
    })
    try {
        
        const responde = await fetch('/auth/agregarProducto', {

            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                nombre: formData.get('nombre'),
                precio: formData.get('precio'),
                tipo: formData.get('tipo'),
                equipo: 1,
                imagenes: nombres
            })
        })
    
        const data = await responde.json()
        console.log(data);

    } catch (error) {
        console.log(error);
        
    }

    
    
}