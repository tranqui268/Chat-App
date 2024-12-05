const chatModel = require("../Models/Chat")


// createChat
const createChat = async(req,res) => {
    const {firstId, secondId} = req.body
    try {
        
    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }
}
// getUserChats
// findChat