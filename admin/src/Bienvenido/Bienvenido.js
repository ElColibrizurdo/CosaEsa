async function Estadisticas() {
    
    console.log('HOla');
    

    const tiempo = document.getElementById('tiempo')
    const sesiones = document.getElementById('sesiones')
    const ventas = document.getElementById('ventas')
    const pedidos = document.getElementById('pedidos')

    const tiempo2 = document.getElementById('tiempo2')
    const registrados = document.getElementById('registrados')
    const invitados = document.getElementById('invitados')

    console.log(tiempo.value);
    

    try {
     
        
        const response = await fetch(`/auth/estadisticas?tiempo=${tiempo.value}&tiempo2=${tiempo2.value}`)
        const data = await response.json()
        console.log(data);
        
        console.log(data.rows);
        
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