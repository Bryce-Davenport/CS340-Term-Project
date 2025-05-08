const express = require('express');
const exphbs = require('express-handlebars');
const db = require('./db-connector');
const path = require('path');

const app = express();
const PORT = 4401; 

// Handlebars setup
app.engine('hbs', exphbs.engine({ extname: 'hbs' }));
app.set('view engine', 'hbs');
app.set('views', __dirname + '/../frontend/views'); 

// Body parser for form data
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Sample route )
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, '../frontend/index.html'));
});

// orderItems route
app.get('/orderitems', (req, res) => {
  res.render('orderitems');
});

app.get('/products', (req, res) => {
  res.render('products');
});

app.get('/orders', (req, res) => {
  res.render('orders');
});

app.get('/customers', (req, res) => {
  res.render('customers');
});


// Static assets 
app.use(express.static(__dirname + '/../frontend'));

// Start server
app.listen(PORT, () => {
  console.log(`Server listening on http://classwork.engr.oregonstate.edu:${PORT}`);
});