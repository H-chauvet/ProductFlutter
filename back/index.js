const express = require('express');
const registerRoute = require('./routes/register')
const loginRoute = require('./routes/login')
var bodyParser = require('body-parser')
const app = express();

app.use(bodyParser.json());

app.use('/api/auth', registerRoute)
app.use('/api/auth', loginRoute)

// Démarrer le serveur
app.listen(3000, () => {
  console.log('Serveur démarré sur le port 3000');
});

