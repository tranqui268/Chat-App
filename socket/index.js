const { Server } = require('socket.io')

const io = new Server({
    cors: {
        origin: "*", // Cấp quyền cho mọi nguồn gốc
        methods: ["GET", "POST"],
      },
});

let onlineUsers = []

io.on("connection", (socket) => {
    console.log("new connection",socket.id)

    // listen to connection
    socket.on("addNewUser", (userId) => {
        !onlineUsers.some(user => user.userId === userId) && // kiểm tra user có tồn tại trong array onlineUsers
            onlineUsers.push({
                userId,
                socketId: socket.id
            });
    });
    console.log("onlineUsers", onlineUsers);
});

io.listen(3000);