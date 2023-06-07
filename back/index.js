const express = require('express');
const userRoutes = require('./routes/user')
const productsRoutes = require('./routes/product')
var bodyParser = require('body-parser')
const app = express();

var cors = require('cors')

app.use(bodyParser.json());
app.use(cors())

app.use('/api/auth', userRoutes)
app.use('/api/product', productsRoutes)

// Démarrer le serveur
app.listen(3000, () => {
  console.log('Serveur démarré sur le port 3000');
});

