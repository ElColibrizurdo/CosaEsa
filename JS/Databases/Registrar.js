
function RegistrarUsuarios(event) {
    event.preventDefault()

    console.log(event);

    console.log(event.target[0].value);
    
    const nombreApellido = document.getElementById('validationCustom01').value
    const Apodo = document.getElementById('validationCustom02').value
    const email = document.getElementById('validationCustom03').value
    const fechaNa = document.getElementById('validationCustom04').value
    const password = document.getElementById('validationCustom05').value
    const password2 = document.getElementById('validationCustom06').value

    console.log(fechaNa);
    
    const nombreSeparado = SepararNombrePila(nombreApellido)

    if(ValidarContrasenia(password, password2)) {

        reg(Apodo, nombreSeparado[0], nombreSeparado[1], nombreSeparado[2], email, password, fechaNa)
    }

}

async function reg(apodo, nombre, apellidoP, apellidoM, email, password, fechaNa ) {


        try {
        
            const response = await fetch('/auth/register', {
    
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({apodo, nombre, apellidoP, apellidoM, email, password, fechaNa})
            });
    
            const data = await response.json();

            console.log(response);
    
            if (response.ok) {
                
                console.log('Respuesta del servidor: ', data);
                if (params.get('like')) {
                
                    window.location.href = '/login?like=' +  params.get('like')
                } 

                if (params.get('id_producto')) {
                    
                    window.location.href = '/login?' + window.location.search.substring(1)
                }
                window.location.href = '/login'

            } else {
                
                console.log('Error', data.message);
            }
        } catch (error) {
            console.error('Error al registrar ususarios: ', error.message);
        }
    }

function ValidarContrasenia(contra, cotra2) {
    
    if (contra === cotra2) {
        
        return true
    } else {

        return false
    }
}

function FormatoFech(fecha) {
    
    const dia = fecha.getDate().toString().padStart(2, '0')
    const mes = (fecha.getMonth() + 1).toString().padStart(2, '0')
    const anio = fecha.getFullYear()
}

function SepararNombrePila(nombre) {
    
    const caracteres = nombre.split(' ')
    console.log(caracteres);
    return caracteres
}

document.querySelector('.atras').addEventListener('click', function () {
    
    window.parent.location.href = '/'
})