const jwt = require('jsonwebtoken');

const verifyToken = (req, res, next) => {
    const token = req.headers['authorization']; // Lấy token từ header Authorization

    if (!token) {
        return res.status(403).json({
            success: false,
            message: 'Không có token được cung cấp'
        });
    }

    // Giả sử token có định dạng "Bearer <token>"
    const actualToken = token.split(' ')[1];

    jwt.verify(actualToken, process.env.JWT_SECRET_KEY || 'your-secret-key', (err, decoded) => {
        if (err) {
            return res.status(401).json({
                success: false,
                message: 'Token không hợp lệ hoặc đã hết hạn'
            });
        }

        console.log('Decoded token:', decoded);
        // Gắn thông tin người dùng đã giải mã (ví dụ: userId) vào đối tượng request
        req.userId = decoded._id; // Giả sử payload của token chứa trường 'id'
        next(); // Chuyển sang middleware hoặc hàm xử lý tiếp theo
    });
};

module.exports = verifyToken;