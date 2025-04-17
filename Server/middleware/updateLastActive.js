const User = require("../Models/User")

const updateLastActive = async (req, res, next) => {
    try {
        const userId = req.userId; 
        await User.findByIdAndUpdate(userId, { lastActive: new Date() });
        next();
    } catch (error) {
        console.log(error);
        res.status(500).json({ success: false, message: 'Internal server error' });
    }
};

module.exports = updateLastActive;