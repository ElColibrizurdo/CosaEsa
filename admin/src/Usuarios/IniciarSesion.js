async function IniciarSesion() {
    
    const correo = document.getElementById('correo')
    const pass = document.getElementById('pass')

    const response = await fetch(`/auth/login?correo=${correo.value}&pass=${pass.value}`)
    const data = await response.json()

    console.log(data.row[0].resultado);
    
}