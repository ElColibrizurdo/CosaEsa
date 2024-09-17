async function AgregarCanasta(boton) {

    console.log('hola');
    
    try {
        const response = await fetch('/auth/agregar', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify( {
                cantidad: 1,
                id: localStorage.getItem('sesion'),
                id_producto: boton.getAttribute('el'),
                numero: [''],
                nombre: [''],
                precio: boton.getAttribute('precio'),
                talla: ['1']
            })
        })
    
        const data = response

        if (data.ok) {
            console.log('si');
            window.parent.ObtenerCantidadCanasta()
            
        }
        console.log(data);
    } catch (error) {
        console.log(error);
        
    }

    
    
    
}

async function ObtenerCantidadCanasta() {
    
    //Poner el numero de productos en la cesta
    const sesion = localStorage.getItem('sesion')
    const response = await fetch(`/auth/cantidad?sesion=${sesion}`)
    
    const data = await response.json()
    
    const carrit0 = window.parent.document.querySelector('.btn_carrito')
    carrit0.childNodes[2].textContent = data.row[0].cantidad
    
    console.log(carrit0.childNodes[2]);
    
}