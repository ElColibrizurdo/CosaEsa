const express = require('express')
const router = express.Router()
const autheticate = require('./addlwelre');
const { raw } = require('body-parser');
const { login } = require('../auth/auth');

router.get('/', autheticate, (req, res) => {

    
    const id = req.user.id
    const name = req.user.name
    const email = req.user.email
    const apellido = req.user.ApellidoPrimero

    console.log('prueba');
    
    console.log(id);
    

    res.json({
        message: 'ruta protegida',
        id,
        name,
        email,
        apellido
    })
})

module.exports = router