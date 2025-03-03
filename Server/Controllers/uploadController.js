const cloudinary = require('../Configs/cloudinary');

const uploadImage = async (req, res) => {
    try {
      if (!req.file) {
        return res.status(400).json({ message: 'No file uploaded' });
      }
  
      // Lấy URL ảnh đã upload
      const imageUrl = req.file.path;
  
      res.status(200).json({ imageUrl });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: 'Upload failed', error });
    }
  };
  
  module.exports = { uploadImage };