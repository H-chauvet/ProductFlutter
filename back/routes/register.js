const express = require('express')
const router = express.Router()
const userCtrl = require('../controllers/register')

router.post('/register', async function (req, res, next) {
    try {
        const { username, password } = req.body
        if (!username || !password) {
            return res.status(400).json({message: 'Username and Password are required.'});
        }

        const existingUser = await userCtrl.findByUsername(username)
        if (existingUser) {
            return res.status(409).json({message: 'User already exits.'});
        }
        const user = await userCtrl.registerUser({username, password})
        res.status(201).json({message: 'Account successfully created !'})
    } catch (err) {
        next(err)
    }
})

module.exports = router