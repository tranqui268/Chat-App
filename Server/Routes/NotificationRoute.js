const express = require('express')
const {createNotification, readNotification, getNotification} = require('../Controllers/notificationController')
const router = express.Router()

router.post("/",createNotification)
router.put("/read",readNotification)
router.get("/",getNotification)

module.exports = router