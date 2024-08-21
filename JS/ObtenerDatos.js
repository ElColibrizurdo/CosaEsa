async function ObtenerDatos(event) {

    
    console.log('empecemos');
    
    try {
        
        const response = await fetch('/auth/regcliente', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                sesion: localStorage.getItem('sesion'),
                nombre: document.getElementsByName('nombre')[0].value,
                primerApellido: document.getElementsByName('apePaterno')[0].value,
                segundoApellido: document.getElementsByName('apeMaterno')[0].value,
                calle: document.getElementsByName('calle')[0].value,
                numExterior: document.getElementsByName('numExterior')[0].value,
                numInterior: document.getElementsByName('numInterior')[0].value,
                colonia: document.getElementsByName('colonia')[0].value,
                codigo: document.getElementsByName('codigo')[0].value,
                entidad: document.getElementsByName('entidad')[0].value,
                pais: document.getElementsByName('pais')[0].value,

            })
        })

        const data = await response.json()

        console.log(data);

        console.log(data);
    } catch (error) {
        console.log(error);
    }
}

async function ComprarProductos () {
    console.log('Vamos a registrar');
    
    ObtenerDatos()
            console.log('Vamos a comprar');
            
            
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
            parent.ObtenerCantidadCanasta()
            window.location.reload()
            console.log(data.existe[0].existe);
}


async function DeterminarExistenciaCliente() {

    const solicitud = document.querySelector('#div-solicitud')

    
    try {
        const response = await fetch(`/auth/existe?token=${localStorage.getItem('token')}`)

        const data = await response.json()
        console.log(data);
        

        if (data.row[0].EXISTE == 1) {

            const form = document.querySelector('.form')
            ClienteEncontrado(data)

        } else {

            const form = document.querySelector('.form')
        }


    } catch (error) {
        console.log(error);
        solicitud.style.display = 'none'
    }
    
    
}

function ClienteEncontrado(data) {

    
    
    const mod = document.createElement('input')
    mod.type = 'checkbox'
    mod.id = 'solictud'
    mod.onchange = function (event) {
        ActivarDesactivar(mod)
    }
    console.log(mod);
    
    const form = document.querySelector('.form')

    form.appendChild(mod)
    
    document.getElementsByName('nombre')[0].value = data.cliente[0].nombre
    document.getElementsByName('apePaterno')[0].value = data.cliente[0].primerApellido
    document.getElementsByName('apeMaterno')[0].value = data.cliente[0].segundoApellido
    document.getElementsByName('calle')[0].value = data.cliente[0].calle
    document.getElementsByName('numExterior')[0].value = data.cliente[0].numeroExterior
    document.getElementsByName('numInterior')[0].value = data.cliente[0].numeroInterior
    document.getElementsByName('colonia')[0].value = data.cliente[0].colonia
    document.getElementsByName('codigo')[0].value = data.cliente[0].codigoPostal
    document.getElementsByName('municipio')[0].value = data.cliente[0].municipio
    document.getElementsByName('entidad')[0].value = data.cliente[0].entidadFederativa
    document.getElementsByName('pais')[0].value = data.cliente[0].pais
    
    document.getElementsByName('nombre')[0].disabled = true
    document.getElementsByName('apePaterno')[0].disabled = true
    document.getElementsByName('apeMaterno')[0].disabled = true
    document.getElementsByName('calle')[0].disabled = true
    document.getElementsByName('numExterior')[0].disabled = true
    document.getElementsByName('numInterior')[0].disabled = true
    document.getElementsByName('colonia')[0].disabled = true
    document.getElementsByName('codigo')[0].disabled = true
    document.getElementsByName('municipio')[0].disabled = true
    document.getElementsByName('entidad')[0].disabled = true
    document.getElementsByName('pais')[0].disabled = true
}

async function ActivarDesactivar(boton) {

    console.log(boton);
    
    
    let respuesta

    if (boton.checked ) {
        
        console.log('hola');
        
        respuesta = prompt("Contraseña")
    }

    try {
        const token = localStorage.getItem('token')
        
        const response = await fetch(`/auth/verificar?pass=${respuesta}&sesion=${token}`)

        const data = await response.json()

        const fomr = document.querySelector('.form')

            const inputs = fomr.querySelectorAll('input')
            const selects = document.querySelectorAll('select')
        
        if (data == true) {

            if (boton.checked) {
                inputs.forEach(element => {

                    element.disabled = false
                    if (element.name == 'card') {
                        element.value = ''
                    }
                })
                selects.forEach(element => {
                    element.disabled = false
                    
                })

            } 
        } else {

            DeterminarExistenciaCliente()
        }
        

    } catch (error) {
        console.log(error);
        
    }

    
}

const paramas = new URLSearchParams(window.location.search)

console.log(paramas.get('comprar'));
console.log(new URLSearchParams(window.location.search).get('comprar'));

document.querySelector('.atras').addEventListener('click', function () {
    
    history.back()
})

DeterminarExistenciaCliente()