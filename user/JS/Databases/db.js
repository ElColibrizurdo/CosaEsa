const mysql = require('mysql2/promise');

//Configurar la conexion con la base de datos
const db = mysql.createPool({
    host: '127.0.0.1',
    user: 'sangrael',
    password: 'warhammer',
    database: 'ventaspeople'
});



module.exports = db;
