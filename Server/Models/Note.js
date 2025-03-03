const mongoose = require('mongoose')

const noteSchema = mongoose.Schema({
    user_id : {
        type : mongoose.Schema.Types.ObjectId,
        ref : "users",
        require : true
    },
    content : {
        type : String,
        require : true
    },
},
{   
    timestamps : true
})

const noteModel = mongoose.model("Note",noteSchema)
module.exports = noteModel