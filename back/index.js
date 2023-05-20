const express = require('express');
const registerRoute = require('./routes/register')
const loginRoute = require('./routes/login')
const productCreateRoute = require('./routes/product')
var bodyParser = require('body-parser')
const app = express();

app.use(bodyParser.json());

app.use('/api/auth', registerRoute)
app.use('/api/auth', loginRoute)
app.use('/api/product', productCreateRoute)

// Démarrer le serveur
app.listen(3000, () => {
  console.log('Serveur démarré sur le port 3000');
});

