const mongoose = require('mongoose');

const messageSchema = new mongoose.Schema({
    chatId: {
        type : mongoose.Schema.Types.ObjectId,
        ref : "Chat",
        require : true
    },
    senderId: String,
    text: String,
    image: Array,
    video: { type: String, default: null }, // video là chuỗi
    file: { type: String, default: null },  // file là chuỗi
},
{
    timestamps: true
})

const messageModel = mongoose.model("Message",messageSchema);
module.exports = messageModel