async function MostrarDatos(id) {
    
    console.log(id);
    
    const response = await fetch('/auth/mostrarProductos')
    const data = await response.json()

    const responseC = await fetch('/auth/colores?id=' + id)
    const dataC = await responseC.json()

    data.forEach(async element => {

        if (element.id == id) {
            
            const nombre = document.getElementById('nombre')
            const precio = document.getElementById('precio')
            const tipo = document.getElementById('tipo')
            const estado = document.getElementById('estatus')
            const colores = document.getElementById('colores')

            nombre.value = element.descripcion
            precio.value = element.precio
            tipo.value = element.idTipo
            estado.value = element.estado

            dataC.row.forEach((elementC,indice) => {
                
                if (elementC.id == dataC.rows[indice].idColor) {
                    
                    const fila = document.createElement('li')

                    const label = document.createElement('label')
                    label.textContent = elementC.nombre
                    label.classList.add('colores')
                    label.setAttribute('color', elementC.id)

                    const btn = document.createElement('button')
                    btn.textContent = 'eliminar'
                    label.appendChild(btn)

                    fila.appendChild(label)
                    btn.setAttribute('onclick', 'EliminarColor(this)')

                    colores.appendChild(fila)
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

function EliminarColor(params) {
    

    console.log(params);
    

    params.parentNode.parentNode.remove()

}

if (new URLSearchParams(window.location.search).get('idProducto')) {
    
    MostrarDatos(new URLSearchParams(window.location.search).get('idProducto'))

    const btnFinalizar = document.getElementById('finalizar')

    btnFinalizar.setAttribute('onclick', 'ModificarProducto()')
}