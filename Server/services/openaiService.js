const OpenAl = require('openai')
require('dotenv').config();

const openai = new OpenAl({
    apiKey: `${process.env.MY_API_KEY}`
})