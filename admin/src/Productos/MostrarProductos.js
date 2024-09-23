

async function mostrar_productos() {
    
    const lista = document.getElementById('lista')

    try {
        
        const response = await fetch('/auth/mostrarProductos')
        const data = await response.json()


        data.forEach(element => {
            
            const punto = document.createElement('li')
            punto.setAttribute('lista', element.id)
            
            console.log(element);
            
            lista.appendChild(punto)

            const ulr = window.location.pathname
            console.log(ulr.substring(1));
            

            if (ulr.substring(1) == 'inventario') {

                punto.textContent = element.descripcion + ', ' + element.variantes 

                const estatus = document.createElement('select')
                
                
                const opciones = `
                    <option value="1">Disponible</option>
                    <option value="11">Agotado </option>
                    <option value="0">Preventa</option>
                `

                estatus.innerHTML = opciones
                console.log(opciones.value);
                
                estatus.value = element.estado
                
                console.log(element.estado);
                
                
                punto.appendChild(estatus)
                estatus.setAttribute('onchange', 'CambiarEstado(this)')  

                
            } else {
             
                const estado = {
                    0: 'preventa',
                    1: 'disponible',
                    11: 'agotado'
                }
                
                punto.textContent = element.descripcion + ', ' + element.precio + ', ' + element.variantes + ', ' + (estado[element.estado] || (() => console.log('ntp')));

                const acciones = document.createElement('select')
                acciones.setAttribute('onclick', 'Acciones(this)')

                const accOpciones = `
                    <option value="editar">Editar Producto</option>
                    <option value="eliminar" >Eliminar</option>
                `

                acciones.innerHTML += accOpciones
                punto.appendChild(acciones)

                
            }
            
        });
        

    } catch (error) {
        console.log(error);
        
    }
}

async function Acciones(params) {
    
    if (params.value === 'editar') {
        
        

    } else if (params.value === 'eliminar') {

        console.log(params.parentNode.getAttribute('lista'));
        
        
        const response = await fetch('/auth/eliminarProducto', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                id: params.parentNode.getAttribute('lista')
            })
        })

        const data = await response.json()
        console.log(data.affectedRows);

        if (data.affectedRows == 1) {
            
            params.parentNode.remove()
        }
        
    }
}



mostrar_productos()