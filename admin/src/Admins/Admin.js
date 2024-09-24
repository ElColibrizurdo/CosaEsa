async function MostrarUsuarios() {
    
    try {
        
        const response = await fetch('/auth/mostrarUsuarios')
        const data = await response.json()

        console.log(data);
        
        const lista = document.getElementById('lista')

        data[0].forEach(element => {
            
            console.log(element);
            

            const elemento = document.createElement('li')
            const opciones = document.createElement('select')
            opciones.id = element.id
            opciones.setAttribute('onClick', 'Opciones(this)')

            const acciones = `
                <option value="eliminar">Eliminar</option>
                <option value="editar">Editar ROl</option>
            `
            opciones.innerHTML = acciones

            
            elemento.textContent = element.name + ' - ' + element.role + ' - ' + element.fechaAlta
            elemento.appendChild(opciones)

            
            lista.appendChild(elemento)
        });

    } catch (error) {
        console.log(error);
        
    }
}

async function Opciones(params) {
    
    if (params.value == 'eliminar') {
        
        try {
            
            const response = await fetch(`/auth/eliminarColaborador?id=${params.id}`)

            const data = await response.json()

            console.log(data);
            

        } catch (error) {
            console.log(error);
            
        }
    }
}

MostrarUsuarios()