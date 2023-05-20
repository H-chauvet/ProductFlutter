const bodyParser = require('body-parser');
const bcrypt = require('bcryptjs');
const { db } = require('../middleware/database')

async function findByUsername(username) {
  try {
    const user = await db.User.findUnique({ where: { username } });
    return user;
  } catch (err) {
    console.error('Error retrieving user by username:', err);
    throw new Error('Failed to retrieve user by username');
  }
}

async function checkPassword(user, password) {
  
  try {
    const passwordMatch = await bcrypt.compare(password, user.password);
    return passwordMatch;
  } catch (err) {
    console.error('Error checking password:', err);
    throw new Error('Failed to check password');
  }
}

module.exports = { findByUsername, checkPassword };