const express = require('express');
const { createChat, getUserChats, findChat } = require('../Controllers/chatController');


const router = express.Router();

// @Route POST api/chat/
// @desc Create chat
// @access Private
router.post("/",createChat);

// @Route GET api/chat/:userId
// @desc  get user chat
// @access Private
router.get("/:userId", getUserChats);

// @Route GET api/chat/find/:firstId/:secondId
// @desc Find chat
// @access Private
router.get("/find/:firstId/:secondId", findChat);

module.exports = router;