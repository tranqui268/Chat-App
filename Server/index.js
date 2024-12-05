require('dotenv').config();
const express = require("express");
const cors = require("cors");
const mongoose = require("mongoose");
const userRoute = require("./Routes/UserRoute")

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

const port = 5000;

app.listen(port, (req, res) => {
    console.log(`Server run on port: ${port}`);
} )