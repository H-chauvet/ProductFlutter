const express = require('express')
const router = express.Router()
const userCtrl = require('../controllers/register')

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

module.exports = router