const multer = require('multer')
const { CloudinaryStorage } = require('multer-storage-cloudinary')
const cloudinary = require('./cloudinary')

const storage = new CloudinaryStorage({
    cloudinary,
    params: {
      folder: 'chatApp',
      format: async (req, file) => 'png',
      public_id: (req, file) => file.originalname.split('.')[0], 
    },
  });
  
  const upload = multer({ storage });
  
  module.exports = upload;