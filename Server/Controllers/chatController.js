const chatModel = require("../Models/Chat")


// createChat
const createChat = async(req,res) => {
    const {firstId, secondId} = req.body
    try {
        const chat = await chatModel.findOne({
            members: {$all: [firstId, secondId]}
        });
        if(chat) return res.status(200).json({success: true, message:'Successfuly!', chat})

        const newChat = new chatModel({
            members: [firstId, secondId]
        });
        const response = await newChat.save();
        res.status(200).json({success: true, message:'Successfuly!', response})
    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }
}

// getUserChats
const getUserChats = async(req, res) => {
    const userId = req.params.userId;
    try {
        const chats = await chatModel.find({
            members : {$in: [userId]}
        })
        res.status(200).json({success: true, message:'Successfuly!', chats})

    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }
}

// findChat
const findChat = async(req,res) => {
    const {firstId, secondId} = req.params

    try {
        const chat = await chatModel.findOne({
            members: {$all: [firstId, secondId]}
        })

        res.status(200).json({success: true, message:'Successfuly!', chat})
    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }
}

module.exports = {createChat, findChat, getUserChats};