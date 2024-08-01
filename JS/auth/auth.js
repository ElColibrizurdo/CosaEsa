
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const db = require('../Databases/db');
const { response } = require('express');

const register = async (req, res) => {
    const { apodo, nombre, apellidoP, apellidoM, email, password, fechaNa} = req.body;


    try {
        const [rows] = await db.query('SELECT email FROM usuario WHERE email = ?', [email]);

       
        if (rows.length > 0) {
            return res.status(400).json({ message: 'EL usuario ya existe'});
        }

        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);
        console.log(salt);
        console.log(hashedPassword);
        await db.query('INSERT INTO usuario (name, email, password, Activo, Nombres, ApellidoPrimero, ApellidoSegundo, fechaNacimiento) VALUES (?,?,?,?,?,?,?,?)', [apodo, email, hashedPassword, 1, nombre, apellidoP, apellidoM, fechaNa]);
        
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

        const user = rows[0]
        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ message: 'Crendenciales invalidas'});
        } 

        const [row] = await db.query('SELECT id FROM canasta WHERE usuario_id = ?', [user.id])
        const canasta = row[0]

        const payload = {
            userId: user.id,
            userName: user.name,
            canastaId: canasta.id,
            pepe: 'pepe'
        }

        const name = user.name
        const token = jwt.sign(payload, 'mysecretkey', {expiresIn: '1h'});
    
     

        await db.query('INSERT INTO sesion (idUsuario, navegador) VALUES (?,?)', [user.id,userAgent])
        const [sesion] = await db.query('SELECT id FROM sesion WHERE idUsuario = ? ORDER BY horaInicio DESC LIMIT 1', [user.id])
        const set = sesion[0]
        console.log(set.id);
        const [tokens] = await db.query('INSERT INTO tokens (token, sesionid) VALUES (?,?)', [token, set.id] )
       
        
        const decode = jwt.decode(token)
        res.status(200).json({ set, name });
    } catch (error) {
        
        console.log(error);
        res.status(500).json({ message: error.message});
    }
}

const ingresar_producto_canasta = async (req, res) => {

    const { cantidad, id, id_producto, numero, nombre } = req.body;

    console.log(numero);
    console.log(nombre);

    try {
        const [sesion] = await db.query('SELECT idUsuario FROM sesion WHERE id = ?', [id])

        const [canasta] = await db.query('SELECT id FROM canasta WHERE usuario_id = ?', [sesion[0].idUsuario])

        const id_canasta = canasta[0].id
        const row = await db.query('INSERT INTO canasta_productos (cantidad, id_producto, id_canasta) VALUES (?, ?, ?)', [cantidad, id_producto, id_canasta] )
        console.log(row);

        if (numero.length > 0 && nombre.length > 0) {
            
            console.log(row[0].insertId);
            const personalizda = await db.query('INSERT INTO playera_personalizada (numero, nombre, canastapid) VALUES (?,?,?)', [numero, nombre, row[0].insertId])
        }
        res.status(200).json({row})
        
    } catch (error) {
        res.status(500).json({message: error.message})
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
        console.log(rows);
        
        if (rows.length === 0) {
            return res.status(404).json({ message: 'No se encontraron productos en la canasta.' });
        }
        
        console.log(rows);
        res.status(200).json({rows})
    } catch (error) {
        console.log(error);
        res.status(500).json({ message: 'Error interno del servidor.' });
    }
}

const obtener_producto = async (req, res) => {

    const { id } = req.body;

    try {
        
        const producto = await db.query('SELECT * FROM producto WHERE id = ?', [id] )
        console.log(producto[0][0].idTipo);

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
                })

                const [medidas] = await db.query('SELECT * FROM medida WHERE id IN (?)', [idMedidas])
                res.status(200).json({producto, medidas})
                break;
        
            default:

                res.status(200).json({producto})

                break;
        }

        

    } catch (error) {
        console.log(error);        
    }
}

const modificar_cantidad = async (req, res) => {

    const { cantidad, id } = req.body

    try {
        
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

const cerrar_sesion = async (req, res) => {

    const { token } = req.body

    jwt.verify(token, 'mysecretkey', (err, decode) => {
        if (err) {
            if (err.name === 'TokenExpiredError') {
                // Token ha expirado
                return res.status(401).json({ message: 'Token expirado' });
            }
            // Otros errores de token
            return res.status(401).json({ message: 'Token inválido' });
        }
        req.user = decode
    })

    res.status(500).json({message: 'Se cerro'})
}

const obtener_nombre = async (req, res) => {

    const { id } = req.body

    const nombre = await db.query('SELECT token FROM tokens')
}

const dar_like = async (req, res) => {

    const { number, sesion } = req.body

    try {

        const [idUsuario] = await db.query('SELECT idUsuario FROM sesion WHERE id = ?', [sesion])
       
        const [row] = await db.query('INSERT INTO productousuario (idProducto, idUsuario) VALUES (?,?)', [number, idUsuario[0].idUsuario])
        res.status(500).json({row})
    } catch (error) {
        console.log(error);
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
            res.status(500).json({message: 'No tiene like, podre tonto'})
        }
    } catch (error) {
        console.log(error);
    }
}

module.exports = { demostrar_like, dar_like, cerrar_sesion, eliminar_producto_canasta, modificar_cantidad, register, login, ingresar_producto_canasta, mostrar_canasta, obtener_producto };