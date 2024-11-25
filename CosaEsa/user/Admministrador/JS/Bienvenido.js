async function Obtener_estadisticas() {
    
    try {
        
        const dia1 = document.querySelectorAll('.estadisticas')
        let valor1 = 0

        dia1.forEach(boton => {
            boton.addEventListener('click', function(event) {
                valor1 = boton.value
            })
        })

        const dia2 = document.querySelectorAll('.user')
        let valor2 = 0

        dia2.forEach(boton => {
            boton.addEventListener('click', function (params) {
                valor2 = boton.value
            })
        })
        
        const response = await fetch(`/admin/estadisticas?dias1=${valor1}&dias2=${valor2}`)

        if (response.ok) {
            
            const estadisticas = await response.json()
            const hijos = document.querySelector('.sesiones')
            const ventas = document.querySelector('.ventas')
            const peidos = document.querySelector('.pedidos')
            const usuarios = document.querySelector('.registrados')
            
            hijos.textContent = estadisticas.rowS[0].total
            ventas.textContent = '$ ' + estadisticas.rowV[0].total
            peidos.textContent = estadisticas.rowVD[0].total
            usuarios.textContent = estadisticas.usuariosR[0].total

        }
    } catch (error) {
        
        console.log(error);
        
    }
}

Obtener_estadisticas()