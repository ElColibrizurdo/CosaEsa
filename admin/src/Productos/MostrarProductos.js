

async function mostrar_productos() {
    
    const lista = document.querySelector('.div_scroll')

    try {
        
        const response = await fetch('/auth/mostrarProductos')
        const data = await response.json()


        data.forEach(element => {
            console.log(element);

            let estado = 'pepe'

            if (element.estado == 0) {
                
                estado = 'Agotado'

            } else if (element.estado == 1) {
                
                estado = 'Disponible'

            } else {

                estado = 'Preventa'

            }
            
            const carta = `
            <div id="${element.id}" class="cart">
                <label class="checkBox_filtro"><input name="radio" type="checkbox"><div class="transition_checkbox"></div></label>
                <img src="../img/articulos/${element.id}.png" alt="alt"/>
                <div class="contendor_cart_nombre">
                    <h2>${element.descripcion}</h2>
                </div>
                <h2>${element.variantes} variantes</h2>
                <h2>${element.id}</h2>
                <h2>$ ${element.precio} mxn</h2>
                <h2>${estado}</h2>
                       
                <svg xmlns="http://www.w3.org/2000/svg" onclick="cambiarClase_eliminar(${element.id})" width="24" height="24" viewBox="0 0 24 24"   fill="#6F6D6D">
                    <mask id="mask0_2039_18386" style="mask-type:alpha" maskUnits="userSpaceOnUse" x="0" y="0" width="24" height="24">
                    <rect width="24" height="24" />
                    </mask>
                    <path d="M6.93398 21.2033C6.30432 21.2033 5.76773 20.9816 5.32423 20.5381C4.88073 20.0946 4.65898 19.558 4.65898 18.9283V6.06582H3.52148V3.79082H8.86223V2.65332H15.1252V3.79082H20.478V6.06582H19.3405V18.9283C19.3405 19.558 19.1187 20.0946 18.6752 20.5381C18.2317 20.9816 17.6952 21.2033 17.0655 21.2033H6.93398ZM17.0655 6.06582H6.93398V18.9283H17.0655V6.06582ZM8.89223 16.9941H11.0297V7.99407H8.89223V16.9941ZM12.9697 16.9941H15.1072V7.99407H12.9697V16.9941Z" />
                </svg>
            </div>
            `
            
             lista.innerHTML += carta
        });


    } catch (error) {
        console.log(error);
        
    }
}

async function Acciones(params) {
    
    if (params.value === 'editar') {
        
        

    } else if (params.value === 'eliminar') {

        console.log(params.parentNode.getAttribute('lista'));
        
        
        const response = await fetch('/auth/eliminarProducto', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                id: params.parentNode.getAttribute('lista')
            })
        })

        const data = await response.json()
        console.log(data.affectedRows);

        if (data.affectedRows == 1) {
            
            params.parentNode.remove()
        }
        
    }
}

function Eliminar(id) {
    
    const carta = document.querySelectorAll('.cart')

    carta.forEach(element => {

        if (element.getAttribute('id') == id) {
            
            element.remove()
        }
        
    })
}

mostrar_productos()