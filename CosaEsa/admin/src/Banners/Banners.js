

async function ObtenerBanners() {
    
    try {
        
        const response = await fetch('/auth/obtenerBanners')

        const data = await response.json()

        console.log(data);

        GenerarCartas(data)
        

    } catch (error) {
        console.log(error);
        
    }
}

function GenerarCartas(banners) {


    const contenedor = document.querySelector('.div_scroll')

    contenedor.innerHTML = ' '
    
    banners.forEach(banner => {

        
        const carta = `<div class="cart">
            <div class="contendor_cart_nombre">
                <label class="checkBox_filtro"><input name="radio" type="checkbox"><div class="transition_checkbox"></div></label>
                
                <h2>${banner}</h2>
            </div>
            <img src="../img/banners/${banner}" alt="alt"/>
            <svg xmlns="http://www.w3.org/2000/svg" onclick="BorrarImagen(event, this)" width="24" height="24" viewBox="0 0 24 24"   fill="#6F6D6D">
                <mask id="mask0_2039_18386" style="mask-type:alpha" maskUnits="userSpaceOnUse" x="0" y="0" width="24" height="24">
                <rect width="24" height="24" />
                </mask>
                <path d="M6.93398 21.2033C6.30432 21.2033 5.76773 20.9816 5.32423 20.5381C4.88073 20.0946 4.65898 19.558 4.65898 18.9283V6.06582H3.52148V3.79082H8.86223V2.65332H15.1252V3.79082H20.478V6.06582H19.3405V18.9283C19.3405 19.558 19.1187 20.0946 18.6752 20.5381C18.2317 20.9816 17.6952 21.2033 17.0655 21.2033H6.93398ZM17.0655 6.06582H6.93398V18.9283H17.0655V6.06582ZM8.89223 16.9941H11.0297V7.99407H8.89223V16.9941ZM12.9697 16.9941H15.1072V7.99407H12.9697V16.9941Z" />
            </svg>
        </div>`

        contenedor.innerHTML += carta
    });

    
}

function AgregarBanner(event, input) {

    event.preventDefault()

    console.log(input.files[0]);
    
    const formData = new FormData()
    formData.append('id', input.files[0].name)
    formData.append('images', input.files[0])

    fetch('/upload?banners', {
        method: 'POST',
        body: formData
    })
    .then(response => response.text())
    .then(result => {
        console.log(result);
        
    })
    .catch(error => {
        console.log(error);
        
    })

    ObtenerBanners()
}

function EliminarBanner(params) {
    


}

ObtenerBanners()