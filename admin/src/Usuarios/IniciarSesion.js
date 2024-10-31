async function IniciarSesion(params) {

    
    
    
    const correo = document.getElementById('correo')
    const pass = document.getElementById('pass')

    const response = await fetch(`/auth/login?correo=${correo.value}&pass=${pass.value}`)
    const data = await response.json()

    console.log(data);
    
    console.log(data.row[0].resultado);

    if (data.row[0].resultado === 1) {
        
        localStorage.setItem('token', data.token)
        //window.location.href = 'https://localhost/bienvenida'
    }

    //params.preventDefault()
    
}