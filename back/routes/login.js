const express = require('express');
const router = express.Router();
const userCtrl = require('../controllers/login');

router.post('/login', async function (req, res, next) {
  try {
    const { username, password } = req.body;
    if (!username || !password) {
      return res.status(400).json({ message: 'Username and Password are required.' });
    }

    const user = await userCtrl.findByUsername(username);
    if (!user) {
      return res.status(401).json({ message: 'User not found.' });
    }

    const isValidPassword = await userCtrl.checkPassword(user, password);
    if (!isValidPassword) {
      return res.status(401).json({ message: 'Invalid password.' });
    }

    res.status(200).json({ message: 'Login successful.' });
  } catch (err) {
    next(err);
  }
});

module.exports = router;
