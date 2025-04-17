// services/messageService.js (tạo file riêng để tái sử dụng)
const messageModel = require('../Models/Message');

const saveMessage = async (chatId, senderId, text, image, video, file) => {
    const newMessage = new messageModel({
        chatId,
        senderId,
        text,
        ...(image ? { image } : {}),
        ...(video ? { video } : {}),
        ...(file ? { file } : {}),
    });

    return await newMessage.save();
};

module.exports = { saveMessage };
