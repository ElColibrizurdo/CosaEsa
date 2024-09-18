async function MostrarCategorias() {
    
    const response = await fetch('/auth/categorias')
    const data = await response.json()
    
    const lista = document.getElementById('categorias')

    data.forEach(element => {
        
        console.log(element.activo.data.toString());
        console.log(element);
        
        

        const label = document.createElement('label')
        label.textContent = element.nombre + ' - ' + element.cantidad + ' - ' + (element.activo.data.toString() === '1' ? 'Activo' : 'Inactivo') 

        const fila = document.createElement('li')
        fila.appendChild(label)

        lista.appendChild(fila)
    });
    
}

MostrarCategorias()