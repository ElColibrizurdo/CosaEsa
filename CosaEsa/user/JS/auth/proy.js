const express = require('express')
const router = express.Router()
const autheticate = require('./addlwelre');
const { raw } = require('body-parser');

router.get('/', autheticate, (req, res) => {

    
    const id = req.user.userId
    const name = req.user.userName
    const canasta = req.user.canastaId

    

    res.json({
        message: 'ruta protegida',
        id,
        name,
        canasta
    })
})

module.exports = router