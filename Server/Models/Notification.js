const mongoose = require('mongoose')
const NotificationType = require('../Heplers/enums/NotificationType')

const notificationSchema = mongoose.Schema({
    user_id: {
        type: mongoose.Schema.Types.ObjectId,
        ref: "users",
        require: true
    },
    type: {
        type: String,
        enum: Object.values(NotificationType),
        require: true
    },
    message : {
        type: String,
        require: true
    },
    is_read: {
        type: Boolean,
        default: false
    }   

},{
    timestamps : true
})


module.exports = mongoose.model("notification",notificationSchema);