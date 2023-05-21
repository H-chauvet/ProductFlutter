const express = require('express')
const router = express.Router()
const userCtrl = require('../controllers/user')

router.post('/register', async function (req, res, next) {
    try {
        const { username, password, confirmPassword } = req.body;
        if (!username || !password || !confirmPassword) {
            return res.status(400).json({ message: 'Username, Password, and Confirm Password are required.' });
        }

        if (password !== confirmPassword) {
            return res.status(400).json({ message: 'Passwords are not the same.' });
        }

        const existingUser = await userCtrl.findByUsername(username)
        if (existingUser) {
            return res.status(409).json({message: 'User already registered.'});
        }
        const user = await userCtrl.registerUser({username, password})
        res.status(201).json({message: 'Account successfully created !'})
    } catch (err) {
        next(err)
    }
})

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

module.exports = router