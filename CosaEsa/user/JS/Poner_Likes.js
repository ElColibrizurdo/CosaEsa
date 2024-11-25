function Poner_Likes() {

    console.log('Hola');
    

    return new Promise((resolve) => {
        console.log('Ejecutando script 2');
        if (localStorage.getItem('sesion')) {

            const sesion = localStorage.getItem('sesion')
            const carta = document.querySelectorAll('.carta')
            const chk = document.querySelectorAll('.productos')

            console.log(carta);
            
            console.log(chk);
        
            chk.forEach(async element => {
                
                const number = element.getAttribute('number')
                console.log(number);

        
                try {
                
                    const response = await fetch('/auth/getLike', { 
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({ number, sesion })
                    })
            
                    const data = await response.json()
            
                    if (data.row) {
                        
                        element.checked = true
                    }
            
                } catch (error) {
                    console.log(error);
                }
            });    
        }
        setTimeout(() => {
            console.log('Script 2 completado');
            resolve(); // Resuelve la promesa
        }, 1000);
    });
    
    
}

