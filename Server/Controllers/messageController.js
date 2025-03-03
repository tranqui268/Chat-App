const messageModel = require('../Models/Message')

// create message
const createMessage = async(req,res) =>{
    const {chatId, senderId, text, image, video, file} = req.body
    const newMessage = new messageModel({
        chatId,
        senderId,
        text,
        ...(image ? {image} : {} ),
        ...(video ? {video} : null ),
        ...(file ? {file} : null ),
    });
    try {
       const response = await newMessage.save();
       res.status(200).json({success: true, message:'Successfully', response})

    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }
}

// getMessages
const getMessages = async(req, res) =>{
    const {chatId} = req.params;

    try {
        const messages = await messageModel.find({ chatId });
        res.status(200).json({success: true, message:'Successfully', messages})
    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }
}

module.exports = {createMessage, getMessages}