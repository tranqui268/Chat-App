const express = require('express');
const { createChat, getUserChats, findChat, getInactiveTime, checkChat } = require('../Controllers/chatController');
const updateLastActive = require('../middleware/updateLastActive')

const router = express.Router();

// @Route POST api/chat/
// @desc Create chat
// @access Private
router.post("/",updateLastActive, createChat);

// @Route GET api/chat/:userId
// @desc  get user chat
// @access Private
router.get("/",updateLastActive, getUserChats);

// @Route GET api/chat/find/:firstId/:secondId
// @desc Find chat
// @access Private
router.get("/find/:secondId",updateLastActive, findChat);

router.get("/inactive-time", getInactiveTime);

router.post("/checkChat", checkChat)

module.exports = router;