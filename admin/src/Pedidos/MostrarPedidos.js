

async function MostrarPedidos() {
    
    const lista = document.querySelector('.div_scroll')

    try {
        
        const response = await fetch('/auth/mostrarPedidos')
        const data = await response.json()

        

        const cantidad = document.querySelector('.cantidad')
        cantidad.textContent = `(${data.length})`

        data.row.forEach((element, indice) => {

            try {
                let carta = `
                <div id="${element.id}" class="cart">
                    <label class="checkBox_filtro"><input name="radio" type="checkbox"><div class="transition_checkbox"></div></label>
                    <div class="contendor_cart_nombre">
                        <h2>${data.productos[indice].descripcion}</h2>
                    </div>
                    <h2>Detalles: ${element.id}</h2>
                    <h2>Pedido: ${element.idVenta}</h2>
                    <select id="estatus-${element.id}" onchange="ModificarEstatus(this)">
                        <option value="11">Entregado</option>
                        <option value="1">En reparto</option>
                        <option value="0">Por Enviar</option>
                    </select>
                        
                    <svg xmlns="http://www.w3.org/2000/svg" onclick="cambiarClase_eliminar(${element.id})" width="24" height="24" viewBox="0 0 24 24" fill="#6F6D6D">
                        <circle cx="6" cy="12" r="2" />
                        <circle cx="12" cy="12" r="2" />
                        <circle cx="18" cy="12" r="2" />
                    </svg>
                </div>
                `
                

                lista.innerHTML += carta
                                
            } catch (error) {
                
            } 
        });

        data.row.forEach((element, indice) => {

            let selector = document.getElementById(`estatus-${element.id}`)
            
            selector.value = String(element.estadoEnvio)
        })

    } catch (error) {
        console.log(error);
    }
}

async function ModificarEstatus(params) {

    try {
        
        const response = await fetch(`/auth/modificarEE?id=${params.id.slice(8)}&estatus=${params.value}`)
        const data = await response.json()

    } catch (error) {
        
    }
    
}

MostrarPedidos()

