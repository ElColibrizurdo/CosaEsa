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
        
        console.log('Vamo a comprar');
        
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
// document.getElementById('dapp-btn').addEventListener('click', async function()
// {

//     const total = ObtenerTotalPagar()
//     let email
//     let folio
    
//     try {
        
//         const response = await fetch('/auth/venta', {
//             method: 'POST',
//             headers: {
//                 'Content-Type': 'application/json'
//             },
//             body: JSON.stringify({
//                 idSesion: localStorage.getItem('sesion'),
//                 token: localStorage.getItem('token')    
//             })
//         })

//         const data = await response.json()

//         console.log(data.row[1][0]);

//         const fecha = new Date()
//         console.log(fecha);
        
        

//         email = data.row[0][0]
//         folio = data.row[1][0].id
        

//     } catch (error) {
        
//     }

//     // Credenciales de la API
//     const apiKey = '26743219-8b16-4eb7-98cb-34d3b6f1379d'; // Reemplaza con tu API key
//     const userAgent = 'MiIntegracion1.0'; // Reemplaza con tu nombre de integración

//     // Convertir la clave API para autenticación básica
//     const authHeader = `Basic OjI2NzQzMjE5LThiMTYtNGViNy05OGNiLTM0ZDNiNmYxMzc5ZA==`;

//     // Datos del cuerpo de la solicitud
//     const requestData = {
//     amount: "10.0", // Monto
//     description: "chocolates", // Descripción del cobro
//     qr_source: "8", // Identificador del medio de pago, ej. para Banco Azteca
//     reference: "miReferenciaInterna", // Referencia interna del comercio
//     expiration_minutes: 8640, // Expiración en minutos (6 días)
//     success_page: "https://miapp.com/success", // URL de éxito
//     error_page: "https://miapp.com/error" // URL de error
//     };

//     // Realizar la solicitud POST al endpoint
//     fetch('https://sandbox.dapp.mx/v2/dapp-codes/', {
//     method: 'POST',
//     headers: {
//         'Content-Type': 'application/json',
//         'Authorization': authHeader,
//         'User-Agent': userAgent
//     },
//     body: JSON.stringify(requestData)
//     })
//     .then(response => response.json())
//     .then(data => console.log('Respuesta de la API:', data))
//     .catch(error => console.error('Error al llamar a la API:', error));
// });


