const mongoose = require('mongoose')

const userSchema = new mongoose.Schema({
    name : {
        type: String, 
        required : true, 
        minlength: 3, 
        maxlength: 30
    },
    email : {
        type: String, 
        required: true,
        unique: true
    },
    password : {
        type: String,
        required: true,
        minlength: 8,
        maxlength: 1024
    },
    avatar : {
        type : String,
        default : 'https://res.cloudinary.com/dhis8yzem/image/upload/v1741011247/chatApp/Avatar_default.png'
    }
},
{
    timestamps: true
});

module.exports = mongoose.model("users",userSchema);
