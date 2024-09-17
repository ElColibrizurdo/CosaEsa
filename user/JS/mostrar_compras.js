

const params = new URLSearchParams(window.location.search)

async function obtieneCompra() {
    
    const idSesion = localStorage.getItem('sesion')

    try {
        
        const response = await fetch('/auth/compras', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({idSesion})
        }) 

        const data = await response.json()
        
        return data.compraProducto

    } catch (error) {
        console.log(error);
    }
}

async function ImprimirProductos() {

    const compras = await obtieneCompra()

    const grupo = document.querySelector('.grupo_cartas')

    grupo.innerHTML = ''
    
    compras.forEach(element => {

        console.log(element.fechaAlta);

        if (element.estadoEnvio === null) {
            
            element.estadoEnvio = 'En camino'
        }
        console.log(element);
        const cortados = element.total.split(/(?<=\.00)/)
        console.log(cortados);
        
        

        const carta = `
        <div class="carta" >
                                <div class="carta_img">
                                    <img src="../IMAGES/articulos/${element.id}.png" alt="alt"/>
                                </div>
                                <div class="carta_txt">
                                    <div class="carta_txt_1 espaciado">
                                        <div class="carta_txt_2">
                                            <a class="carta_txt_1_a">N° Pedido:;</a><h2>${element.id}   </h2>
                                        </div> 
                                        <div class="carta_txt_2">
                                            <a class="carta_txt_1_a">Fecha de compra:&nbsp;</a><h2>${element.fechaAlta}</h2>
                                        </div>
                                    </div> 
                                    <div class="carta_txt_1"><h2>${element.descripcion}</h2></div>
                                    <div class="carta_txt_1"><a class="carta_txt_1_a">Total:&nbsp;</a><h2>$${cortados[0]} MXN</h2></div>

                                </div>
                                <div class="carta_btn">
                                    <button class="btn_estado">${element.estadoEnvio}</button>
                                    <a class="carta_btn_a">Detalles<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                                        <mask id="mask0_1985_14822" style="mask-type:alpha" maskUnits="userSpaceOnUse" x="0" y="0" width="24" height="24">
                                        <rect y="24" width="24" height="24" transform="rotate(-90 0 24)" fill="#D9D9D9"/>
                                        </mask>
                                        <g mask="url(#mask0_1985_14822)">
                                        <path d="M15.0542 11.9996L9.40043 17.6533L8.34668 16.5996L12.9467 11.9996L8.34668 7.39957L9.40043 6.34582L15.0542 11.9996Z" fill="#F15D2A"/>
                                        </g>
                                        </svg></a>
                                </div>
                            </div>`

        grupo.innerHTML += carta
    })
}


async function consultaCompra(idSesion) {

    try {

        const response = await fetch('/auth/tipoProducto', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ idProducto })
        })

        const data = await response.json()

        const content_cartas = document.getElementById('grupo_cartas_compras')
        // content_cartas.innerHTML = ""

        console.log(data);
        

        data.compraProducto.forEach(element=>{
            console.log(element)

            content_cartas.innerHTML += `<div class="carta" >
                        <div class="carta_img">
                            <img src="../IMAGES/prueba_cart.png" alt="alt"/>
                        </div>
                        <div class="carta_txt">
                            <div class="carta_txt_1 espaciado">
                                <div class="carta_txt_2">
                                    <a class="carta_txt_1_a">N° Pedido:;</a><h2>001234566</h2>
                                </div> 
                                <div class="carta_txt_2">
                                    <a class="carta_txt_1_a">Fecha de compra:&nbsp;</a><h2>18/Jun/24</h2>
                                </div>
                            </div> 
                            <div class="carta_txt_1"><h2>Camiseta Oficial Calvos 2024 personalisado</h2></div>
                            <div class="carta_txt_1"><a class="carta_txt_1_a">Total:&nbsp;</a><h2>$1,200.00 MXN</h2></div>

                        </div>
                        <div class="carta_btn">
                            <button class="btn_estado">En camino</button>
                            <a class="carta_btn_a">Detalles<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none">
                                <mask id="mask0_1985_14822" style="mask-type:alpha" maskUnits="userSpaceOnUse" x="0" y="0" width="24" height="24">
                                <rect y="24" width="24" height="24" transform="rotate(-90 0 24)" fill="#D9D9D9"/>
                                </mask>
                                <g mask="url(#mask0_1985_14822)">
                                <path d="M15.0542 11.9996L9.40043 17.6533L8.34668 16.5996L12.9467 11.9996L8.34668 7.39957L9.40043 6.34582L15.0542 11.9996Z" fill="#F15D2A"/>
                                </g>
                                </svg></a>
                        </div>
                    </div>`
            })
    }
    catch(error){
        console.log(error);
    }

}

ImprimirProductos()

document.querySelector('.atras').addEventListener('click', function () {
    
    history.back()
})