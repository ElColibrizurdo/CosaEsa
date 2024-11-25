async function BorrarImagen(event, params) {
    
    event.preventDefault()

    const img = new URL(params.previousElementSibling.src)
    console.log(img.pathname);
    

    try {
        
        respoinse = await fetch(`/auth/eliminarIMG?directorio=${img.pathname}`)
        const data = await respoinse.json()

        console.log(data);
        

    } catch (error) {
        console.log(error);
    }
}