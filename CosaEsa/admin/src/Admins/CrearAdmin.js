
const formulario = document.getElementById('form')

formulario.addEventListener('submit', async function (event) {

    event.preventDefault()
    
    const formData = event.target

    console.log(formData.fecha.value);
    
    
    try {

        const pantallaCarga = document.getElementById('carga')
        pantallaCarga.classList.remove('d-flex')
        
        const response = await fetch('/auth/agregarColaborador', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                nombre: formData.nombre.value,
                pass: formData.contra.value,
                apePa: formData.apePa.value,
                apeMa: formData.apeMa.value,
                email: formData.email.value,
                fecha: formData.fecha.value
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
})