async function BorrarImagen(params) {
    
    const img = params.previousElementSibling
    console.log(params);
    
    console.log(img.src);
    

    try {
        
        respoinse = await fetch('/auth/eliminarIMG?id' + img.src)
        const data = await respoinse.json()

        console.log(data);
        

    } catch (error) {
        console.log(error);
    }
}