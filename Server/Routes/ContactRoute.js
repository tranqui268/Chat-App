const express = require('express');
const {getContacts, addContact} = require('../Controllers/contactController')
const verifyToken = require('../middleware/auth')

const router = express.Router();

router.get('/', verifyToken, getContacts);
router.post('/', verifyToken, addContact);


module.exports = router;