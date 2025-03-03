require('dotenv').config();
const express = require("express");
const cors = require("cors");
const mongoose = require("mongoose");
const userRoute = require("./Routes/UserRoute")
const chatRoute = require("./Routes/ChatRoute")
const messageRoute = require("./Routes/MessageRoute")
const uploadRoute = require("./Routes/UploadRoute")
const noteRoute = require("./Routes/NoteRoute")

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

app.use(express.json());
app.use(cors());
app.use("/api/auth", userRoute);
app.use("/api/chat", chatRoute);
app.use("/api/message", messageRoute);
app.use("/api", uploadRoute);
app.use("/api/note", noteRoute);

const port = 5000;

app.listen(port, (req, res) => {
    console.log(`Server run on port: ${port}`);
} )