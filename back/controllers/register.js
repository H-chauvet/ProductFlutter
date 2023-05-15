const bodyParser = require('body-parser');
const bcrypt = require('bcryptjs');
const { db } = require('../middleware/database')

exports.findByUsername = username => {
  return db.User.findUnique({
    where: {
      username
    }
  })
}

exports.registerUser = user => {
  user.password = bcrypt.hashSync(user.password, 12)
  return db.User.create({
      data: user
  })
}