const contactModel = require('../Models/Contact')
const userModel = require('../Models/User')
const chatModel = require('../Models/Chat')

const getContacts = async (req, res) => {
    try {
        const userId = req.userId;

        const contacts = await contactModel.find({ userId })
                              .populate('contactId', 'name email avatar')
                              .lean();
        res.status(200).json(contacts);
    } catch (error) {
        console.error('Error fetching contacts:', error);
        res.status(500).json({ message: 'Server error' });
    }
}

const addContact = async (req, res) => {
    try {
        const userId = req.userId;
        const { email } = req.body;

        const contactExists = await userModel.findOne({email});
        if (!contactExists){
            return res.status(404).json({message: 'Contact not found'});
        }

        if (contactExists._id.toString() === userId) {
            return res.status(400).json({ message: 'You cannot add yourself as a contact' });
        }

        const contactId = contactExists._id;

        const existingContact = await contactModel.findOne({ userId, contactId });
        if (existingContact) {
            return res.status(400).json({ message: 'Contact already exists' });
        }

        const newContact = new contactModel({ userId, contactId });
        await newContact.save();

        const populatedContact = await contactModel.findById(newContact._id)
            .populate('contactId', 'name avatar')
            .lean();

        res.status(201).json({ message: 'Contact added', contact: populatedContact });
    } catch (error) {
        console.error('Error adding contact:', error);
        res.status(500).json({ message: 'Server error' });
    }
}


module.exports = {getContacts, addContact};