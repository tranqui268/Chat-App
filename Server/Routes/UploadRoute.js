const express = require('express')
const router = express.Router()
const upload = require('../Configs/multerConfig')
const { uploadImage } = require('../Controllers/uploadController')

router.post('/upload', upload.single('image'), uploadImage);

module.exports = router;