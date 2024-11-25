
async function MostrarCompras() {
    
    const lista = document.querySelector('.div_scroll')

    try {
        
        const response = await fetch('/auth/mostrarCompras')
        const data = await response.json()

        document.querySelector('.cantidad').textContent = `(${data.length})`

        data.forEach(element => {
          
            let carta= `
            <div id="${element.id}" class="cart">
                <label class="checkBox_filtro"><input name="radio" type="checkbox"><div class="transition_checkbox"></div></label>
                <div class="contendor_cart_nombre">
                    <h2>Pedido: ${element.noPedido}</h2>
                </div>
                <h2>${element.fechaPago}</h2>
                <h2>${element.Total}</h2>
                <select id="estatus-${element.id}" onchange="ModificarEstatus(this)">
                        
                        <option value="11">Entregado</option>
                        <option value="1">En reparto</option>
                        <option value="0">Por Enviar</option>
                    </select>
                <input id="${element.id}" type="text" value="${element.noGuia}" onblur="ModificarGuia(this)">
              
            </div>
            `

             lista.innerHTML += carta
        });

        data.forEach(element => {

            let selector = document.getElementById(`estatus-${element.id}`)
            
            selector.value = String(element.estadoEnvio)
        })


    } catch (error) {
        console.log(error);
        
    }
}

async function ModificarGuia(params) {
    
    try {

        console.log(params.value);
        
        
        const response = await fetch(`/auth/modificarGuia?id=${params.getAttribute('id')}&numero=${params.value}`)
        const data = await response.json()

        console.log(data);
        
        if (data.affectedRows == 1) {
            
            alert("Se a modificado correcrtamente el numero guia")
        }

        if (data.message) {
            alert(data.message)
        }

    } catch (error) {
        console.log(error);
        
    }
}

async function ModificarEstatus(params) {

    try {
        
        const response = await fetch(`/auth/modificarEE?id=${params.id.slice(8)}&estatus=${params.value}`)
        const data = await response.json()
        console.log(data);
        
    } catch (error) {
        console.log(error);
        
    }
    
}

MostrarCompras()