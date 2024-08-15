document.addEventListener('codigoTerminado',  function() {
    
    const btn_agregar = document.querySelector('.btn_pedido')

    btn_agregar.addEventListener('click', function () {

        if (confirm('agregar a la cesta?')) {
            
            AgregarProducto()
        }
        
    })

   
});

async function AgregarProducto() {
    
    const sesion = localStorage.getItem('sesion');
    const params = new URLSearchParams(window.location.search)
    const id = params.get('id')
    const label_contador = document.querySelector('.label-cantidad')
    let numero = []
    let nombre = []
    const talla = []
    const precio = document.getElementById('label-precio').getAttribute('precio')

    const cantidad_perso = DeterminarPersonalizados()

    cantidad_perso.forEach(element => {

        talla.push(DeterminarTallas(element, label_contador.value))
        console.log(element.querySelector('#numero'));

        console.log(element.querySelector('[type="number"]'));
        

        if (element.querySelector('[type="number"]')) {
            
            numero.push(element.querySelector('[type="number"]').value)
        
        } else {
            numero.push('')
        }
    
        if (element.querySelector('[type="text"]')) {
            
            nombre.push(element.querySelector('[type="text"]').value)
        } else {
    
            nombre.push('')
        }
    })
   
    console.log(numero);
    console.log(nombre);
            try {
                const response = await fetch('/auth/agregar', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify( {
                        cantidad: label_contador.value,
                        id: sesion,
                        id_producto: id,
                        numero: numero,
                        nombre: nombre,
                        precio: precio,
                        talla: talla
                    })
                })
        
                const data = await response.json();

                console.log(data.message);
                
                
                if (data.message === 'ok') {
                    window.parent.location.reload()
                } else {
                    console.log(data.message);   
                }
            } catch (error) {
                
                console.log(error);   
            }
}



function parseJwt(token) {
    const base64Url = token.split('.')[1];
    const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
    const jsonPayload = decodeURIComponent(atob(base64).split('').map(function(c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));
    return JSON.parse(jsonPayload);
}

function DeterminarTallas(element, contador) {
    
    console.log(contador);
    const radio = element.querySelectorAll('[name="radio' + contador + '"]')

    console.log(radio);

    const radiorray = Array.from(radio)


        for (const element of radiorray) {
            if (element.checked) {
                return element.id.charAt(element.id.length - 1)
            }
        }
 
        return 1
}

function DeterminarPersonalizados() {
    
    const contenedores_personalizadas = document.querySelectorAll('.contenedor_descripcion_producto_pedido_personalizacion')
    console.log(contenedores_personalizadas.length);

    if (contenedores_personalizadas.length == 0) {
        
        const valores = document.querySelectorAll('.contendor_descripcion_producto_pedido_cantidad')
        console.log(valores);
        return valores

    } else {
        return contenedores_personalizadas
    }
    
   
}
