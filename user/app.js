const https = require('https')
const fs = require('fs')
const login = require('./JS/auth/auth')
const express = require('express');
const path = require('path');
const app = express();
const db = require('./JS/Databases/db');
const bodyParser = require('body-parser');
const authRoutes = require('./JS/auth/Routes')
const protectedR = require('./JS/auth/proy');
const adminRoutes = require('./Admministrador/JS/auth/Routes')
const { log } = require('console');


const options = {
    key: fs.readFileSync(path.join(__dirname, 'server.key')),
    cert: fs.readFileSync(path.join(__dirname, 'server.crt')),
}


app.use(bodyParser.json());


app.use(bodyParser.urlencoded({ extended: true }));
app.use('/auth', authRoutes);
app.use('/protected', protectedR)

// Servir archivos estáticos desde la carpeta "public"
app.use(express.static(path.join(__dirname)));

// Servir el archivo index.html en la ruta raíz
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'HTML', 'Home.html'));
});

app.get('/tienda', (req, res) => {
    res.sendFile(path.join(__dirname, 'HTML', 'tiendaPlus.html'))
})

app.get('/home', (req, res) => {
    res.sendFile(path.join(__dirname, 'HTML', 'Home.html'))
})

app.get('/bienvenido', (req, res) => {
    res.sendFile(path.join(__dirname, 'Admministrador', 'HTML', 'Bienvenido.html'))
})

app.get('/canasta', (req, res) => {

    const id = req.query.id

    res.sendFile(path.join(__dirname, 'HTML', 'agregar_canasta.html'));
});

app.get('/login', (req, res) => {
    res.sendFile(path.join(__dirname, 'HTML', 'IniciarSesion.html'))
})

app.get('/registro', (req, res) => {
    res.sendFile(path.join(__dirname, "HTML", "Registrarse.html"))
})

app.get('/recuperar', (req, res) => {
    res.sendFile(path.join(__dirname, 'HTML', 'Recuperar_COntra.html'))
})

app.get('/compras', (req, res) => {
    res.sendFile(path.join(__dirname, 'HTML', 'Compras.html'))
})

app.get('/favoritos', (req, res) => {
    res.sendFile(path.join(__dirname, 'HTML', 'Favoritos.html'))
})

app.get('/compras', (req, res) => {
    res.sendFile(path.join(__dirname, 'HTML', 'Compras.html'))
})

app.get('/datos', (req, res) => {
    res.sendFile(path.join(__dirname, 'HTML', 'Datos.html'))
})

app.post('/data', async (req, res) => {

    const { tipos, equipos, stock, buscar } = req.body;

    if (!Array.isArray(tipos) || !Array.isArray(equipos)) {
        return res.status(400).json({ error: 'Tipos y equipos deben ser arrays' });
    }

    let values = [];
    let equiposCondition = '';
    let tiposCondition = '';
    let queryWhere = ''

    console.log(buscar);
    

    try {
        let queryEquipo = ''
            let queryTipo = ''
        let query = "SELECT p.id, p.idTipo, p.descripcion, p.idEquipo, p.precio, p.numeroLikes, p.estado FROM producto p ";
        queryWhere +=  ` WHERE p.descripcion LIKE "${buscar}"`

        if (equipos.length > 0 || tipos.length > 0 || stock.length > 0) {

            
            
            queryWhere += ` AND p.id LIKE "%"` 

            if (equipos.length > 0) {
                
                queryEquipo = ` JOIN equipo e ON p.idEquipo = e.id`
                queryWhere += ` AND e.id IN (${equipos})`
            }

            if (tipos.length > 0) {
                
                queryTipo = ' JOIN tipoproducto t ON p.idTipo = t.id'
                queryWhere += ` AND t.id IN (${tipos})`
            }

            if (stock.length > 0) {
                
                queryWhere += ` AND p.estado IN (${stock})`
            }

            
        }

        query += queryEquipo + queryTipo + queryWhere

        const [rows] = await db.query(query, values);
        console.log(query);
        
        
        res.json(rows);
    } catch (err) {
        console.error('Error al hacer la consulta ', err);
        res.status(500).send('Error interno del servidor');
    }
});

app.get('/verify-email', async (req, res) => {

    const token = req.query.token

    console.log(token);
    

    try {
        
        const [row] = await db.query('SELECT * FROM usuario WHERE token = ?', [token])

       console.log(row);
       
        

        if (row.length !== 0) {
            
            const [updateQuery] = await db.query('UPDATE usuario SET verificado = TRUE, token = NULL WHERE token = ?', [token])
            
            console.log(updateQuery);
            
        } else {
            
        }
        


    } catch (error) {
        console.log(error);
        
    }
})

app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(500).sendFile(path.join(__dirname, 'HTML', 'Errores', 'Error500.html'));
});

app.get('/check-db', (req, res) => {
    db.query('SELECT 1 + 1 AS solution', (err, results) => {
        if (err) {
            console.error('Error al ejecutar la consulta:', err.stack);
            res.status(500).json({ error: 'Error al ejecutar la consulta' });
        } else {
            res.json({ message: 'Conexión exitosa a la base de datos', solution: results[0].solution });
        }
    });
});

app.use((req, res, next) => {
    res.status(404).sendFile(path.join(__dirname, 'HTML', 'Errores', 'Error404.html'))
})

app.use((req, res, next) => {
    res.status(404).sendFile(path.join(__dirname, 'HTML', 'Errores', 'Error400.html'))
})

app.use((req, res, next) => {
    res.status(404).sendFile(path.join(__dirname, 'HTML', 'Errores', 'Error503.html'))
})


/*const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor web escuchando en el puerto ${PORT}`);
   
});*/

const server = https.createServer(options, app);

const PORT = process.env.PORT || 8080

app.listen(PORT, () => {
    console.log(`Servidor HTTPS escuchando en el puerto ${PORT}`);
})



module.exports = app;
