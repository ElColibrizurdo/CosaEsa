

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
        const idS = data.set.id
        const params = new URLSearchParams(window.location.search)
        console.log(params.size);
        
        console.log('idSesion ' + idS);
        
    
        localStorage.setItem('sesion', idS)
        localStorage.setItem('name', data.name)
    
        if (response.ok) {
            
            console.log('Respuesta del servidor: ', data);

            /*if (params.size) {

                console.log('paso');


                const like = await fetch('/auth/like', {
                    method: post,
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({ 
                        number: params.size,
                        sesion: idS,
                        estado: 0
                     })
                }) 
    
                const data_like = await like.json()
    
                console.log(data_like);
            }*/

           
            console.log(params.get('like'));
            

            window.location.href = '/?like=' +  params.get('like')
            fetch('/protected', {
                method: 'GET',
                headers: {
                    'Authorization': 'Bearer ' + token 
                }
            })
            .then(response => response.text())
            .then(data => {
                console.log(data);
            })
            .catch(error => {
                console.log(error);
            })

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



function Validar_Email (email) {

    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}