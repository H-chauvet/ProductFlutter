const express = require('express');
const bodyParser = require('body-parser');
const bcrypt = require('bcryptjs');
const { PrismaClient } = require('@prisma/client');
require('dotenv').config({ path: '.env' })
const prisma = new PrismaClient();
const app = express();

app.use(bodyParser.json());

// Endpoint pour l'inscription d'un utilisateur
app.post('/signup', async (req, res) => {
  const { username, password } = req.body;

  // Vérifier si l'utilisateur existe déjà dans la base de données
  const existingUser = await prisma.user.findUnique({
    where: {
      username: username,
    },
  });

  if (existingUser) {
    return res.status(409).json({ message: 'Cet utilisateur existe déjà.' });
  }

  // Hasher le mot de passe avant de l'enregistrer
  const hashedPassword = await bcrypt.hash(password, 10);

  try {
    // Créer un nouvel utilisateur dans la base de données
    const newUser = await prisma.user.create({
      data: {
        username: username,
        password: hashedPassword,
      },
    });

    res.status(201).json({ message: 'Utilisateur inscrit avec succès.' });
  } catch (error) {
    console.error('Erreur lors de l\'inscription de l\'utilisateur :', error);
    res.status(500).json({ message: 'Une erreur est survenue lors de l\'inscription.' });
  }
});

// Démarrer le serveur
app.listen(3000, () => {
  console.log('Serveur démarré sur le port 3000');
});

