
const nombre = document.getElementById('nombre')
const precio = document.getElementById('precio')
const stock = document.getElementById('stock')
const tipo = document.getElementById('tipo')
const estado = document.getElementById('estatus')
const equipo = document.getElementById('equipos')
const jugador = document.getElementById('jugadores')
const colores = document.getElementById('listaColores')

async function MostrarDatos(id) {
    
    console.log(id);
    
    const response = await fetch('/auth/mostrarProductos')
    const data = await response.json()

    const responseC = await fetch('/auth/colores?id=' + id)
    const dataC = await responseC.json()

    console.log(dataC);
    
    

    data.forEach(async element => {

        

        if (element.id == id) {


            console.log(element);
            

            nombre.value = element.descripcion
            precio.value = element.precio
            tipo.value = element.idTipo
            estado.value = element.estado
            stock.value = element.stock
            console.log(equipo);
            console.log(typeof(equipo.value));
            console.log(typeof(element.equipo));
            equipo.value = element.idEquipo
            
            jugador.value = element.idJugador
            

            dataC.rows.forEach((elementC,indice) => {

               try {
                console.log(elementC.idColor);
                console.log(dataC.row[indice].id);
                
                dataC.row.forEach(elementCC => {

                    if (elementC.idColor == elementCC.id) {
                    
                        const fila = document.createElement('li')
    
                        const label = document.createElement('label')
                        label.textContent = elementCC.nombre
                        label.classList.add('colores')
                        label.setAttribute('color', elementCC.id)
    
                        const btn = document.createElement('button')
                        btn.textContent = 'eliminar'
                        label.appendChild(btn)
    
                        fila.appendChild(label)
                        btn.setAttribute('onclick', 'EliminarColor(this)')
    
                        colores.appendChild(fila)
                    }
                }) 

               } catch (error) {
                console.log(error);
                
               }
                
            })

            const responseIMG = await fetch('/auth/recuperarIMG?id=' + id)
            const dataIMG = await responseIMG.json()

            console.log(dataIMG);
            
            

            if (dataIMG) {
                
                dataIMG.forEach(element => {

                    const fila = document.createElement('li')
                    fila.setAttribute('nombre', element.nombre)
                
                    const img = document.createElement('img')
                    img.src = '../img/articulos/' + element.nombre
                    img.style.maxWidth = '70px'

                    const label = document.createElement('label')
                    label.appendChild(img)

                    const btn = document.createElement('button')
                    btn.textContent = 'eliminar'
                    label.appendChild(btn)

                    
                    fila.appendChild(label)
                    btn.setAttribute('onclick', 'RemoverVariante(this)')

                    const lista = document.getElementById('imagenes')
                    lista.appendChild(fila)
                })

                
            }
        }
        
    })
}

async function ModificarProducto() {
    
    try {

        
        const responde = await fetch('/auth/actualizarProducto', {

            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                id: new URLSearchParams(window.location.search).get('idProducto'),
                idTipo: tipo.value,
                descripcion: nombre.value,
                idEquipo: equipo.value,
                idJugador: jugador.value,
                stock: stock.value,
                precio: precio.value,
                estado: estado.value 
            })
        })

        const data = await responde.json()

        console.log(data);

        SubirImagen(new URLSearchParams(window.location.search).get('idProducto'))
        

    } catch (error) {
        console.log(error);
        
    }
}

async function EliminarColor(params) {
    
    console.log(params.parentNode);

    params.parentNode.parentNode.remove()

    try {
        
        const response = await fetch('/auth/quitarColorProducto', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                idProducto: new URLSearchParams(window.location.search).get('idProducto'),
                idColor: params.parentNode.getAttribute('color')
            })
        })

    } catch (error) {
        console.log(error);
        
    }
}

async function NuevaImagen(params) {
    
    try {
        console.log(params.files[0]);
        

        const formData = new FormData()
        formData.append('image', params.files[0])
        formData.append('id', new URLSearchParams(window.location.search).get('idProducto'))
        
        const response = await fetch('/auth/subirImagen', {
            method: 'POST',
            body: JSON.stringify({
                formData
            })
        })

        if (!response.ok) {
            throw new Error(`Error en la solicitud: ${response.status}`);
        }

        const result = await response.json();
        console.log("Imagen subida con éxito:", result);

        location.href() = location.href()

    } catch (error) {
        console.log(error);
        
    }
}

if (new URLSearchParams(window.location.search).get('idProducto')) {
    
    MostrarDatos(new URLSearchParams(window.location.search).get('idProducto'))

    const btnFinalizar = document.getElementById('finalizar')

    btnFinalizar.setAttribute('onclick', 'ModificarProducto()')

    const btnSubirImagen = document.getElementById('image')

    //btnSubirImagen.setAttribute('enctype', 'NuevaImagen(this)')
    //btnSubirImagen.removeAttribute('onchange')
}