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

    if (id == 'todo') {

        if (boton.classList.value == 'btn_lista_carrito_2') {
            
            
        } else {
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

function ObtenerTotalPagar() {
    
    const cantidad = document.querySelectorAll('.num_productos_input')
    const precios = document.querySelectorAll('.txt_carta_carrito_precio')

    let acumulado = 0

    precios.forEach((element, indice) => {

        const precio = parseFloat(element.querySelector('a').textContent)
        const can = parseFloat(cantidad[indice].value)


        acumulado += precio * can
    })

    return acumulado
}

function COntrolarBotonPago() {
    
    const acumulado = ObtenerTotalPagar()

    const btnPagar = document.querySelector('.btn_lista_carrito_1')
    console.log(acumulado);
    
    btnPagar.innerHTML = `Pagar Pedido-Total: ${acumulado} MXN`
}

async function RealizarCompra(boton) {
    

    if (document.querySelectorAll('.carta_carrito').length > 0 && localStorage.getItem('sesion')) {
        
            try {
            
                const response = await fetch('/auth/venta', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        idSesion: localStorage.getItem('sesion'),
                        token: localStorage.getItem('token')    
                    })
                })
            
                const data = await response.json()
                console.log(data);
                
                console.log(data.existe[0].existe);

                if (data.existe[0].existe == 0) {
                    
                    if(confirm('Tu no tienes tus datos de cliente,\n¿Quieres registrar tus datos de cliente?')) {

                        const comprar = 1
                        const frame = document.querySelector('iframe')
                        localStorage.setItem('pag', '/datos')
                        frame.src = `/datos?comprar=${comprar}`
                    }
                } else  if (data.existe[0].existe == 1 && data.row[2].affectedRows >= 1) {
                    BorrarProducto(boton)
               }
                
            } catch (error) {
                
            }
        
    }   
}

// Escuchando el evento del click del botón de pago dapp
document.getElementById('dapp-btn').addEventListener('click', async function()
{

    const total = ObtenerTotalPagar()
    let email
    let folio
    
    try {
        
        const response = await fetch('/auth/venta', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                idSesion: localStorage.getItem('sesion'),
                token: localStorage.getItem('token')    
            })
        })

        const data = await response.json()

        console.log(data.row[1][0]);

        const fecha = new Date()
        console.log(fecha);
        
        

        email = data.row[0][0]
        folio = data.row[1][0].id
        

    } catch (error) {
        
    }

    DappPayButton({
        production: false,
        client: {
            key: 'tiendapeople01' //apiKey
        },
        transaction: {
            amount: {
            total: total,// total a pagar en MXN
            },
            reference: email, // referencia del pago
            description: folio, //descripcion del pago
        },
        onSuccess: function(transaction) {
            /*
            Si el pago es satisfactorio este callback maneja la respuesta.
            Se devuelve un objeto con la siguiente estructura:
            {
            "id": "28e62e93-c26b-4c26-a25b-7aea2bbbfbad",
            "amount": 10,
            "tip": 0,
            "currency": "MXN",
            "reference": "Texto de referencia",
            "description": "Descripción del pago",
            "client": {
            "name": "Javier Torres"
        },
        "date": "2018-03-28T06:24:49.167657+00:00",
        "code": "XM5BOqZ6"
        }
        */
        //Este es un ejemplo para mostrar algunos de los valores devuelto

            console.log("Transaccion: " + transaction.id);
            console.log("Monto: " + transaction.amount);
        },
        onFailure: function(error) {
            /*
            Si el pago no es exitoso este callback maneja la respuesta.
            Se devuelve un objeto con la siguiente estructura:
            {
            rc: -10,
            msg: "El usuario cerro la ventana antes de completar el pago"
            }
            */
            //Este es un ejemplo para mostrar algunos de los valores devuelto
            s
            console.log(error.msg);
        }
    }).render();
});


