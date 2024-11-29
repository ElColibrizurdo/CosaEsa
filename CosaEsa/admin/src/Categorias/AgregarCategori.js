async function AgregarCategoria(params) {

    const form = document.getElementById('form')

    const formData = new FormData(form)

    const responde = await fetch('/auth/agregarCategoria', {
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
        
        alert('Se subio la categoria')
        SubirImagen(formData.get('nombre'))
    }

}

function SubirImagen(nombre) {

    console.log(nombre);
    

    const image = document.getElementById('image')
    
    const formData = new FormData()
    formData.append('id', nombre)
    formData.append('image', image.files[0])

    console.log(image.files);
    

    fetch('/upload', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())  // Si esperas texto en la respuesta
    .then(result => {
        console.log('Resultado:', result);  // Imprimir el resultado del servidor
        // Aquí puedes manejar la respuesta, por ejemplo mostrar la imagen subida:
         // Mostrar la URL de la imagen
    })
    .catch(error => {
        console.error('Error al subir la imagen:', error);
    });

    
}

function MostrarImagen(params) {

    const existe = document.getElementById('logo')

    if (existe) {
        
        existe.setAttribute('nombre', params.files[0])

        const img = document.querySelector('img')
        img.src = '../img/tallas/' + params.files[0].name

    } else {

        const fila = document.createElement('li')

        fila.setAttribute('nombre', params.files[0])
        document.body.innerHTML += params.files[0]
        fila.id = 'logo'
        fila.classList.add('fila')
        
        const label = document.createElement('label')

        const img = document.createElement('img')
        img.src = '../img/tallas/' + params.files[0].name

        const btn = document.createElement('button')
        btn.textContent = 'eliminar'

        label.appendChild(img)
        label.appendChild(btn)

        
        fila.appendChild(label)
        btn.setAttribute('onclick', 'RemoverImage(this)')

        const lista = document.getElementById('lista')
        console.log(fila);
        
        lista.appendChild(fila)
    }
    
    
}

function RemoverImage(params) {

    console.log(params.nodeParents);
    const image = document.getElementById('image')
    image.value = ''

    
}