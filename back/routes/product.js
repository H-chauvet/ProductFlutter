const express = require('express');
const router = express.Router();
const userCtrl = require('../controllers/product');

router.post('/create', async (req, res, next) => {
  try {
    const { name, description, price } = req.body;

    if (!name || !price) {
      return res.status(400).json({ message: 'Name and Price are required.' });
    }

    const product = await userCtrl.createProduct({name, description, price})
    res.status(201).json({ message: 'Product successfully created!', product });
  } catch (err) {
    next(err);
  }
});

router.post('/update', async (req, res, next) => {
  try {
    const { id, name, description, price } = req.body;

    if (!id || !name || !description || !price) {
      return res.status(400).json({ message: 'ID, Name, Description, and Price are required.' });
    }

    const existingProduct = await userCtrl.findById(id);
    if (!existingProduct) {
      return res.status(404).json({ message: 'Product not found.' });
    }

    const updatedProduct = await userCtrl.updateProductById(id, { name, description, price });
    res.status(200).json({ message: 'Product successfully updated!', product: updatedProduct });
  } catch (err) {
    next(err);
  }
});

router.post('/delete', async (req, res, next) => {
  try {
    const { id } = req.body;

    if (!id) {
      return res.status(400).json({ message: 'ID is required.' });
    }
    const existingProduct = await userCtrl.findById(id);
    if (!existingProduct) {
      return res.status(404).json({ message: 'Product not found.' });
    }

    await userCtrl.deleteProductById(id);

    res.status(200).json({ message: 'Product successfully deleted!' });
  } catch (err) {
    next(err);
  }
});

router.get('/list', async (req, res, next) => {
  try {
    const products = await userCtrl.getAllProducts();

    res.status(200).json({ products });
  } catch (err) {
    next(err);
  }
});




module.exports = router;