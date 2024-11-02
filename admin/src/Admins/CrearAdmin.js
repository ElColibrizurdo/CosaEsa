async function CrearColaborador() {
    
    const email = document.getElementById('correo')
    const nombre = document.getElementById('nombre')
    const apellido = document.getElementById('apellido')
    const contra = document.getElementById('contra')

    console.log(email);
    

    try {
        
        const response = await fetch('/auth/agregarColaborador', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                nombre: nombre.value,
                pass: contra.value,
                ape: apellido.value,
                email: email.value
            })
        })

        const data = await response.json()

        console.log(data);
        
        if (data[0][0].affectedRows == 1) {
            window.location.href = '/admins'
        }

    } catch (error) {
        console.log(error);
        
    }
}