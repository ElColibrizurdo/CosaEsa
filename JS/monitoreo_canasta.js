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
        COntrolarBotonPago()

    } catch (error) {
        console.log(error);
    }
}

async function BorrarProducto(boton) {

    let ids = []

    const id = boton.getAttribute('elej')
    console.log(id);

    

    if (id == 'todo') {

         const siNo = confirm('se va a borrar')

         if (siNo) {
            const buttons = document.querySelectorAll('.btn_eliminar')
        
            buttons.forEach(element => {

            ids.push(element.getAttribute('elej'))
        })
         }
        
        

    } else {

        ids.push(boton.getAttribute('elej'))
    }

    console.log(ids);
    

    ids.forEach(async idd => {

        try {

            const response = await fetch('/auth/eliminar', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({id: idd})
            })
    
            if (response.ok) {
    
                ObtenerCantidadCanasta()
                
                var hijo = boton

                if (id == 'todo') {
                    
                    const cartas = document.querySelectorAll('.carta_carrito')

                    cartas.forEach(element => {

                        element.remove()
                    })
                } else {

                    for (let i = 0; i <= 3; i++) {
                    
                        hijo = hijo.parentNode
                        console.log(hijo);
                        
                    }

                    console.log(hijo);
                    hijo.remove()
                }

                COntrolarBotonPago()
            }
            const data = response.json();
            //console.log(response);
    
           
            
        } catch (error) {
            console.log(error);
        }
    })

    
}

function COntrolarBotonPago() {
    
    const cantidad = document.querySelectorAll('.num_productos_input')
    const precios = document.querySelectorAll('.txt_carta_carrito_precio')

    let acumulado = 0

    precios.forEach((element, indice) => {

        const precio = parseFloat(element.querySelector('a').textContent)
        const can = parseFloat(cantidad[indice].value)


        acumulado += precio * can
    })

    const btnPagar = document.querySelector('.btn_lista_carrito_1')
    console.log(acumulado);
    
    btnPagar.innerHTML = `Pagar Pedido-Total: ${acumulado} MXN`
}

function RealizarCompra() {
    
    const cartas = document.querySelectorAll('.carta_carrito')

    const status = confirm('Seguro que quieres comprar estos articulos')

    /*cartas.forEach(element => {


    })*/
}


