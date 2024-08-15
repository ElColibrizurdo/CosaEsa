function AumentarDisminuir(boton) {
    
    const tipo = boton.getAttribute('tipo')
    const label = document.querySelector('[tipos="' + tipo + '"]')

    var cantidad = parseInt(label.value)

   if (boton.getAttribute('signo') === '+') {
    cantidad += 1
   } else if (boton.getAttribute('signo') === '-' && cantidad != '0') {
    cantidad -= 1
   }

   ModificarBase(cantidad, parseInt(boton.getAttribute('elej')))
   label.value = cantidad
}

async function ModificarBase(cantidad, id) {
    
    console.log(cantidad, id);

    try {
        
        const response = await fetch('/auth/modificar', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({cantidad, id})
        }) 

        const data = await response.json()

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

            ObtenerCantidadCanasta()
            
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

function RealizarCompra() {
    
    const cartas = document.querySelectorAll('.carta_carrito')

    cartas.forEach(element => {

        
    })
}


