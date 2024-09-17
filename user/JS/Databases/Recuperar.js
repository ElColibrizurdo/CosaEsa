async function RecuperarContra(event) {
    event.preventDefault()

    const form = event.target;

    
    if (form.pass1.value === form.pass2.value) {
        
        try {
        
            const response = await fetch('/auth/correo', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    email: form.email.value,
                    pass: form.pass2.value
                })
            })
    
            const data = await response.json()
    
            if (data.message == 'ok') {
                
                alert('Recuerda verificar el correo mandado')
                window.parent.location.href = '/login'
            } else {

                alert(data.message)
            }
            console.log(data);
            
        } catch (error) {
            
            console.log(error);
            
        }
        
    }
}