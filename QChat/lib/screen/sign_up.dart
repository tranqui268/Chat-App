import 'package:chat_app/constant.dart';
import 'package:chat_app/screen/forgot_password_page.dart';
import 'package:flutter/material.dart';


class SignUp extends StatelessWidget{
  const SignUp({super.key});
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
       elevation: 2.0,
       title: const Text("Sign In", style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold
        )
       ),
       shadowColor: Colors.green,
       flexibleSpace: Container(
        decoration:const BoxDecoration(
          gradient: LinearGradient(
             colors: [Constants.primaryColor, Colors.greenAccent],
                begin: Alignment.topLeft,
              end: Alignment.topRight
          )         
        ),
       ),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        alignment: Alignment.center,
        child: Column(        
          children: [
            _EmailInput(),
            const SizedBox(height: 20,),
            _NameInput(),
            const SizedBox(height: 20,),
            _PasswordInput(),
            const SizedBox(height: 20,),
            _ConfirmPasswordInput(),
            const SizedBox(height: 50,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                shape: BoxShape.rectangle,
                color: Constants.primaryColor
              ),
              width: 400,
              child: _ButtonSignUp()
            ),

          ],
        ),
      ),

   );
  }
   
}

class _EmailInput extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        hintText: 'Email Address',
        border: OutlineInputBorder()
      ),
    );
  }
  
}

class _NameInput extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        hintText: 'Fullname',
        border: OutlineInputBorder()
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        hintText: 'Password',
        border: OutlineInputBorder()
        
      ),
      obscureText: true,
    );
  }
  
}

class _ConfirmPasswordInput extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        hintText: 'Confirm Password',
        border: OutlineInputBorder()
        
      ),
      obscureText: true,
    );
  }
  
}

class _ButtonSignUp extends StatefulWidget{
  @override
  _ButtonSignUpState createState() => _ButtonSignUpState();
}

class _ButtonSignUpState extends State<_ButtonSignUp>{
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (){
          setState(() {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ForgotPassword()));
          });
        },
        child: const Text(
            'Sign Up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          )
        )
    );
  }
}
