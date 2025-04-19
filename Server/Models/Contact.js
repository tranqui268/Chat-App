// Models/Contact.js
const mongoose = require('mongoose');

const contactSchema = new mongoose.Schema({
    userId: { type: String, required: true }, 
    contactId: { type: mongoose.Schema.Types.ObjectId, ref: 'users', required: true }, 
    createdAt: { type: Date, default: Date.now },
});

const contactModel = mongoose.model('Contact', contactSchema);
module.exports = contactModel;