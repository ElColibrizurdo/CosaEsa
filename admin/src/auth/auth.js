const { query } = require('express')
const db = require('../Databases/Databases')
const  appModule = require('../app')
const fs =  require('fs').promises
const path = require('path')
const multer = require('multer');
const { log } = require('console')

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
        
        const [productos] = await db.query('SELECT p.descripcion, p.precio, p.estado, p.id, p.idTipo, COUNT(c.id) AS variantes FROM producto p LEFT JOIN colores_producto c ON p.id = c.idProducto WHERE activo = 1 GROUP BY p.id ')

        res.json(productos)
        
    } catch (error) {
        console.log(error);
        
    }
}

const agregar_producto = async (req, res) => {

    const { nombre, precio, tipo, coloresID, equipo, imagenes, equipoP } = req.body
    
    try {
        
        const row = await db.query('INSERT INTO producto (idTipo, descripcion, idEquipo, precio, stock, estado) VALUES (?,?,?,?,?,?)', [parseInt(tipo), nombre, equipoP, precio, 15, 0])
        console.log(row[0].insertId);

        if (row[0].insertId) {

            coloresID.forEach(async element => {

                const rowC = await db.query('INSERT INTO productocolor (idProducto, idColor) VALUES (?,?)', [row[0].insertId, element])
                console.log(rowC);
            })
        }
        

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

    const tipo = req.query.tipo

    console.log(tipo);
    

    try {

        const [row] = await db.query('SELECT t.nombre, t.activo, t.id, (SELECT COUNT(*) FROM producto p WHERE idTipo = t.id) AS cantidad FROM tipoproducto t ' + tipo)

        row.forEach((element, indice) => {

            console.log(element.activo[0]);
            
            
        })

        console.log(row);
        
        
        res.json(row)

    } catch (error) {
        
        console.log(error);
        
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

const ExtraerColores = async (req, res) => {

    const id = req.query.id

    console.log(id);
    

    try {
        
        const [row] = await db.query('SELECT id, nombre, hexadecimal, clave, activo FROM color WHERE activo = 1')
        const [rows] = await db.query('SELECT idColor FROM productocolor WHERE idProducto = ?', [id])

        res.json({row, rows})
    } catch (error) {
        console.log(error);
        
    }
}

const BuscarImagenes = async (req, res) => {

    const id = req.query.id

    try {
        
        const directorio = path.join(__dirname, '..', 'img', 'articulos')
        const archivos = await fs.readdir(directorio)

        const archivosFiltrado = archivos
        .filter(archivo => archivo.startsWith(id + '_') || archivo.startsWith(id + '.'))
        .map(archivo => ({
            nombre:archivo,
            rutaCompleta: path.join(directorio, archivo)
        }))

        res.json(archivosFiltrado)

    } catch (error) {   
        console.log(error);
        
    }
}

const BuscarImagenEquipo = async (req, res) => {

    const id = req.query.id

    try {
        
        const directorio = path.join(__dirname, '..', 'img', 'logos')
        const archivo = await fs.readdir(directorio)

        const archivoFiltrado = archivo
        .filter(arch => arch.startsWith(`logo_${id}.`))
        .map(arch => ({
            name:arch,
            rutaCompleta: path.join(directorio, arch)
        }))

        console.log(archivoFiltrado);
        

        res.json(archivoFiltrado)

    } catch (error) {
        console.log(error);
        
    }
}

const ActualizarProducto = async (req, res) => {

    const { id, idTipo, descripcion, idEquipo, precio, estado } = req.body

    console.log(precio);
    console.log(id);
    console.log(descripcion);
    console.log(idEquipo);
    console.log(estado);
    console.log(idTipo);
    

    try {
        
        const row = await db.query('UPDATE producto SET idTipo = ?, descripcion = ?, idEquipo = ?, precio = ?, estado = ? WHERE id = ?', [idTipo, descripcion, idEquipo, precio, estado, id])
        console.log(row);
        
        res.json(row)

    } catch (error) {
        
        console.log(error);
        
    }
}

const ELiminarColorDeProducto = async (req, res) => {

    const { idProducto, idColor } = req.body

    try {
        
        const row = db.query('DELETE FROM productocolor WHERE idProducto = ? AND idColor = ?', [idProducto, idColor])
        res.json(row)

    } catch (error) {
        console.log(error);
        
    }
}

const AgregarColorProducto = async (req, res) => {

    const { idProducto, idColor } = req.body

    try {

        const [existe] = await db.query('SELECT EXISTS (SELECT 1 FROM productocolor WHERE idProducto = ? AND idColor = ?) AS existe', [idProducto, idColor])
        
        console.log(existe[0].existe);
        

        if (existe[0].existe != 1) {
            
            const row = await db.query('INSERT INTO productocolor (idProducto, idColor) VALUES (?,?)', [idProducto, idColor])
            res.json(row)
        }

       

    } catch (error) {
        console.log(error);
        
    }
}

// Configurar el almacenamiento con Multer
const storage = multer.diskStorage({
    destination: function (req, file, cb) {
        // Aquí se especifica el directorio donde se guardarán las imágenes
        cb(null, path.join(__dirname));
    },
    filename: function (req, file, cb) {

        const { id } = req.body
        // Verificar que el ID esté disponible
        if (!id) {
            return cb(new Error('ID no proporcionado en el body'), false);
        }
        

        // Personaliza el nombre del archivo
        cb(null, id + path.extname(file.originalname)); // Agrega la extensión original
    }
});

// Inicializar el middleware de Multer
const upload = multer({ storage: storage });

const SubirImagenProducto = async (req, res) => {

    try {
        // Se utiliza `upload.single` para manejar la subida de la imagen
        upload.single('image')(req, res, function (err) {
            if (err) {
                return res.status(400).send(err.message);
            }

            // Verifica si se ha subido un archivo
            if (!req.file) {
                return res.status(400).send('No se ha subido ningún archivo.');
            }

            const { id } = req.body
            if (!id) {
                return res.status(400).send('Faltan datos adicionales.');
            }

            console.log(id);
            

            res.send({
                message: 'Imagen subida correctamente',
                filename: req.file.filename,
                data: {
                    id
                }
            })

            // Aquí puedes procesar más la imagen o guardarla en la base de datos
            res.send(`Imagen subida exitosamente: ${req.file.filename}`);
        });
    } catch (error) {
        console.error(error);
        res.status(500).send('Error al subir la imagen.');
    }
}

const EliminarColor = async (req, res) => {

    const id = req.body
    
    try {
        
        const [row] = await db.query('UPDATE color SET activo = 0 WHERE id = ?' , [id])
        
        res.json(row)

    } catch (error) {
        console.log(error);
        
    }
}

const AgregarColor = async (req, res) => {

    const { nombre, color } = req.body

    let clave = nombre.slice(0,3).toUpperCase()

    console.log(nombre);
    console.log(color);
    
    

    try {
        
        const [existe] = await db.query('SELECT EXISTS (SELECT 1 FROM color WHERE nombre = ? OR hexadecimal = ?) AS existe', [nombre, color])

        console.log(existe);

        if (existe[0].existe == 0) {
            
            const [existeClave] = await db.query('SELECT COUNT(*) AS cantidad FROM color WHERE clave LIKE ?', [clave + '%'])

            console.log(existeClave);

            if (existeClave[0].cantidad >= 1 ) {
                
                clave += existeClave[0].cantidad + 1
            }

            console.log(clave);
            

            const [row] = await db.query('INSERT INTO color (clave, nombre, hexadecimal) VALUES (?,?,?)', [clave, nombre.toUpperCase(), color])
            res.json(row)
        }

    } catch (error) {
        
        console.log(error);
        
    }
}

const ModificarColor = async (req, res) => {

    const { id, nombre, color } = req.body

    try {
        
        const [row] = await db.query('UPDATE color SET nombre = ?, hexadecimal = ? WHERE id = ?', [nombre, color, id])

        console.log(row);
        res.json(row)

    } catch (error) {
        console.log(error);
        
    }
}

const ModificarCategoria = async (req, res) => {

    const { id, nombre } = req.body

    try {
        
        const [row] = await db.query('UPDATE tipoproducto SET nombre = ? WHERE id = ?', [nombre, id])

        res.json(row)

    } catch (error) {
        console.log(error);
        
    }
}

const EliminarCategoria = async (req, res) => {

    const { id } = req.body
    try {
        
        const [row] = await db.query('UPDATE tipoproducto SET activo = 0 WHERE id = ?', [id])

        res.json(row)

    } catch (error) {
        console.log(error);
        
    }
}

const MostrarCompras = async (req, res) => {

    try {
        
        const [row] = await db.query('SELECT v.id, v.fechaPago, v.Total, d.estadoEnvio, noGuia, noPedido FROM venta v JOIN ventadetalle d ON v.id = d.idVenta ')
        res.json(row)

    } catch (error) {
        console.log(error);
        
    }
}

const MostrarPedidos = async (req, res) => {

    try {
        
        const [row] = await db.query('SELECT v.id, v.idVenta, v.idProducto, v.estadoEnvio, v2.noGuia, v2.noPedido FROM ventadetalle v JOIN venta v2 on v.idVenta = v2.id')

        let productos = []
        
        for (const element of row) {
            
            const [producto] = await db.query('SELECT descripcion FROM producto WHERE id = ?', [element.idProducto])
            
            productos.push(producto[0])
        }

        res.json({row, productos})

    } catch (error) {
        console.log(error);
        
    }
}

const ModificarNoGuia = async (req, res) => {

    const id = req.query.id
    const No = req.query.numero

    try {
        
        const [row] = await db.query('UPDATE venta SET noGuia = ? WHERE id = ?', [No, id])
        res.json(row)

    } catch (error) {
        res.json({message: "algo salio mal"})
        
    }
}

const ModificrEstatusEntrega = async (req, res) => {

    const id = req.query.id
    const estatus = req.query.estatus

    try {
        console.log(id);
        console.log(estatus);
        
        const [row] = await db.query('UPDATE ventadetalle SET estadoEnvio = ? WHERE id = ?', [estatus, id])
        console.log(row);
        
        res.json(row)

    } catch (error) {   
        console.log(error);
        
    }
}

const MostrarEquipos = async (req ,res) => {

    try {
        
        const [row] = await db.query('SELECT * FROM equipo WHERE activo = 1')

        res.json(row)

    } catch (error) {
        console.log(error);
        
    }
}

const AgregarEquipo = async (req, res) => {

    const { nombre } = req.body

    try {

        const [mayor] = await db.query('SELECT MAX(orden) AS maximo FROM equipo')
        console.log(mayor);
        
        const [row] = await db.query('INSERT INTO equipo (nombre, orden) VALUES (?,?)', [nombre, mayor[0].maximo + 1])

        res.json(row)

    } catch (error) {
        console.log(error);
        
    }
}

const EliminarEquipo = async (req, res) => {

    const id = req.query.id


    console.log(id);
    

    try {
        
        const [row] = await db.query('UPDATE equipo SET activo = 0 WHERE id = ?', [id])

        res.json(row)

    } catch (error) {
        console.log(error);
        
    }
}

const ModificarEquipo = async (req, res) => {

    const nombre = req.query.name 
    const orden = req.query.order 
    const id = req.query.id

    try {
        
        const [row] = await db.query('UPDATE equipo SET nombre,= ?, orden = ? WHERE id = ?' , [nombre, orden, id])

        console.log(row);
    
        res.json(row)

    } catch (error) {
        console.log(error);
        
    } 
}


module.exports = { BuscarImagenEquipo, ModificarEquipo, ModificarNoGuia, EliminarEquipo, AgregarEquipo, MostrarEquipos, ModificrEstatusEntrega, MostrarPedidos, MostrarCompras, EliminarCategoria, ModificarCategoria, ModificarColor, AgregarColor, EliminarColor, SubirImagenProducto, AgregarColorProducto, ELiminarColorDeProducto, ActualizarProducto, BuscarImagenes, ExtraerColores, EliminarColaborador, CrearColaborador, MostrarUsuarios, estadisticas, mostrar_productos, agregar_producto, ObtenerTipos, AgregarCategoria, CambiarEstado, login, EliminarProducto }