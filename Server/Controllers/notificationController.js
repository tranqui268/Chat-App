const notificationModel = require("../Models/Notification")

const createNotification = async(req,res) => {
    const {user_id, type, message} = req.body
    try {
        const newNotification = new notificationModel({
            user_id,
            type,
            message
        })
        const response = await newNotification.save();
        res.status(200).json({success: true, message:'Successfully', response})
    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }
}

const readNotification = async (req,res) => {
    try {
        const {user_id} = req.params.userId;
        const notifications = await notificationModel.find({user_id: user_id})
        if (!notifications) return  res.status(404).json({success: false, message:'Notification not found'})

        await notifications.updateMany(
            {user_id: user_id, is_read: false},
            {$set: {is_read: true}}
        )
        return res.status(200).json({ success: true, message: "Notifications marked as read" });
    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }
}

const getNotification = async (req,res) => {
    try {
        const {user_id} = req.params.userId;
        const notifications = await notificationModel.find({user_id: user_id, is_read: false})
        if (!notifications) return  res.status(404).json({success: false, message:'No unread notification found'})
        return res.status(200).json({ success: true, data: notifications });
    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }
}

module.exports = {createNotification, readNotification, getNotification}