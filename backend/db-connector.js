// Get an instance of mysql
let mysql = require('mysql2')

// Create a 'connection pool' using the provided credentials
const pool = mysql.createPool({
    waitForConnections: true,
    connectionLimit   : 10,
    host              : 'classmysql.engr.oregonstate.edu',
    user              : 'cs340_davenpbr',
    password          : '5120',
    database          : 'cs340_davenpbr'
}).promise(); 


module.exports = pool;
