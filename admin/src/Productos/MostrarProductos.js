async function mostrar_productos() {
    
    const lista = document.getElementById('lista')

    try {
        
        const response = await fetch('/auth/mostrarProductos')
        const data = await response.json()

        console.log(data);

        data.forEach(element => {
            
            const punto = document.createElement('li')
            punto.textContent = element.descripcion + ', ' + element.precio + ', ' + element.estado + ', ' + element.id + ', ' + ', ' + element.variantes
            lista.appendChild(punto)
        });
        

    } catch (error) {
        console.log(error);
        
    }
}



mostrar_productos()