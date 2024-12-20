const jwt = require('jsonwebtoken')

const autheticate = async (req, res, next) => {

    const token = req.header('Authorization')?.replace('Bearer ', '')
    console.log('Hola');
    
    console.log(token);

    if (!token) {
        
        return res.status(401).json({message: 'Access denied '})
    }

    try {
        const decode = jwt.verify(token, 'adpabasta')
        console.log(decode);
        req.user = decode
        console.log('Se pudo mi gente');
        next()
    } catch (error) {
        console.error('Error al verificar el token:', error.message);
        res.status(400).json({message: 'Invalid token'})
    }
}

module.exports = autheticate