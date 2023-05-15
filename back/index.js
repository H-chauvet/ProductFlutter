const express = require('express');
const bodyParser = require('body-parser');
const bcrypt = require('bcryptjs');
const { PrismaClient } = require('@prisma/client');
require('dotenv').config({ path: '.env' })
const prisma = new PrismaClient();
const app = express();

app.use(bodyParser.json());

app.get('/', (req, res) => {
  res.send('Configurateur server!')
})

// Démarrer le serveur
app.listen(3000, () => {
  console.log('Serveur démarré sur le port 3000');
});
