async function Estadisticas(paramas) {
    
    console.log(paramas);
    
    const tiempo = document.querySelectorAll('.selecion_a')
    const sesiones = document.getElementById('sesiones')
    const ventas = document.getElementById('ventas')
    const pedidos = document.getElementById('pedidos')

    const registrados = document.getElementById('registrados')
    const invitados = document.getElementById('invitados')

    console.log(tiempo[0].getAttribute('value'));
    console.log(tiempo[1].getAttribute('value'));
    
    
    try {
     
        
        const response = await fetch(`/auth/estadisticas?tiempo=${tiempo[0].getAttribute('value')}&tiempo2=${tiempo[1].getAttribute('value')}`)
        const data = await response.json()
        
        sesiones.textContent = data.rows[0].total
        ventas.textContent = data.ventas[0].total
        pedidos.textContent = data.ventadetalle[0].total

        registrados.textContent = data.clientes[0].total
        invitados.textContent = data.registrados[0].total

        

    } catch (error) {
        console.log(error);
        
    }
}



Estadisticas()