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

exports.updateProductById = (id, productData) => {
  try {
    const updatedProduct =  db.Product.update({
      where: { id },
      data: productData,
    });
    return updatedProduct;
  } catch (error) {
    console.error('Error updating product:', error);
    throw new Error('Failed to update product');
  }
};

exports.deleteProductById = async (id) => {
  try {
    await db.Product.delete({
      where: { id },
    });
  } catch (error) {
    console.error('Error deleting product:', error);
    throw new Error('Failed to delete product');
  }
};

exports.findById = id => {
  try {
    const product = db.Product.findUnique({ where: { id } });
    return product;
  } catch (error) {
    console.error('Error retrieving product by ID:', error);
    throw new Error('Failed to retrieve product by ID');
  }
};

exports.getAllProducts = async () => {
  try {
    const products = await db.Product.findMany();
    return products;
  } catch (error) {
    console.error('Error retrieving products:', error);
    throw new Error('Failed to retrieve products');
  }
};

