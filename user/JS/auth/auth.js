process.env.NODE_TLS_REJECT_UNAUTHORIZED = '0';

const bcrypt = require('bcryptjs');
const crypto =require('crypto')
const jwt = require('jsonwebtoken');
const db = require('../Databases/db');
const { response } = require('express');
const nodemailer = require('nodemailer');
const { text, json } = require('body-parser');
const { log } = require('console');
require('dotenv').config()

function GenerarVerificacion() {
    
    return crypto.randomBytes(20).toString('hex');
}

function MandarVerificacion(email, token) {
    
    const verificationUrl = `/verify-email?token=${token}`;

    let transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: process.env.EMAIL_USER,
            pass: process.env.EMAIL_PASS,
        },
    })

    let mailOptions = {
        from: process.env.EMAIL_USER,
        to: email,
        subject: 'Asunto',
        text: 'Prueba de correo',
        html: `Por favor verifica tu cuenta haciendo clic en el siguiente enlace: ${verificationUrl}`,
    }

    transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
            return error
            
        }
        return info
    })
}

const register = async (req, res) => {
    const { apodo, nombre, apellidoP, apellidoM, email, password, fechaNa} = req.body;
    
    try {
        const [rows] = await db.query('SELECT email FROM usuario WHERE email = ?', [email]);
        const token = GenerarVerificacion()
       
        if (rows.length > 0) {
            return res.status(400).json({ message: 'EL usuario ya existe'});
        }

        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);
        console.log(salt);
        console.log(hashedPassword);
        await db.query('INSERT INTO usuario (name, email, password, Activo, Nombres, ApellidoPrimero, ApellidoSegundo, fechaNacimiento, token, verificado) VALUES (?,?,?,?,?,?,?,?,?,?)', [apodo, email, hashedPassword, 1, nombre, apellidoP, apellidoM, fechaNa, token, 1]);
        
        MandarVerificacion(email, token)
        res.status(201).json({ message: 'Usuario registrado'});

    } catch (error) {
        console.log(error);
        res.status(500).json({message: 'Server error'});
    }
};  

const login = async (req, res) => {

    const { email, password, userAgent } =  req.body;


    try {
        const [rows] = await db.query('SELECT * FROM usuario WHERE email = ?', [email]);


        if (rows.length === 0) {
            return res.status(400).json({message: 'Credenciales invalidas'})
        } 
        
        if (rows[0].verificado != 1) {
            console.log(rows[0].verificado);
            
            return res.status(400).json({message: 'Falta verificado'})
        }

        const user = rows[0]
        const isMatch = await bcrypt.compare(password, user.password);
        console.log(isMatch);
        
        if (!isMatch) {
            console.log('Crednciales invalidas');
            
            return res.status(400).json({ message: 'Crendenciales invalidas'});
        } 

        const [row] = await db.query('SELECT id FROM canasta WHERE usuario_id = ?', [user.id])
        const canasta = row[0]

        console.log(user.id);
        

        const [idCliente] = await db.query('SELECT id FROM cliente WHERE idUsuario = ?', [user.id])
        console.log(idCliente);

        if (!idCliente[0]) {
            
            idCliente[0] = { id: 0}
        }
        

        const payload = {
            userId: user.id,
            userName: user.name,
            canastaId: canasta.id,
            clienteid: idCliente[0].id,
            pepe: 'pepe'
        }

        const name = user.name
        const token = jwt.sign(payload, 'mysecretkey', {expiresIn: '7d'});
    
        

        await db.query('INSERT INTO sesion (idUsuario, navegador) VALUES (?,?)', [user.id,userAgent])
        const [sesion] = await db.query('SELECT id FROM sesion WHERE idUsuario = ? ORDER BY horaInicio DESC LIMIT 1', [user.id])
        const set = sesion[0]
       
        
        const decode = jwt.decode(token)
        res.status(200).json({ set, name, token });
    } catch (error) {
        
        console.log(error);
        res.status(500).json({ message: error.message});
    }
}

const recuperar_contra = async (req, res) => {

    const { email, pass } = req.body

    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(pass, salt);

    const token = GenerarVerificacion()

    try {
        
        const [comparar] = await db.query('SELECT password FROM usuario WHERE email = ?', [email])
        const isMatch = await bcrypt.compare(pass, comparar[0].password)
        console.log('isMatch ' + isMatch);
        console.log(pass);
        
        console.log(comparar[0].password);
        
        
        if (isMatch) {
            
            res.status(500).json({message: 'No se puede usar la contraseña anterior'})
            
        } else {

            const [row] = await db.query('UPDATE usuario SET password = ?, verificado = FALSE, token = ? WHERE email = ?', [hashedPassword, token, email])
    
            console.log(row);

            if (row.changedRows == 1) {
            
                const respuesta = MandarVerificacion(email, token)
                console.log(respuesta);
                
                res.status(200).json({message: 'ok'})
            } 
        }

        
        
    } catch (error) {
        console.log(error);
        res.status(500).json({message: error})
    }
}

const ingresar_producto_canasta = async (req, res) => {

    const { cantidad, id, id_producto, numero, nombre, precio, talla, color } = req.body;    

    
 
    console.log('Nombre personalizado: ' + nombre);
    console.log('Color: ' + color);
    
    
    let message = ''

    try {

        numero.forEach(async (element, indice) => {

            const total = parseFloat(precio[indice]) - parseFloat((precio[indice] / 1.16))

            const [sesion] = await db.query('SELECT idUsuario FROM sesion WHERE id = ?', [id])

            const [canasta] = await db.query('SELECT id FROM canasta WHERE usuario_id = ?', [sesion[0].idUsuario])
            console.log('id canasta: ' + canasta[0].id);
            
            const id_canasta = canasta[0].id
            const [row] = await db.query('INSERT INTO canasta_productos (cantidad, id_producto, id_canasta, precio, total, iva, id_medida, numero, etiqueta, color) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)', 
                [cantidad / numero.length, id_producto, id_canasta, precio[indice] / 1.16, precio[indice] ,  total, talla[indice], element, nombre[indice], color[indice]] )
            
                if (row.affectedRows == 1) {
                    message = 'ok'
                    
                } 

                if (indice == 0) {
                
                    res.status(200).json({message: message})
                }
        })

        res.status(20).json({message: message})
        console.log('Siguiente');
        
        
    } catch (error) {
    }
}

const mostrar_canasta = async (req, res) => {

    const { id } = req.body;
    console.log(id);

    try {

        const [sesion] = await db.query('SELECT idUsuario FROM sesion WHERE id = ?', [id])
        console.log(sesion[0].idUsuario);
        const [canasta] = await db.query('SELECT id FROM canasta WHERE usuario_id = ?', [sesion[0].idUsuario])
        console.log(canasta[0].id);
        const [rows, fields] = await db.query('SELECT * FROM canasta_productos WHERE id_canasta = ?', [canasta[0].id])
        console.log('canasta');
        
        console.log(rows);
        
        if (rows.length === 0) {
            return res.status(404).json({ message: 'No se encontraron productos en la canasta.' });
        }
        
        res.status(200).json({rows})
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: 'Error interno del servidor.' });
    }
}

const obtener_tipoProducto = async(req, res)=>{
    const { idProducto } = req.body;
    console.log("auth.js-obtener_tipoProducto-idProducto:" + idProducto);

    try{
        const [tipoProducto] = await db.query('SELECT p1.* FROM producto p1 inner join  producto p2 On p2.idtipo = p1.idTipo And p2.id <> p1.id  And p2.id = ? Order by p1.precio asc limit 5', [idProducto] )

        console.log(tipoProducto);
        res.status(200).json({tipoProducto})

    } catch (error) {
        console.log(error);        
    }

}

const obtener_producto = async (req, res) => {

    const { id } = req.body;

    try {
        
        const producto = await db.query('SELECT * FROM producto WHERE id = ?', [id] )
        const color = await db.query('SELECT c.color, c.id FROM colores_producto cp INNER JOIN colores c ON cp.idColor = c.id WHERE cp.idProducto = ?', [id])
        console.log(producto[0][0].idTipo);
        console.log('colores: ');
        console.log(color);
        console.log(id);
        
        
        

        switch (producto[0][0].idTipo) {
            case 1:
            case 2:
            case 3:
            case 4:
            case 9:
                const [pMedidas] = await db.query('SELECT * FROM productomedidas WHERE idProducto = ? ', [id])
                console.log('Medidas');
                let idMedidas = []

                pMedidas.forEach(element => {

                    idMedidas.push(element.idMedida)
                    console.log(element);
                    
                })

                const [medidas] = await db.query('SELECT * FROM medida WHERE id IN (?)', [idMedidas])
                res.status(200).json({producto, medidas, color})
                break;
        
            default:

                res.status(200).json({producto, color})

                break;
        }

        

    } catch (error) {
        console.log(error);        
    }
}

const modificar_cantidad = async (req, res) => {

    const { cantidad, id } = req.body

    try {
        
        console.log(cantidad, id);
        const modifcacion = await db.query('UPDATE canasta_productos SET cantidad = ? WHERE id = ?', [cantidad, id])
        res.status(200).json({modifcacion})
    } catch (error) {
        console.log(error);
    }
}

const eliminar_producto_canasta = async (req, res) => {

    const { id } = req.body

    try {
        
        const eliminar = await db.query('DELETE FROM canasta_productos WHERE id = ?', [id])
        res.status(200).json({eliminar})
    } catch (error) {
        console.log(error);
    }
}



const obtener_nombre = async (req, res) => {

    const { id } = req.body

    const nombre = await db.query('SELECT token FROM tokens')
}

const dar_like = async (req, res) => {

    const { number, sesion, estado } = req.body
    let [row] = ''

    console.log('sesion p' + sesion);
    

    try {

        const [idUsuario] = await db.query('SELECT idUsuario FROM sesion WHERE id = ?', [sesion])
        console.log('idUsuario ' + idUsuario);
        

        if (estado == 0) {
             [row] = await db.query('INSERT INTO productousuario (idProducto, idUsuario) VALUES (?,?)', [number, idUsuario[0].idUsuario])
            
        } else {
             [row] = await db.query('DELETE FROM productousuario WHERE idUsuario = ? AND idProducto = ?', [idUsuario[0].idUsuario, number])
            
        }
        
        res.json({row})
    } catch (error) {
    }

}

const demostrar_like = async (req, res) => {

    const { number, sesion } = req.body

    try {
        
        const [idUsuario] = await db.query('SELECT idUsuario FROM sesion WHERE id = ?', [sesion])
        const [row] = await db.query('SELECT * FROM productousuario WHERE idUsuario = ? AND idProducto = ?', [idUsuario[0].idUsuario, number])
        
        if (row.length > 0) {
            res.status(500).json({row})
        } else {
            res.status(500).json({})
        }
    } catch (error) {
        console.log(error);
    }
}

const obtener_Compras = async(req, res)=>{
    const { idSesion } = req.body;
    console.log("auth.js-obtener_Compras-idSesion:" + idSesion);

    try{
        const [compraProducto] = await db.query(`SELECT p.id, v2.noPedido, v.fechaAlta, p.descripcion, v.total, v.estadoEnvio FROM ventadetalle v 
            JOIN producto p ON p.id = v.idProducto 
            JOIN venta v2 ON v.idVenta = v2.id 
            JOIN cliente c ON c.id = v2.idCliente 
            JOIN usuario u ON u.id = c.idUsuario 
            JOIN sesion s ON s.idUsuario = u.id
            WHERE  s.id = ?`, [idSesion] )

            console.log(compraProducto);
        res.status(200).json({compraProducto})

    } catch (error) {
        console.log(error);        
    }

}

const registrar_cliente = async (req, res) => {

    const {
        sesion,
        nombre,
        primerApellido,
        segundoApellido,
        calle,
        numExterior,
        numInterior,
        colonia,
        codigo,
        municipio,
        entidad,
        pais,
        card,
        fecha
    } = req.body

    try {
        const [idUsuario] = await db.query('SELECT idUsuario FROM sesion WHERE id = ?', [sesion])
        console.log(idUsuario[0]?.idUsuario);
        
        const [row] = await db.query('CALL actualizarCliente (?,?,?,?,?,?,?,?,?,?,?,?,?,?)', 
        [idUsuario[0]?.idUsuario, nombre, primerApellido, segundoApellido, calle, numExterior, numInterior, colonia, codigo, municipio, entidad, pais, card, fecha])
       
        console.log(fecha);
        
        console.log(row);
        
        res.status(200).json({row})
    } catch (error) {
        console.log(error);
    }
}

const guardar_metodos = async (req, res) => {

    const { numbers, dateE, cod, name, sesion } = res.body

    try {
        
        const idUsuario = db.query('SELECT idUsuario FROM sesion WHERE id = ?', [sesion])
        const [row] = db.query('INSERT INTO metodos_pago (idUsuario, cardNumber, fechaExpiracion)')

        console.log(row);

        res.status(200).json({row})
        

    } catch (error) {
        
    }
}

const cantidad_cesta = async (req, res) => {

    const token = req.query.token
    
    console.log('token');
    
    console.log(token);
    

    try {

        fetch('https://tienda.people.com/protected/', {
            method: 'GET',
            headers: {
                'Authorization': 'Bearer ' + token 
            }
        })
        .then(response => {
            console.log('Response status:', response.status);
            console.log('Response headers:', response.headers.get('content-type'));
            
            // Verificar si la respuesta es exitosa (status 200)
            if (!response.ok) {
                throw new Error('Error en la respuesta del servidor: ' + response.statusText);
            }
            
            const contentType = response.headers.get('content-type');
            
            // Si el tipo de contenido es JSON, lo procesamos como tal
            if (contentType && contentType.includes('application/json')) {
                return response.json();
            } else {
                // Si no es JSON, lo procesamos como texto (para inspeccionar posibles errores)
                return response.text();
            }
        })
        .then(async data => {
          
            if (typeof data === 'string' && data.startsWith('<')) {
                console.log('Error del servidor (HTML):', data);
                throw new Error('La respuesta no contiene JSON válido. HTML recibido.');
            }
    
            console.log('Datos recibidos:', data);
    
            // Consulta a la base de datos usando `data.canasta`
            const [row] = await db.query('SELECT COUNT(*) AS cantidad FROM canasta_productos WHERE id_canasta = ?', [data.canasta]);
    
            res.json(row);
            
        })
        .catch(error => {
            console.log(error + 'Error en la solicitud');
        })
        
        
        

    } catch (error) {
        console.log(error + 'Error en la operacion');
        
    }
}

const cliente_existe = async (req, res) => {

    const token = req.query.token
    console.log(token);
    

    try {

        fetch('https://tienda.people.com//protected', {
            method: 'GET',
            headers: {
                'Authorization': 'Bearer ' + token
            }
        })
        .then(response => response.json())
        .then(async data => {
            console.log('cliente existe');
            
            console.log(data);
            

            const [row] = await db.query('SELECT EXISTS ( SELECT 1 FROM cliente WHERE idUsuario = ?) AS EXISTE', [data.id])

            if (row[0].EXISTE == 1) {
            
                const [cliente] = await db.query('SELECT * FROM cliente WHERE idUsuario = ?', [data.id])
                const [metodo] = await db.query('SELECT * FROM metodos_pago WHERE idUsuario = ?', [data.id])
                console.log(cliente);
                console.log(metodo);
                
                res.json({row, cliente})
            } else {
    
                res.json(row)
            }
        })
    } catch (error) {
        console.log(error);
        
    }

}

const verificarContra = async (req, res) => {

    const contra = req.query.pass
    const token = req.query.sesion

    console.log(token);
    

    try {

        fetch('https://tienda.people.com//protected', {
            method: 'GET',
            headers: {
                'Authorization': 'Bearer ' + token
            }
        })
        .then(response => response.json())
        .then(async data => {

            console.log(data);
            
            const [row] = await db.query('SELECT password FROM usuario WHERE id = ?', [data.id])

            console.log(row);
            
            bcrypt.compare(contra, row[0].password, function (err, result) {
            
                if (err) {
    
                } else if (result) {
                    console.log('contraseña correcta');
                    res.json(true)
                    
                } else {
                    res.json(false)
                }
            })
        })
        
    } catch (error) {
        console.log(error);
        
    }
}

const RealizarVenta = async (req, res) => {

    const { idSesion, token } = req.body


    try {

        fetch('https://tienda.people.com//protected', {
            method: 'GET',
            headers: {
                'Authorization': 'Bearer ' + token
            }
        })
        .then(response => response.json)
        .then(async data => {

            const [existe] = await db.query('SELECT EXISTS (SELECT s.idUsuario FROM sesion s JOIN cliente c ON s.idUSuario = c.idUsuario WHERE s.id = ?) AS existe', [idSesion])
        
            if (existe[0].existe == 1) {
            
                const [row] = await db.query('CALL ventaspeople.compraCanasta(?)', [idSesion])


                console.log('Se realizo la venta');
                console.log(row);
        
                res.status(500).json({existe, row})
            } else{
    
                res.status(200).json({existe})
            }
        })

    } catch (error) {
        
        console.log(error);
        
    }
}

const cerrar_sesion = async (req, res) => {

    const { token } = req.body

    console.log(token);
    

    try {

        fetch('https://tienda.people.com/protected', {
            method: 'GET',
            headers: {
                'Authorization': 'Bearer ' + token
            }
        })
        .then(response => response.json())
        .then(async data => {

            console.log('data');
            
            console.log(data);
            console.log('data id');
            
            console.log(data.id);
            

            const now = new Date();
            const year = now.getFullYear();
            const month = (now.getMonth() + 1).toString().padStart(2, '0'); // Los meses empiezan en 0
            const day = now.getDate().toString().padStart(2, '0');
            const hours = now.getHours().toString().padStart(2, '0');
            const minutes = now.getMinutes().toString().padStart(2, '0');
            const seconds = now.getSeconds().toString().padStart(2, '0');
            
            const dateTime = `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;

            console.log(dateTime);
            

            const [row] = await db.query('UPDATE sesion SET horaTermino = ? WHERE idUsuario = ? ORDER BY horaInicio DESC LIMIT 1', [dateTime, data.id])

            console.log("cerrar sesion " + row)
            
            res.status(200).json(row)
            
        })
        

    } catch (error) {
        console.log(error);
        
    }
}

const FiltrosHome = async (req, res) => {

    const saltos = req.query.saltos
    const producto = req.query.producto

    try {
        console.log(producto);
        
        console.log(req.query);
        
        console.log(saltos);
        
        
        
        const [productos] = await db.query('SELECT * FROM producto WHERE descripcion LIKE ? LIMIT 5 OFFSET ?', [producto, parseInt(saltos[0])*5])
        const [masVendidos] = await db.query('SELECT p.* FROM producto p JOIN ventadetalle v on v.idProducto = p.id GROUP BY v.idProducto  HAVING COUNT(*) >= 3 LIMIT 5 OFFSET ?', [parseInt(saltos[2])])
        const [preventa] = await db.query('SELECT * FROM producto WHERE estado = 0 LIMIT 5 OFFSET ?', [parseInt(saltos[4])])

        console.log('Filtrados:');


        res.json({productos, masVendidos, preventa})
    } catch (error) {
        console.log(error);
        
    }
}



const barra_buscar = async (req, res) => {

    const { elemento } = req.body

    console.log(elemento);
    

    try {
        
        const [row] = await db.query('SELECT * FROM producto WHERE descripcion LIKE ?', [elemento])
        console.log(row);
        

        res.status(200).json(row)
    } catch (error) {
        console.log(error);
        
    }
}

const recuperar_colores_producto = async (req, res) => {

    const { idProducto } = req.query.id

    try {
        const [row] = db.query('SELECT c.color FROM colores_producto cp INNER JOIN colores c ON cp.idColor = c.id WHERE cp.idProducto = ?', [idProducto])

        console.log(row);

        res.status(200).json(row)
    } catch (error) {
        console.log(error);
        
    }
    
}

const mostrar_filtros = async (req, res) => {

    try {
        
        const [tipos] = await db.query('SELECT id, nombre FROM tipoproducto WHERE activo = 1 ORDER BY id')
        const [equipos] = await db.query('SELECT id, nombre FROM equipo WHERE activo = 1 ORDER BY id')
        
        res.json({tipos, equipos})

    } catch (error) {
        console.log(error);
        res.status(500),json(error)
    }
}

const determinar_ubicacion = async (req, res) => {

    const pais = req.query.pais
    const cod = req.query.cod

    try {

        console.log(pais);
        console.log(cod);
        
        const [row] = await db.query('SELECT DISTINCT c.d_asenta, e.Nombre, c.d_codigo, c.idPais FROM colonia c INNER JOIN estado e ON e.id = c.idEstado WHERE c.d_codigo = ? AND c.idPais = (SELECT id FROM pais WHERE Nombre = ?)', [cod, pais])
        
        res.json(row)

    } catch (error) {
        console.log(error);
        
    }
}

const mostrar_paises = async (req, res) => {

    try {
        
        const [row] = await db.query('SELECT id, Nombre FROM pais')

        res.json(row)

    } catch (error) {
        console.log(error);
        res.status(500).json(error)
        
    }
}

module.exports = { determinar_ubicacion, mostrar_paises, mostrar_filtros, recuperar_contra, recuperar_colores_producto, barra_buscar, FiltrosHome, RealizarVenta, verificarContra, cliente_existe, cantidad_cesta, guardar_metodos, registrar_cliente, obtener_tipoProducto, obtener_Compras, demostrar_like, dar_like, cerrar_sesion, eliminar_producto_canasta, modificar_cantidad, register, login, ingresar_producto_canasta, mostrar_canasta, obtener_producto };