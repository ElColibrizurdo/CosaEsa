const express = require('express')
const router = express.Router()
const {estadisticas, mostrar_productos, agregar_producto, ObtenerTipos, AgregarCategoria } = require('./auth')

router.get('/estadisticas', estadisticas)
router.get('/mostrarProductos', mostrar_productos)
router.post('/agregarProducto', agregar_producto)
router.get('/categorias', ObtenerTipos)
router.post('/agregarCategoria', AgregarCategoria)

module.exports = router