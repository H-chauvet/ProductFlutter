const express = require('express');
const router = express.Router();
const userCtrl = require('../controllers/product');

router.post('/create', async (req, res, next) => {
  try {
    const { name, description, price } = req.body;

    // Vérifier si le nom et le prix sont fournis
    if (!name || !price) {
      return res.status(400).json({ message: 'Name and Price are required.' });
    }

    // Créer le produit dans la base de données
    const product = await userCtrl.createProduct({name, description, price})
    res.status(201).json({ message: 'Product successfully created!', product });
  } catch (err) {
    next(err);
  }
});

module.exports = router;