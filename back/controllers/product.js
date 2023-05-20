const bodyParser = require('body-parser');
const bcrypt = require('bcryptjs');
const { db } = require('../middleware/database')

exports.createProduct = product => {
    try {
      const createdProduct = db.Product.create({
        data: product,
      });
      return createdProduct;
    } catch (error) {
      console.error('Error creating product:', error);
      throw new Error('Failed to create product');
    }
  };