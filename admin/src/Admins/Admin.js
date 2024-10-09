async function MostrarUsuarios() {
    
    try {
        
        const response = await fetch('/auth/mostrarUsuarios')
        const data = await response.json()

        console.log(data);
        
        const lista = document.querySelector('.div_scroll')

        data[0].forEach(element => {
            
            console.log(element);
            

            const elemento = document.createElement('li')
            const opciones = document.createElement('select')
            opciones.id = element.id
            opciones.setAttribute('onClick', 'Opciones(this)')

            const acciones = `
                <option value="eliminar">Eliminar</option>
                <option value="editar">Editar ROl</option>
            `
            opciones.innerHTML = acciones

            
            elemento.textContent = element.name + ' - ' + element.role + ' - ' + element.fechaAlta
            elemento.appendChild(opciones)

            const carta = `
            <div class="cart">
                <label class="checkBox_filtro"><input name="radio" type="checkbox"><div class="transition_checkbox"></div></label>
                <div class="contendor_cart_nombre">
                    <h2>${element.name}</h2>
                </div>
                <div class="contenedor_rol">
                    <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 32 32" fill="none">
                        <mask id="mask0_2940_934" style="mask-type:alpha" maskUnits="userSpaceOnUse" x="0" y="0" width="32" height="32">
                        <rect width="32" height="32" fill="#D9D9D9"/>
                        </mask>
                        <path d="M6.66667 27.9998C5.93333 27.9998 5.30556 27.7387 4.78333 27.2165C4.26111 26.6943 4 26.0665 4 25.3331V6.66647C4 5.93314 4.26111 5.30536 4.78333 4.78314C5.30556 4.26092 5.93333 3.9998 6.66667 3.9998H18.5667L15.9 6.66647H6.66667V25.3331H25.3333V16.0665L28 13.3998V25.3331C28 26.0665 27.7389 26.6943 27.2167 27.2165C26.6944 27.7387 26.0667 27.9998 25.3333 27.9998H6.66667ZM12 19.9998V14.3331L24.2333 2.0998C24.5 1.83314 24.8 1.63314 25.1333 1.4998C25.4667 1.36647 25.8 1.2998 26.1333 1.2998C26.4889 1.2998 26.8278 1.36647 27.15 1.4998C27.4722 1.63314 27.7667 1.83314 28.0333 2.0998L29.9 3.9998C30.1444 4.26647 30.3333 4.56092 30.4667 4.88314C30.6 5.20536 30.6667 5.53314 30.6667 5.86647C30.6667 6.1998 30.6056 6.52758 30.4833 6.8498C30.3611 7.17203 30.1667 7.46647 29.9 7.73314L17.6667 19.9998H12ZM14.6667 17.3331H16.5333L24.2667 9.5998L23.3333 8.66647L22.3667 7.73314L14.6667 15.4331V17.3331Z" fill="#235583"/>
                    </svg>
                    <h2>${element.role}</h2>
                </div>
                <h2>${element.fechaAlta}</h2>
                       
                <svg xmlns="http://www.w3.org/2000/svg" onclick="cambiarClase_eliminar()" width="24" height="24" viewBox="0 0 24 24"   fill="#6F6D6D">
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

async function Opciones(params) {
    
    if (params.value == 'eliminar') {
        
        try {
            
            const response = await fetch(`/auth/eliminarColaborador?id=${params.id}`)

            const data = await response.json()

            console.log(data);
            

        } catch (error) {
            console.log(error);
            
        }
    }
}

MostrarUsuarios()