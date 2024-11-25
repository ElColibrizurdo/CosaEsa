

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

async function MostrarColores(params) {

    const opcion = params.options[params.selectedIndex]

    const response = await fetch('/auth/agregarColorProducto', {
        
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            idProducto: new URLSearchParams(window.location.search).get('idProducto'),
            idColor: opcion.getAttribute('color')
        })
    })

    const data = await response.json()    

    const fila = document.createElement('li')

    const label = document.createElement('label')
    label.textContent = params.value
    label.classList.add('colores')
    label.setAttribute('color', params.options[params.selectedIndex].getAttribute('color'))

    const btn = document.createElement('button')
    btn.textContent = 'eliminar'
    label.appendChild(btn)

    fila.appendChild(label)
    btn.setAttribute('onclick', 'RemoverVariante(this)')


    const lista = document.getElementById('listaColores')
    lista.appendChild(fila)
    
}

tempFile = []

function ImagenesTemporales(event) {
    
    tempFile.push(event.target.files[0])

    const fila = document.createElement('li')
    fila.classList.add('fila')

    const filas = document.querySelectorAll('.fila')
    
    fila.setAttribute('fila', filas.length)
    
    const img = document.createElement('img')
    img.src = URL.createObjectURL(event.target.files[0])
    img.style.maxWidth = '70px'

    const label = document.createElement('label')
    label.appendChild(img)

    const btn = document.createElement('button')
    btn.textContent = 'eliminar'
    label.appendChild(btn)

    
    fila.appendChild(label)
    btn.setAttribute('onclick', 'EliminarImagen(event, this)')
    btn.setAttribute('btnFila', filas.length)

    const lista = document.getElementById('imagenes')
    lista.appendChild(fila)
}

function SubirImagen(id) {
    
    console.log(id)
    
    const formData = new FormData()
    formData.append('id', id)

    tempFile.forEach((element,index) => {
        formData.append(`images`, element)
    })
    

    fetch('/upload', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())  // Si esperas texto en la respuesta
    .then(result => {
        console.log('Resultado:', result);  // Imprimir el resultado del servidor
        // Aquí puedes manejar la respuesta, por ejemplo mostrar la imagen subida:
        
        document.body.innerHTML += result; // Mostrar la URL de la imagen
        window.parent.location.href = '/productos'
    })
    .catch(error => {
        console.error('Error al subir la imagen:', error);
    });

    
}

function EliminarImagen(event, params) {
    

    event.preventDefault()

    console.log(params);
    

    const fila = document.querySelector(`[Fila="${params.getAttribute('btnfila')}"]`)
    fila.remove()

    if (new URLSearchParams(window.location.search).get('idProducto')) {

        
    }
    
}

async function RemoverVariante(params) {
    
    console.log(params);
    
    params.parentNode.parentNode.remove()
    const img = new URL(params.previousElementSibling.src)
    console.log(img.pathname);

    const response = await fetch('/auth/eliminarIMG?directorio=' + img.pathname)
    const data = response.json()
    
    console.log(data);
    
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

    const colores = document.querySelectorAll('.colores')
    let coloresID = []

    colores.forEach(element => {
        
        coloresID.push(element.getAttribute('color'))
    })

    console.log(coloresID);
    

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
                coloresID,
                equipo: 1,
                imagenes: nombres,
                equipoP: formData.get('equipos'),
                jugador: parseInt(formData.get('jugadores')),
                stock: parseInt(formData.get('stock')),
                estatus: parseInt(formData.get('estatus'))
            })
        })
    
        const data = await responde.json()
        SubirImagen(data[0].insertId)

    } catch (error) {
        console.log(error);
        
    }

    
    
}

async function ExtraerCategoriasColores() {
    
    const tipos = ""

    const response = await fetch('/auth/categorias?tipo= ' )
    const data = await response.json()

    const seleccion = `<option value="5">---Seleccion---</option>`
    const selector = document.getElementById('tipo')

    selector.innerHTML += seleccion

    data.forEach(element => {

        console.log(element);
        

        const opcion = `
            <option value="${element.id}" >${element.nombre}</option>
        `

        selector.innerHTML += opcion
    })

    const responseC = await fetch('/auth/colores')
    const dataC = await responseC.json()

    const selectorC = document.getElementById('color')

    selectorC.innerHTML += seleccion

    dataC.row.forEach(element => {

        

        const color = `
            <option color="${element.id}" value="${element.nombre}" >${element.nombre}</option>
        `

        
        
        selectorC.innerHTML += color
    })
}

async function ExtraerEquipos() {

    try {
        
        const response = await fetch('/auth/mostrarEquipos')
        const data = await response.json()

        const selector = document.getElementById('equipos')
            
        const seleccion = `<option value="0">---Seleccion---</option>`

        selector.innerHTML += seleccion

        data.forEach(element => {

            const equipo = `<option orden="${element.orden}" value="${element.id}">${element.nombre}</option>`
            
            selector.innerHTML += equipo

            console.log(selector);
            
        })

    } catch (error) {
        
    }
    
    
}

async function ObtenerJugadores() {
    
    try {
        
        const response = await fetch('/auth/obtenerJugadores')
        const data = await response.json()

        console.log(data);


        const selector = document.getElementById('jugadores')
        const seleccion = `<option value="">---Seleccion---</option>`
          
        selector.innerHTML += seleccion

        data.forEach(element => {


            const jugador = `<option value="${element.id}">${element.nombre} ${element.numero} "${element.apodo}"</option>`
            
            selector.innerHTML += jugador
        })
        
        

    } catch (error) {
        console.log(error);
        
    }
}



ExtraerCategoriasColores()
ExtraerEquipos()
ObtenerJugadores()