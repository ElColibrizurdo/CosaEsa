async function CambiarEstado(params) {
    
    console.log(params.parentNode);
    
    console.log(params.parentNode.getAttribute('lista'));
    

    const response = await fetch('/auth/cambiarEstado', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            id: params.parentNode.getAttribute('lista'),
            estado: params.value 
        })
    })

    const data = await response.json()

    console.log(data);
    
}