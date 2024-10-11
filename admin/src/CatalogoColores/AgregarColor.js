async function AgregarColor() {

    const form = document.getElementById('form')

    const formData = new FormData(form)

    const responde = await fetch('/auth/agregarColor', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            nombre: formData.get('nombre'),
            color: formData.get('color')
        })
    })


    const data = await responde.json()

    console.log(data);
    

}