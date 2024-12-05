const userModel = require("../Models/User");
const bcrypt = require("bcrypt");
const validator = require("validator");
const jwt = require("jsonwebtoken");

const createToken = (_id) => {
    const jwtkey = process.env.JWT_SECRET_KEY;
    return jwt.sign(
        {_id},
        jwtkey,
        {expiresIn: "3d"}
    )
}

const registerUser = async (req, res) => {
    try{
        const {name, email, password} = req.body

        if(!name || !email || !password) return res.status(400).json({success : false, message:'Missing username and/or password' })

        let user = await userModel.findOne({email});
        if(user) return res.status(400).json({success : false, message:'Email already take'})

        if(!validator.isEmail(email)) return res.status(400).json({success : false, message:'Email not valid'})

        user = new userModel({name, email, password});

        const salt = await bcrypt.genSalt(10);
        user.password = await bcrypt.hash(user.password,salt);

        await user.save()

        const token = createToken(user._id);
        res.status(200).json({success: true, message:'Username create successfully',data:{_id: user._id ,name,email,token}})
    }catch (error){
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }
};

const loginUser = async (req, res) => {
    const {email, password} = req.body;
    try {
        let user = await userModel.findOne({ email });
        if(!user) return res.status(400).json({success : false, message:'Invalid email or password' })

        const isValidPassword = bcrypt.compare(password, user.password);
        if(!isValidPassword) return res.status(400).json({success : false, message:'Invalid username aor password' })

        const token = createToken(user._id);
        res.status(200).json({success: true, message:'Login successfully',data:{_id: user._id ,name: user.name,email,token}})
    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }
}

const findUser = async (req,res) =>{
    const userId = req.params.userId;
    try {
        const user = await userModel.findById(userId);

        res.status(200).json({success: true, message:'Successfully', user})
    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }
}

const getUser = async (req,res) =>{
    try {
        const users = await userModel.find();

        res.status(200).json({success: true, message:'Successfully', users})
    } catch (error) {
        console.log(error)
        res.status(500).json({
            success: false, message:'Internal server error'
        })
    }
}

module.exports = {registerUser, loginUser, findUser, getUser};
