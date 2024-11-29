async function BorrarImagen(event, params) {
    
    event.preventDefault()

    const img = new URL(params.previousElementSibling.src)
    console.log(img.pathname);

    const fila = document.querySelector('.fila')
    if (fila) {
        
        fila.remove()
    } else {

        const carta = params.parentNode
        carta.remove()
    }

    const carta = document.querySelector
    

    try {
        
        respoinse = await fetch(`/auth/eliminarIMG?directorio=${img.pathname}`)
        const data = await respoinse.json()

        console.log(data);

    } catch (error) {
        console.log(error);
    }
}