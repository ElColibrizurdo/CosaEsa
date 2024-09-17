const express = require('express')
const router = express.Router()
const {estadisticas, mostrar_productos } = require('./auth')

router.get('/estadisticas', estadisticas)
router.get('/mostrarProductos', mostrar_productos)

module.exports = router