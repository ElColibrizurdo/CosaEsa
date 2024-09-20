

async function mostrar_productos() {
    
    const lista = document.getElementById('lista')

    try {
        
        const response = await fetch('/auth/mostrarProductos')
        const data = await response.json()


        data.forEach(element => {
            
            const punto = document.createElement('li')
            punto.setAttribute('lista', element.id)
            
            
            lista.appendChild(punto)

            const ulr = window.location.pathname

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

                
            } else if (ulr.substring[1] == 'productos') {
             
                punto.textContent = element.descripcion + ', ' + element.precio + ', ' + element.variantes + ', ' + element.estado
            }
            
        });
        

    } catch (error) {
        console.log(error);
        
    }
}





mostrar_productos()