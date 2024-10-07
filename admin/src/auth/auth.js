const { query } = require('express')
const db = require('../Databases/Databases')
const  appModule = require('../app')
const fs =  require('fs')
const path = require('path')

const estadisticas = async (req, res) => {

    const tiempo = req.query.tiempo
    const tiempo2 = req.query.tiempo2
    console.log(tiempo);
    

    try {
        
           
        const [rows] =   await db.query('SELECT COUNT(*) AS total FROM sesion WHERE horaInicio >= NOW() -INTERVAL ? DAY', [tiempo])
        const [ventas] = await db.query('SELECT COUNT(*) AS total FROM venta WHERE fechaPago >= NOW() -INTERVAL ? DAY', [tiempo])
        const [ventadetalle] = await db.query('SELECT COUNT(*) AS total FROM ventadetalle WHERE fechaAlta >= NOW() -INTERVAL ? DAY', [tiempo])

        const [clientes] = await db.query('SELECT COUNT(*) AS total FROM cliente WHERE fechaInicio >= NOW() -INTERVAL ? DAY', [tiempo2])
        const [registrados] = await db.query('SELECT COUNT(*) AS total FROM usuario WHERE fechaAlta >= NOW() -INTERVAL ? DAY', [tiempo2])

        res.json({rows, ventas, ventadetalle, clientes, registrados})

    } catch (error) {
        console.log(error);
    }
}

const mostrar_productos = async (req, res) => {

    try {
        
        const [productos] = await db.query('SELECT p.descripcion, p.precio, p.estado, p.id, COUNT(c.id) AS variantes FROM producto p LEFT JOIN colores_producto c ON p.id = c.idProducto WHERE activo = 1 GROUP BY p.id ')

        res.json(productos)
        
    } catch (error) {
        console.log(error);
        
    }
}

const agregar_producto = async (req, res) => {

    const { nombre, precio, tipo, equipo, imagenes } = req.body
    console.log(imagenes);
    

    try {
        
        const row = await db.query('INSERT INTO producto (idTipo, descripcion, idEquipo, precio, stock, estado) VALUES (?,?,?,?,?,?)', [parseInt(tipo), nombre, equipo, precio, 15, 0])
        console.log(row[0].insertId);
        

        imagenes.forEach((element, indice) => {

            const rutaOriginal = path.join(__dirname, '..', 'img', element)
            
            if (indice == 0) {
                
                const rutaDestino = path.join(__dirname, '..', '..','..','user','img','articulos', row[0].insertId + '.png')

                fs.rename(rutaOriginal, rutaDestino, (err) => {
                    if (err) {
                        console.log(err);
                    } else {
                        console.log('se movio');
                    }
                })
            } else {

                const rutaDestino = path.join(__dirname, '..', '..','..','user','img','articulos', row[0].insertId + '_' + indice + '.png') 

                fs.rename(rutaOriginal, rutaDestino, (err) => {
                    if (err) {
                        console.log(err);
                    } else {
                        console.log('se movio');
                    }
                })
            }
            
        })

        return res.status(400).json(row)

    } catch (error) {
        console.log(error);
    }
}

const ObtenerTipos = async (req, res) => {

    try {

        const [row] = await db.query('SELECT t.nombre, t.activo, (SELECT COUNT(*) FROM producto p WHERE idTipo = t.id) AS cantidad FROM tipoproducto t')

        console.log({row});

        res.json(row)

    } catch (error) {
        
        console.log(row);
        
    }
    
}

const AgregarCategoria = async (req, res) => {

    const { nombre } = req.body

    try {
        
        const [row] = await db.query('INSERT INTO tipoproducto (nombre, activo) VALUES (?,?)', [nombre, 1])

        res.json(row)

    } catch (error) {
        console.log(error);
        
    }
}

const CambiarEstado = async (req, res) => {

    const { id, estado } = req.body
    console.log(id);
    console.log(estado);
    

    try {
        
        const row = await db.query('UPDATE producto SET estado = ? WHERE id = ?' , [estado, id])

        res.json(row)

    } catch (error) {
        console.log(error);
        
    }
}

const login = async (req, res) => {

    const correo = req.query.correo
    const pass = req.query.pass

    console.log(correo);
    console.log(pass);
    

    try {
        
        const [row] = await db.query('SELECT EXISTS ( SELECT 1 FROM usuario WHERE email = ? AND password = ? ) AS resultado', [correo, pass])
        console.log(row);
        
        res.json({row})

    } catch (error) {
        console.log(error);
        
    }
}

const EliminarProducto = async (req, res) => {

    const { id } = req.body

    try {

        const [row] = await db.query('UPDATE producto SET activo = 0 WHERE id = ?', [id])
        console.log(row);
        
        res.json(row)

    } catch (error) {
        console.log(error);
        
    }
}

const MostrarUsuarios = async (req, res) => {

    try {
        
        const [row] = await db.query('SELECT name, role, fechaAlta, id FROM usuario WHERE role = "admin"')

        console.log(row);
        
        
        res.json([row])

    } catch (error) {
        console.log(error);
        
    }
}

const EliminarColaborador = async (req, res) => {

    const id = req.query.id

    try {
        
        const row = await db.query('DELETE FROM usuario WHERE id = ?', [id])

        console.log(row);
        res.json(row)

    } catch (error) {
        console.log(error);
        
    }
}

const CrearColaborador = async (req, res) => {

    const { nombre, pass, ape, email } = req.body

    try {
        
        const row = await db.query('INSERT INTO usuario (name, email, password, Nombres, ApellidoPrimero, ApellidoSegundo, role, verificado) VALUES (?,?,?,?,?,?,?,?)', [nombre, email, pass, nombre, ape, ape, 'admin', 1])

        res.json([row])

    } catch (error) {
        console.log(error);
        
    }
}


module.exports = { EliminarColaborador, CrearColaborador, MostrarUsuarios, estadisticas, mostrar_productos, agregar_producto, ObtenerTipos, AgregarCategoria, CambiarEstado, login, EliminarProducto }