const express = require('express')
const router = express.Router()
const {estadisticas, mostrar_productos, agregar_producto, ObtenerTipos, AgregarCategoria, CambiarEstado, login } = require('./auth')

router.get('/estadisticas', estadisticas)
router.get('/mostrarProductos', mostrar_productos)
router.post('/agregarProducto', agregar_producto)
router.get('/categorias', ObtenerTipos)
router.post('/agregarCategoria', AgregarCategoria)
router.post('/cambiarEstado', CambiarEstado)
router.get('/login', login)

module.exports = router