const chatModel = require("../Models/Chat");
const User = require("../Models/User");


// createChat
const createChat = async(req,res) => {
    const {secondId} = req.body
    try {
        const chat = await chatModel.findOne({
            members: {$all: [req.userId, secondId]}
        });
        if(chat) return res.status(200).json({success: true, message:'Successfuly!', chat})

        const newChat = new chatModel({
            members: [req.userId, secondId]
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
    const userId = req.userId;
    try {
        const chats = await chatModel.aggregate([
            // Lọc các chat có userId trong members
            { $match: { members: { $in: [userId] } } },
            // Kết hợp với collection messages
            {
                $lookup: {
                    from: 'messages', // Tên collection của Message trong MongoDB
                    localField: '_id',
                    foreignField: 'chatId',
                    as: 'messages'
                }
            },
            // Sắp xếp tin nhắn theo createdAt và lấy tin nhắn cuối cùng
            {
                $project: {
                    members: 1,
                    lastMessage: {
                        $arrayElemAt: [
                            { $sortArray: { input: '$messages', sortBy: { createdAt: -1 } } },
                            0
                        ]
                    }
                }
            },
            // Tinh chỉnh dữ liệu trả về
            {
                $project: {
                    members: 1,
                    lastMessageContent: {
                        $cond: {
                            if: { $gt: [{ $size: { $ifNull: ['$lastMessage.image', []] } }, 0] },
                            then: 'Đã gửi một hình ảnh',
                            else: {
                                $cond: {
                                    if: { $ne: ['$lastMessage.video', null] },
                                    then: 'Đã gửi một video',
                                    else: {
                                        $cond: {
                                            if: { $ne: ['$lastMessage.file', null] },
                                            then: 'Đã gửi một file',
                                            else: '$lastMessage.text'
                                        }
                                    }
                                }
                            }
                        }
                    },
                    lastMessageTime: '$lastMessage.createdAt',
                    lastMessageSender: '$lastMessage.senderId'
                }
            }
        ]);

        res.status(200).json({ success: true, message: 'Successfuly!', chats });

    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }
}

// findChat
const findChat = async(req,res) => {
    const secondId = req.params

    try {
        const chat = await chatModel.findOne({
            members: {$all: [req.userId, secondId]}
        })

        res.status(200).json({success: true, message:'Successfuly!', chat})
    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }
}

// inactive-time
const getInactiveTime = async(req,res) => {
    try {
        const userId = req.userId
        const user = await User.findById(userId)

        if(!user){
            return res.status(404).json({ success: false, message: 'User not found' });
        }

        const lastActive = new Date(user.lastActive)
        const now = new Date()
        const inActiveTimeMs = now - lastActive

        const seconds = Math.floor(inactiveTimeMs / 1000);
        const minutes = Math.floor(seconds / 60);
        const hours = Math.floor(minutes / 60);
        const days = Math.floor(hours / 24);

        const result = {
            milliseconds: inactiveTimeMs,
            seconds: seconds,
            minutes: minutes,
            hours: hours,
            days: days,
            lastActive: lastActive.toLocaleString('vi-VN')
        };

        res.status(200).json({
            success: true,
            message: 'Successfuly!',
            inactiveTime: result
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }


}

module.exports = {createChat, findChat, getUserChats, getInactiveTime};