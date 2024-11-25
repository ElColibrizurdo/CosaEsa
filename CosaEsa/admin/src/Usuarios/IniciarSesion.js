async function IniciarSesion() {

    const carga = document.getElementById('carga')

    carga.classList.remove('d-none')

    const correo = document.getElementById('correo')
    const pass = document.getElementById('pass')

    try {
        
        console.log(correo.value);
        console.log(pass.value);


        const response = await fetch(`/auth/login?correo=${correo.value}&pass=${pass.value}`)
        const data = await response.json()

        console.log(data);
    
        console.log(data.row[0].resultado);
        localStorage.setItem('data', data[0])

        if (data.esValido) {
            
            localStorage.setItem('token', data.token)
            carga.classList.add('d-none')
            window.location.href = 'https://localhost/bienvenida'

        } else {

            carga.classList.add('d-none')
        }
    //params.preventDefault()

    } catch (error) {
        console.log(error);
        carga.classList.add('d-none')
        
    }    
}