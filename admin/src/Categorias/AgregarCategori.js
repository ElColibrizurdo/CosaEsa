async function AgregarCategoria(params) {

    const form = document.getElementById('form')

    const formData = new FormData(form)

    const responde = await fetch('/auth/agregarCategoria', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            nombre: formData.get('nombre')
        })
    })


    const data = await responde.json()

    console.log(data);

    if (data.affectedRows) {
        
        alert('Se subio la categoria')
    }

}