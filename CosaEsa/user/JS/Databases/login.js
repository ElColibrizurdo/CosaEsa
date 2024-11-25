


function seleccion(event) {
    event.preventDefault();
        
    const inputEmail = document.getElementById('validationCustom01')
    const inputPass = document.getElementById('validationCustom02')

    log(inputEmail, inputPass)

}


async function log(inputEmail, inputPassword) {
    
    const email = inputEmail.value
    const password = inputPassword.value

    const userAgent = navigator.userAgent

    try {

    
        const response = await fetch('/auth/loginar', {
    
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ email , password, userAgent})
        });
    
        const data = await response.json();

        if (data.message) {
            alert(data.message)
        }
        
        const idS = data.set.id
        console.log(data.token);
        
        const params = new URLSearchParams(window.location.search)
        console.log(params.size);
        
        console.log('idSesion ' + idS);
        
    
        localStorage.setItem('sesion', idS)
        localStorage.setItem('name', data.name)
        localStorage.setItem('token', data.token)
    
        if (response.ok) {

            if (params.get('id_producto')) {

                console.log('Vamos a agregar a la canasta');
                

                const params = new URLSearchParams(window.location.search)
                const cantidad = params.get('cantidad')
                
                const numeros = params.get('numero')
                const nombres = params.get('nombre')
                const tallas = params.get('talla')

                const numero = numeros.split(',')
                const nombre = nombres.split(',')
                const talla = tallas.split(',')
                const precio = params.get('precio')
                const color = params.get('color')
                

                try {
                    const response = await fetch('/auth/agregar', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify( {
                            cantidad: cantidad,
                            id: localStorage.getItem('sesion'),
                            id_producto: params.get('id_producto'),
                            numero: numero,
                            nombre: nombre,
                            precio: precio,
                            talla: talla,
                            color: color
                        })
                    })
            
                    const data = await response.json();
                    console.log(data);
                    
                    console.log(data.message);
                    
                    
                } catch (error) {
                    
                    console.log(error);   
                }
            }
            
            console.log('Respuesta del servidor: ', data);

            console.log(params.get('like'));
            
            
            if (params.get('like')) {
                
                window.location.href = '/?like=' +  params.get('like')
            } 

            fetch('/protected', {
                method: 'GET',
                headers: {
                    'Authorization': 'Bearer ' + data.token 
                }
            })
            .then(response => response.text())
            .then(data => {
                console.log(data);
                console.log('Hola');
                window.location.href = '/tienda'
                
            })
            .catch(error => {
                console.log(error);
            })

            console.log('hwllow');
            console.log(res);
        }else {

            alert(data.message)
            inputEmail.value = ''
            inputPassword.value = ''
        }
        
    } catch (error) {
        console.error('Error al registrar ususarios: ', error.message);
    }

        
}

document.querySelector('.atras').addEventListener('click', function () {
    
    window.parent.location.href = '/'
})


function Validar_Email (email) {

    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

function Inicio() {
    
    const params = new URLSearchParams(window.location.search)

    console.log(params.get('like'));
    
    if (params.get('like')) {
        
        const btn_registro = document.querySelector('.link_registrarse')
        btn_registro.href = '/registro?link=' + params.get('like')
    }

    if (params.get('id_producto')) {
        
        const btn_registro = document.querySelector('.link_registrarse')
        console.log(window.location.search.substring(1));
        btn_registro.href = '/registro?' + window.location.search.substring(1)
         
    }
}

async function CambiarContra() {

    const email = prompt('Introduce el correo electronico')
    console.log(email);
    
    try {
        
        const response = await fetch('/auth/correo', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({email})
        })

        const data = await response.json()

        console.log(data);
        
    } catch (error) {
        
        console.log(error);
        
    }

}

function CambiarPass() {
    
    const input = document.getElementById('validationCustom02')
    const pass = input.type === 'password'

    input.type = pass ? 'text' : 'password'
    
}

Inicio()