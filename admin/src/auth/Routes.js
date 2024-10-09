const express = require('express')
const router = express.Router()
const { ExtraerColores, EliminarColaborador, CrearColaborador, MostrarUsuarios, estadisticas, mostrar_productos, agregar_producto, ObtenerTipos, AgregarCategoria, CambiarEstado, login, EliminarProducto } = require('./auth')

router.get('/estadisticas', estadisticas)
router.get('/mostrarProductos', mostrar_productos)
router.post('/agregarProducto', agregar_producto)
router.get('/categorias', ObtenerTipos)
router.post('/agregarCategoria', AgregarCategoria)
router.post('/cambiarEstado', CambiarEstado)
router.get('/login', login)
router.post('/eliminarProducto', EliminarProducto)
router.get('/mostrarUsuarios', MostrarUsuarios)
router.post('/agregarColaborador', CrearColaborador)
router.get('/eliminarColaborador', EliminarColaborador)
router.get('/colores', ExtraerColores)

module.exports = router