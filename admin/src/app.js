const path = require('path')
const express = require('express')
const bodyParser = require('body-parser')
const authRoutes = require('../src/auth/Routes')
const multer = require('multer')
const app = express()
const http = require('http')
const https = require('https')
const fs = require('fs');

app.use(bodyParser.json())

app.use(bodyParser.urlencoded({extended:true}))
app.use('/auth', authRoutes)

app.use(express.static(path.join(__dirname, '/')))
app.get('/', (req,res) => {
    res.sendFile(path.join(__dirname, 'Usuarios', 'IniciarSesion.html'))
})

app.get('/bienvenida', (req, res) => {
    res.sendFile(path.join(__dirname,  'Bienvenido', 'Bienvenido.html'))
})

app.get('/productos', (req, res) => {
    res.sendFile(path.join(__dirname, 'Productos', 'Productos.html'))
})

app.get('/pagos', (req, res) => {
    res.sendFile(path.join(__dirname, 'Compras', 'Compras.html'))
})

app.get('/pedidos', (req, res) => {
    res.sendFile(path.join(__dirname, 'Pedidos', 'Pedidos.html'))
})

app.get('/ventas', (req, res) => {
    res.sendFile(path.join(__dirname, 'Pedidos', 'Productos.html'))
})

app.get('/catalogoTallas', (req, res) => {
    res.sendFile(path.join(__dirname, 'CatalogoTallas', 'Categorias.html'))
})

app.get('/agregarProducto', (req, res) => {
    res.sendFile(path.join(__dirname, 'NuevoProducto', 'NuevoPorducto.html'))
})

app.get('/MostrarCategorias', (req, res) => {
    res.sendFile(path.join(__dirname, 'Categorias', 'Categorias.html'))
})

app.get('/AgregarCategoria', (req, res) => {
    res.sendFile(path.join(__dirname, 'Categorias', 'AgregarCategori.html'))
})

app.get('/inventario', (req, res) => {
    res.sendFile(path.join(__dirname, 'Inventario', 'Inventario.html'))
})

app.get('/admins', (req, res) => {
    res.sendFile(path.join(__dirname, 'Admins', 'Admin.html'))
})

app.get('/crearColaboradores', (req, res) => {
    res.sendFile(path.join(__dirname, 'Admins', 'CrearAdmin.html'))
})

app.get('/catalogoColores', (req, res) => {
    res.sendFile(path.join(__dirname, 'CatalogoColores' ,'Color.html'))
})

app.get('/agregarColores', (req, res) => {
    res.sendFile(path.join(__dirname, 'CatalogoColores' ,'AgregarColor.html'))
})

const storage = multer.diskStorage({
    destination: function (req, file, cb) { 

        console.log('El nombre original: ');
        
        console.log(file.originalname);
        
        const uploadPath = path.join(__dirname, 'img', 'articulos')

        cb(null, uploadPath)
    },
    filename: function (req, file, cb) {

        const { id } = req.body

        let baseName = id + path.extname(file.originalname)

        const filePath = path.join(__dirname, 'img', 'articulos', baseName)

        if (!id) {
            return cb(new Error('ID no proporcionado'), false);
        }

        if (fs.existsSync(filePath)) {
            
            baseName = `${baseName}_${Date.now()}${path.extname(file.originalname)}`
        }

        cb(null, baseName)
    }
})

const upload = multer({storage: storage})

app.post('/upload', upload.single('image'), async  (req, res) => {
    if (!req.file) {
        return res.status(400).send('No se ha subido ningún archivo.');
      }

      const {id} = req.body
      // Puedes enviar la ruta donde se guardó la imagen de vuelta al cliente
      res.send({
        filename: req.file.filename,
        data: {
            id
        }
    });
})

const server = http.createServer(app)

const sslOptions = {
    key: fs.readFileSync(path.join(__dirname, 'asf_2024.key')),
    cert: fs.readFileSync(path.join(__dirname, 'server.crt'))
}

https.createServer(sslOptions, app).listen(443, () => {
    console.log('Servidor HTTPS en accion en el puerto 443 por el sagrado emperador de la humidad postrado en el trono dorado');
    
})

// server.listen(8080, () => {

// })

/*app.listen(3000, () => {
    console.log(`Server corriendo en 3000`);
    
})*/

module.exports = app