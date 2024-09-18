

async function mostrar_productos() {
    
    const lista = document.getElementById('lista')

    try {
        
        const response = await fetch('/auth/mostrarProductos')
        const data = await response.json()

        console.log(data);

        data.forEach(element => {
            
            const punto = document.createElement('li')
            punto.textContent = element.descripcion + ', ' + element.precio + ', ' + element.variantes + ', ' + element.estado
            lista.appendChild(punto)

            const ulr = window.location.pathname
            console.log(ulr.substring(1));

            if (urlencoded.substring(1) == 'inventario') {

                const estatus = document.createElement('select')
                punto.textContent += estatus

                
            }
            
        });
        

    } catch (error) {
        console.log(error);
        
    }
}



mostrar_productos()