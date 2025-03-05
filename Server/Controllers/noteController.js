const { get } = require('mongoose')
const noteModel = require('../Models/Note')

// create Note
const createNote = async(req,res) =>{
    const {user_id, content} = req.body
    const newNote = new noteModel({
        user_id,
        content
    })

    try {
        const response = await newNote.save()
        res.status(200).json({success: true, message:'Successfully', response})
    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }
}

// get Note
const getNote = async(req,res) =>{
    const {user_id} = req.params.userId;

    try {
        const note = await noteModel.find(user_id)
        res.status(200).json({success: true, message: 'Successfully', note})
    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }
}

module.exports = {createNote,getNote}