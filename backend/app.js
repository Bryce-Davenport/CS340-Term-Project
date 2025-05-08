const express = require('express');
const exphbs = require('express-handlebars');
const db = require('./db-connector');

const app = express();
const PORT = 4401; 

// Handlebars setup
app.engine('.hbs', exphbs.engine({ extname: '.hbs' }));
app.set('view engine', '.hbs');
app.set('views', __dirname + '/../frontend/views'); 

// Body parser for form data
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Static assets 
app.use(express.static(__dirname + '/../frontend'));

// Sample route )
app.get('/', (req, res) => {
  res.sendFile(__dirname + '/../frontend/index.html');
});

// Start server
app.listen(PORT, () => {
  console.log(`Server listening on http://classwork.engr.oregonstate.edu:${PORT}`);
});