// Get an instance of mysql
let mysql = require('mysql2')

// Create a 'connection pool' using the provided credentials
const pool = mysql.createPool({
    waitForConnections: true,
    connectionLimit   : 10,
    host              : 'classmysql.engr.oregonstate.edu',
    user              : 'cs340_armsjack',
    password          : '4538',
    database          : 'cs340_armsjack'
}).promise(); 


module.exports = pool;
