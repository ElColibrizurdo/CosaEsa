const path = require('path')
const express = require('express')
const bodyParser = require('body-parser')
const authRoutes = require('../auth/Routes')
const multer = require('multer')
const app = express()

app.use(bodyParser.json())

app.use(bodyParser.urlencoded({extended:true}))
app.use('/auth', authRoutes)

app.use(express.static(path.join(__dirname, '..')))
app.get('/', (req,res) => {
    res.sendFile(path.join(__dirname, '..', 'Bienvenido', 'Bienvenido.html'))
})

app.get('/login', (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'Usuarios', 'IniciarSesion.html'))
})

app.get('/productos', (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'Productos', 'Productos.html'))
})

app.get('/agregarProducto', (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'NuevoProducto', 'NuevoPorducto.html'))
})

app.get('/MostrarCategorias', (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'Categorias', 'Categorias.html'))
})

app.get('/AgregarCategoria', (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'Categorias', 'AgregarCategori.html'))
})

app.get('/inventario', (req, res) => {
    res.sendFile(path.join(__dirname, '..', 'Inventario', 'Inventario.html'))
})

const storage = multer.diskStorage({
    destination: function (req, file, cb) {

        console.log(file.originalname);
        
        const uploadPath = path.join(__dirname, '..', 'img')

        cb(null, uploadPath)
    },
    filename: function (req, file, cb) {

        cb(null, Date.now() + path.extname(file.originalname))
    }
})

const upload = multer({storage: storage})

app.post('/upload', upload.single('image'), (req, res) => {
    if (!req.file) {
        return res.status(400).send('No se ha subido ningún archivo.');
      }
      // Puedes enviar la ruta donde se guardó la imagen de vuelta al cliente
      res.send(req.file.filename);
})

app.listen(3000, () => {
    console.log(`Server corriendo en 3000`);
    
})

module.exports = app