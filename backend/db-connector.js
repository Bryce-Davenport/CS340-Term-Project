/*
    # Citation:
    # Date: 06/09/25
    # Scope: File
    # Based on: Activity 2
    # Source URL: https://canvas.oregonstate.edu/courses/1999601/assignments/10006370?module_item_id=25352883

    # Copied from CS340 webapp starter code
*/

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
