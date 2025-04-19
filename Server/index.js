require('dotenv').config();
const express = require("express");
const cors = require("cors");
const { Server } = require("socket.io")
const http = require('http')
const mongoose = require("mongoose");
const userRoute = require("./Routes/UserRoute")
const chatRoute = require("./Routes/ChatRoute")
const messageRoute = require("./Routes/MessageRoute")
const uploadRoute = require("./Routes/UploadRoute")
const noteRoute = require("./Routes/NoteRoute")
const notificationRoute = require("./Routes/NotificationRoute")
const contactRoute = require("./Routes/ContactRoute")
const verifyToken = require("./middleware/auth");
const { createMessage } = require('./Controllers/messageController');
const { saveMessage } = require('./middleware/saveMessage');

const connectDB = async () => {
    try {
        await mongoose.connect(`mongodb+srv://${process.env.DB_USERNAME}:${process.env.DB_PASSWORD}@cluster0.7qmgo.mongodb.net/chat_app?retryWrites=true&w=majority&appName=Cluster0`
        )

        console.log('MongoDB connected')
    } catch (error) {
        console.log(error.message)
        process.exit(1)
    }

}
connectDB()

const app = express();

const server = http.createServer(app);
const io = new Server(server, {
    cors: {
        origin: "*", // Cấp quyền cho mọi nguồn gốc
        methods: ["GET", "POST"],
      },
});


io.on("connection", (socket) => {
    console.log("new connection",socket.id)

    // listen to connection
    socket.on('joinConversation', (conservationId)=>{
        socket.join(conservationId);
        console.log("User joined conversation: " + conservationId);
        
    })

    socket.on('sendMessage', async (message) => {
        console.log('Received message from client:', message);
        const {chatId, senderId, text, image, video, file} = message;

        try {
            const savedMessage = await saveMessage(chatId, senderId, text, image, video, file);
            console.log("sendMessage : ");
            console.log(savedMessage);
            io.to(chatId).emit('newMessage', savedMessage);

            io.emit('conversationUpdated',{
                chatId,
                lastMessage: savedMessage.text,
                lastMessageTime: savedMessage.createdAt

            });
            
        } catch (error) {
            console.error('Failed to save message:', error);
        }
    });

    socket.on('disconnect',()=>{
        console.log("User disconnected", socket.id);
        
    })
});


app.use(express.json());
app.use(cors());
app.use("/api/auth", userRoute);
app.use("/api/chat", verifyToken, chatRoute);
app.use("/api/message", messageRoute);
app.use("/api/upload", uploadRoute);
app.use("/api/note", noteRoute);
app.use("/api/notification", notificationRoute);
app.use("/api/contact", contactRoute);

const port = 5000;

server.listen(port,(req, res) => {
    console.log(`Server run on port: ${port}`);
} )