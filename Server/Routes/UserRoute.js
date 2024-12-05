const express = require('express')
const {registerUser, loginUser, findUser, getUser} = require("../Controllers/userController");

const router = express.Router();


// @Route POST api/auth/register
// @desc Register user
// @access Public
router.post("/register", registerUser);

// @Route POST api/auth/login
// @desc Login user
// @access Public
router.post("/login", loginUser);

// @Route GET api/auth/find/user/:userId
// @desc Find user by id
// @access Private
router.get("/find/user/:userId", findUser);

// @Route POST api/auth/users
// @desc Get all user
// @access Private
router.get("/users", getUser);
module.exports = router;