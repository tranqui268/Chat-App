const express = require('express')
const {createNote, getNote} = require('../Controllers/noteController')

const router = express.Router()

router.post("/", createNote)
router.get("/:userId", getNote)

module.exports = router