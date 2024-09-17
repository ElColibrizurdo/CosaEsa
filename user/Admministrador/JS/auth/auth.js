const db = require('../../../JS/Databases/db')

const obtener_estadisticas = async (req, res) => {

    try {
        
        const dia1 = req.query.dias1
        const dia2 = req.query.dias2

        console.log(dia1);
        console.log(dia2);
        

        const [rowS] = await db.query('SELECT COUNT(*) AS total FROM sesion WHERE horaTermino is NULL')
        const [rowV] = await db.query('SELECT SUM(total) AS total FROM venta WHERE fechaPago >= CURDATE() - INTERVAL ? DAY', [dia1])  
        const [rowVD] = await db.query('SELECT COUNT(*) AS total FROM venta WHERE fechaPago >= CURDATE() - INTERVAL ? DAY', [dia1]) 

        console.log(rowS);
        console.log(rowV);
        console.log(rowVD);
        

        const [usuariosR] = await db.query('SELECT COUNT(id) AS total FROM usuario WHERE fechaAlta >= CURDATE() - INTERVAL ? DAY', [dia2])

        console.log(usuariosR);
        

        res.status(200).json({rowS, rowV, rowVD, usuariosR})

    } catch (error) {
        console.log(error);
    }
}

const obtener_ventas = async ( req, res ) => {

    try {
        
        const [row] = await db.query('SELECT COUNT(*) AS total FROM ventas')
        res.status(200). json(row)
    } catch (error) {
        
    }
}

module.exports = { obtener_estadisticas }