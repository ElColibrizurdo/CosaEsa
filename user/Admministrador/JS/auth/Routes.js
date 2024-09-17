const express = require('express');
const router = express.Router();
const { obtener_estadisticas } = require('./auth.js')

router.get('/estadisticas', obtener_estadisticas)

module.exports = router;