function AumentarDisminuir(boton) {
    
    const tipo = boton.getAttribute('tipo')
    const label = document.querySelector('[tipos="' + tipo + '"]')

    var cantidad = parseInt(label.textContent)

   if (boton.textContent === '+') {
    cantidad += 1
   } else if (boton.textContent === '-' && cantidad != '0') {
    cantidad -= 1
   }

   ModificarBase(cantidad, boton.getAttribute('elej'))
   label.textContent = cantidad
}

async function ModificarBase(cantidad, id) {
    

    try {
        
        const response = await fetch('/auth/modificar', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({cantidad, id})
        }) 

        const data = await response.json()
        console.log(data);

    } catch (error) {
        console.log(error);
    }
}

async function BorrarProducto(boton) {

    const id = boton.getAttribute('elej')

    try {

        const response = await fetch('/auth/eliminar', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({id})
        })

        if (response.ok) {
            
            var hijo = boton

            for (let i = 0; i <= 3; i++) {
                
                hijo = hijo.parentNode
                
            }

            console.log(hijo);
            hijo.remove()
        }
        const data = response.json();
        console.log(response);
        
    } catch (error) {
        console.log(error);
    }
}

