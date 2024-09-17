const express = require('express')
const router = express.Router()
const {estadisticas, mostrar_productos, agregar_producto } = require('./auth')

router.get('/estadisticas', estadisticas)
router.get('/mostrarProductos', mostrar_productos)
router.post('/agregarProducto', agregar_producto)

module.exports = router