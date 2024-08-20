function Buscar(params) {
    
    const barra = document.querySelector('.buscador')
    
    barra.addEventListener('keydown', async function(event) {
        
        if (event.key === 'Enter' || event.keyCode === 13) {
            
            try {
                
                const response = await fetch('/auth/buscar', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({elemento: '%' + params.value + '%'})
                })

                const data = await response.json()

                const frame = document.querySelector('iframe')
                console.log(frame);
                

                frame.contentWindow.CrearCard(data)

                console.log(data);
                
            } catch (error) {   
                console.log(error);
            }
        }
    })
    console.log(params.value);
    
}

function LlamarFuncion(params) {
    
    const frame = document.querySelector('iframe')
    console.log(frame.src);
    

    if (frame.src == 'http://localhost:3000/home') {
        
        console.log(frame.src);
        
        const barra = document.querySelector('.buscador')

        console.log(barra);
        

        barra.addEventListener('keydown', function (event) {

            console.log(event);
            
            if (event.key === 'Enter' || event.keyCode === 13) {
                

                frame.src = '/tienda'
                console.log(frame.src);

                frame.contentWindow.Buscar(params)
                
            }
        })
    }

    console.log(params);
    
   
        
        frame.contentWindow.Buscar(params)
    
    
}