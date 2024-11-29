const path = require('path')
const express = require('express')
const bodyParser = require('body-parser')
const authRoutes = require('../src/auth/Routes')
const protectedRoutes = require('../src/proteccion/proy')
const multer = require('multer')
const app = express()
const http = require('http')
const https = require('https')
const fs = require('fs');

app.use(bodyParser.json())

app.use(bodyParser.urlencoded({extended:true}))
app.use('/auth', authRoutes)

app.use('/protected', protectedRoutes)

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

app.get('/catalogoEquipos', (req, res) => {
    res.sendFile(path.join(__dirname, 'Equipos', 'Equipos.html'))
})

app.get('/AgregarEquipo', (req, res) => {
    res.sendFile(path.join(__dirname, 'Equipos', 'AgregarEquipo.html'))
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

app.get('/catalogoBanners', (req, res) => {

    res.sendFile(path.join(__dirname, 'Banners', 'Banners.html'))
})

const storage = multer.diskStorage({
    destination: function (req, file, cb) { 

        console.log('vamos a sacar la ruta');
        

        let uploadPath

        try {
            const fullUrl = req.protocol + '://' + req.get('host') + req.originalUrl 

            const parts = fullUrl.split('?')

            if (parts[1] == 'equipo') {
                uploadPath = path.join(__dirname, 'img', 'logos')
            } else if (parts[1] == 'banners') {
                uploadPath = path.join(__dirname, 'img', 'banners')
            } else {
                uploadPath = path.join(__dirname, 'img', 'articulos')
            }


            cb(null, uploadPath)
        } catch (error) {
            console.log(error);
            cb(error)
        }      
    },
    filename: function (req, file, cb) {

        const { id } = req.body

        if (!id) {
            return cb(new Error('ID no proporcionado'), false);
        }

        console.log('vamos a sacar los nombres de ruta');
        
        console.log(file);
        

        let filePath 
        let baseName = id + path.extname(file.originalname)  

        

        try {
            const fullUrl = req.protocol + '://' + req.get('host') + req.originalUrl 
            
            
            const parts = fullUrl.split('?')

            if (parts[1] == 'equipo') {
                
                baseName = 'logo_' + id + '.png'
                filePath = path.join(__dirname, 'img', 'logos')
            } else if (parts[1] == 'banners') {
                
                baseName = id
                filePath = path.join(__dirname, 'img', 'banners')

            } else {

                const files = req.files || [];
                filePath = path.join(__dirname, 'img', 'articulos', baseName)

                if (fs.existsSync(filePath)) {
                    if (files.length === 0) {
                        // Primer archivo: usa el ID como nombre
                        baseName = `${id}${path.extname(file.originalname)}`; // Usar la extensión original
                    } else {
                        // Archivos subsiguientes: usa id_n
                        const index = files.length; // La longitud de files es igual al número de archivos subidos
                        baseName = `${id}_${index}${path.extname(file.originalname)}`; // Usar la extensión original
                    }
                }
            }

            if (!id) {
                return cb(new Error('ID no proporcionado'), false);
            }
    
            /*if (fs.existsSync(filePath)) {
                
                baseName = `${baseName}_${Date.now()}${path.extname(file.originalname)}`
            }*/
            console.log(baseName);
            
            cb(null, baseName)
        } catch (error) {
            console.log(error);
        }      
    }
})

const upload = multer({storage: storage})

app.post('/upload', upload.array('images'), async  (req, res) => {

    

    if (!req.file || req.files.length == 0) {
        return res.status(400).send('No se ha subido ningún archivo.');
      }

      const {id} = req.body
      const uploadedFiles = req.files.map(file => ({
        filename: file.filename,
        path: file.path,
        url: `${req.protocol}://${req.get('host')}/img/${file.filename}`
        }));

        res.json({
            message: 'Archivos subidos exitosamente',
            data: {
                id,
                files: uploadedFiles
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